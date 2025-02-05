import 'dart:async';
import 'dart:isolate';

import 'package:factory_tree_viewer/modules/company_viewer/tree_item_extra_data.dart';
import 'package:factory_tree_viewer/modules/fake_service/fake_service.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/client/future_utils.dart';
import 'package:flutter/material.dart';
import 'package:sample_design_system/common/constants/app_colors.dart';
import 'package:sample_design_system/common/constants/metrics.dart';
import 'package:sample_design_system/common/constants/svg_assets.dart';
import 'package:sample_design_system/components/appbars/tractian_app_bar.dart';
import 'package:sample_design_system/components/buttons/filter_button.dart';
import 'package:sample_design_system/components/misc/location_assets_item_type.dart';
import 'package:sample_design_system/components/misc/location_assets_tree_header.dart';
import 'package:sample_design_system/components/tree_view/tree_view_item_data.dart';
import 'package:sample_design_system/components/tree_view/tree_viewer.dart';

class CompanyTreeViewerPager extends StatefulWidget {
  final Company company;
  const CompanyTreeViewerPager({
    required this.company,
    super.key,
  });

  @override
  State<CompanyTreeViewerPager> createState() => _CompanyTreeViewerPagerState();
}

class _CompanyTreeViewerPagerState extends State<CompanyTreeViewerPager> {
  final FakeService fakeService = FakeService();
  Future<List<Asset>?> assets = PendingFuture<List<Asset>?>();
  Future<List<Location>?> locations = PendingFuture<List<Location>?>();
  Future<void> loading = PendingFuture<void>();
  bool filterEnergyTypeActive = false;
  bool filterCriticalActive = false;
  String searchText = '';
  Future<List<TreeViewItemData<TreeItemExtraData>>> treeData =
      PendingFuture<List<TreeViewItemData<TreeItemExtraData>>>();
  bool buttonsDisabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (time) => loadData(),
    );
  }

  void loadData() {
    buttonsDisabled = true;
    assets = fakeService.getAssetsByCompanyId(widget.company.id);
    locations = fakeService.getLocationsByCompanyId(widget.company.id);
    setState(() {
      loading = Future.wait([assets, locations]).then((values) async {
        final [assets as List<Asset>, locations as List<Location>] = values;
        await getTreeData(context, locations, assets);
        if (mounted) {
          setState(() {
            buttonsDisabled = false;
          });
        }
      });
    });
  }

  void rebuildTreeView([VoidCallback? callback]) async {
    setState(() {
      loading = Future.wait([assets, locations]).then((values) async {
        final [assets as List<Asset>, locations as List<Location>] = values;
        if (callback != null) {
          callback();
        }
        await getTreeData(context, locations, assets);
      });
    });
  }

  Widget headerBuilder(BuildContext context, TreeItemExtraData extraData,
      [bool isRoot = false]) {
    return LocationAssetsTreeHeader(
      name: extraData.name,
      type: extraData.type,
      hasAlert: extraData.isCritical,
      isEnergy: extraData.isEnergy,
      isRoot: isRoot,
    );
  }

  Future<List<TreeViewItemData<TreeItemExtraData>>> getTreeData(
    BuildContext context,
    List<Location> locations,
    List<Asset> assets,
  ) {
    // Just to use this local variables inside Isolate
    bool filterEnergyTypeActive = this.filterEnergyTypeActive;
    bool filterCriticalActive = this.filterCriticalActive;
    String searchText = this.searchText;

    final bool hasAnyActiveFilter = filterCriticalActive ||
        filterEnergyTypeActive ||
        searchText.trim().isNotEmpty;
    treeData = Isolate.run<List<TreeViewItemData<TreeItemExtraData>>>(() {
      List<TreeViewItemData<TreeItemExtraData>> roots = [];
      Map<String, TreeViewItemData<TreeItemExtraData>> references = {};
      List<TreeViewItemData<TreeItemExtraData>> nonSetReferences = [];
      for (final location in locations) {
        final bool isRoot = location.parentId == null;
        final TreeViewItemData<TreeItemExtraData> data =
            TreeViewItemData<TreeItemExtraData>(
          id: location.id,
          ancestorId: location.parentId,
          visible: !hasAnyActiveFilter,
          children: [],
          extra: TreeItemExtraData(
            name: location.name,
            searchableText: location.name,
            ancestorId: location.parentId,
            type: LocationAssetsType.location,
          ),
        );
        references[location.id] = data;
        if (isRoot) {
          roots.add(data);
        } else if (references[location.parentId] != null) {          
          references[location.parentId]!.children.add(data);
        } else {
          nonSetReferences.add(data);
        }
      }
      for (final asset in assets) {
        final String? ancestorId = asset.parentId ?? asset.locationId;
        final bool isRoot = ancestorId == null;
        final TreeViewItemData<TreeItemExtraData> data =
            TreeViewItemData<TreeItemExtraData>(
          id: asset.id,
          ancestorId: ancestorId,
          visible: !hasAnyActiveFilter,
          children: [],
          extra: TreeItemExtraData(
            name: asset.name,
            searchableText: asset.name,
            ancestorId: ancestorId,
            isEnergy: asset.sensorType == 'energy',
            isCritical: asset.status == 'alert',
            type: asset.sensorType != null
                ? LocationAssetsType.component
                : LocationAssetsType.asset,
          ),
        );
        references[asset.id] = data;
        if (isRoot) {
          roots.add(data);
        } else if (references[ancestorId] != null) {
          references[ancestorId]!.children.add(data);
        } else {
          nonSetReferences.add(data);
        }
      }

      while (nonSetReferences.isNotEmpty) {
        final List<String> toRemove = [];
        for (final TreeViewItemData<TreeItemExtraData> ref in nonSetReferences) {
          final String ancestorId = ref.ancestorId!;
          if (references[ancestorId] != null) {
            toRemove.add(ref.id);
            references[ancestorId]!.children.add(ref);
          }
        }
        if (toRemove.isEmpty && nonSetReferences.isNotEmpty) {
          throw Exception(
              'Could not find parent objects for itens ids: ${nonSetReferences.join(',')}');
        }
        for (final String id in toRemove) {
          nonSetReferences.removeWhere((data) => data.id == id);
        }
      }

      // filter
      if (hasAnyActiveFilter) {
        for (final entry in references.entries) {
          TreeViewItemData<TreeItemExtraData> data = entry.value;
          // energy filter
          bool valid = (filterEnergyTypeActive && data.extra!.isEnergy) || !filterEnergyTypeActive;
          // critical filter
          valid = valid && (
            !filterCriticalActive ||
            (filterCriticalActive && data.extra!.isCritical)
          );
          // text filter
          valid = valid && (
              searchText.isEmpty ||
              (searchText.isNotEmpty &&
                  data.extra!.searchableText != null &&
                  data.extra!.searchableText!
                      .toLowerCase()
                      .contains(searchText.toLowerCase().trim()))
          );
          if (valid) {
            data.visible = true;
            String? ancestorId = data.extra!.ancestorId;
            while (ancestorId != null) {
              references[ancestorId]!.visible = true;
              ancestorId = references[ancestorId]!.extra!.ancestorId;
            }
          }
        }
      }
      return roots;
    }).catchError((e) {
      debugPrint(
        '==> isolate error $e',
      );
      throw e;
    });
    if (mounted) {
      setState(() {});
    }
    return treeData;
  }

  void handleCriticalFilterButton() {
    setState(() {
      filterCriticalActive = !filterCriticalActive;
      buttonsDisabled = true;
    });
    rebuildTreeView(() {
      if (mounted) {
        setState(() {
          buttonsDisabled = false;
        });
      }
    });
  }

  void handleEnergyFilterButton() {
    setState(() {
      filterEnergyTypeActive = !filterEnergyTypeActive;
      buttonsDisabled = true;
    });
    rebuildTreeView(() {
      if (mounted) {
        setState(() {
          buttonsDisabled = false;
        });
      }
    });
  }

  void handleSearchTextChange(String value) {
    if (mounted) {
      setState(() {
        searchText = value.trim();
        buttonsDisabled = true;
      });
      rebuildTreeView(() {
        if (mounted) {
          setState(() {
            buttonsDisabled = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppBar(
        context,
        title: const Center(
          child: Text(
            'Assets',
            style: TextStyle(
              color: AppColors.titleColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            loadData();
            return await loading.then((_) => null);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppMetrics.defaultSpacing),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Autocomplete<String>(
                      optionsBuilder: (textEdittingValue) async {
                        if (textEdittingValue.text.trim().isEmpty) {
                          return [];
                        }
                        return ([...(await locations ?? []), ...(await assets ?? [])])
                            .where((dynamic e) => (e.name as String)
                                .toLowerCase()
                                .contains(textEdittingValue.text.toLowerCase()))
                            .map((dynamic e) => e.name);
                      },
                      fieldViewBuilder: (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          enabled: !buttonsDisabled,
                          onEditingComplete: () {
                            handleSearchTextChange(textEditingController.text);
                            onFieldSubmitted();
                            FocusScope.of(context).unfocus();
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.textHint,
                            ),
                            hintText: 'Buscar Ativo ou Local',
                            hintStyle: TextStyle(
                              color: AppColors.textHint,
                            ),
                            fillColor: AppColors.inputSurface,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppMetrics.defaultSpacing * 0.5),
                    Row(
                      children: [
                        FilterButton(
                          asset: SvgAssets.bolt,
                          enabled: !buttonsDisabled,
                          text: 'Sensor de Energia',
                          highlighted: filterEnergyTypeActive,
                          onPressed: handleEnergyFilterButton,
                        ),
                        const SizedBox(
                          width: AppMetrics.defaultSpacing * 0.5,
                        ),
                        FilterButton(
                          asset: SvgAssets.alert,
                          enabled: !buttonsDisabled,
                          text: 'Crítico',
                          highlighted: filterCriticalActive,
                          onPressed: handleCriticalFilterButton,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppMetrics.defaultSpacing),
                  child: FutureBuilder(
                    future: treeData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "There was an error while trying to load company data.\n${snapshot.error}",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                    height: AppMetrics.defaultSpacing),
                                OutlinedButton(
                                  onPressed: () {
                                    loadData();
                                  },
                                  child: const Text('Try again'),
                                )
                              ],
                            ),
                          );
                        }
                        return TreeViewer<TreeItemExtraData>(
                          treeData: snapshot.data!,
                          headerBuilder: (context, data, isRoot) =>
                              headerBuilder(context, data.extra!, isRoot),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NonSetReferencesWrapper {
  final String ancestorId;
  final TreeViewItemData data;
  NonSetReferencesWrapper({
    required this.ancestorId,
    required this.data,
  });
}
