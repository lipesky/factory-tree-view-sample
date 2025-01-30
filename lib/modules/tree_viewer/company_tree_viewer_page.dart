import 'package:factory_tree_viewer/modules/fake_service/fake_service.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/app_colors.dart';
import 'package:factory_tree_viewer/modules/shared/future_utils.dart';
import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:factory_tree_viewer/modules/shared/tractian_app_bar.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/LocationAssetsTreeHeader.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/filter_button.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/tree_viewer.dart';
import 'package:flutter/material.dart';

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
  Future<List<dynamic>> loading = PendingFuture<List<dynamic>>();
  bool filterEnergyTypeActive = false;
  bool filterCriticalActive = false;
  String searchText = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (time) => loadData(),
    );
  }

  void loadData() {
    assets = fakeService.getAssetsByCompanyId(widget.company.id);
    locations = fakeService.getLocationsByCompanyId(widget.company.id);
    setState(() {
      loading = Future.wait([assets, locations]);
    });
  }

  Widget locationHeaderBuilder(BuildContext context, Location location) {
    return LocationAssetsTreeHeader(
      location: location,
    );
  }

  Widget assetHeaderBuilder(BuildContext context, Asset asset) {
    return LocationAssetsTreeHeader(
      asset: asset,
    );
  }

  List<TreeViewItemData> getTreeData(
    BuildContext context,
    List<Location> locations,
    List<Asset> assets,
  ) {
    List<TreeViewItemData> roots = [];
    Map<String, TreeViewItemData> references = {};
    Map<TreeViewItemData, String> nonSetReferences = {};
    final bool hasAnyActiveFilter =
        filterCriticalActive || filterEnergyTypeActive || searchText.trim().isNotEmpty;
    for (final location in locations) {
      final TreeViewItemData data = TreeViewItemData(
        id: location.id,
        headerBuilder: (context) => locationHeaderBuilder(context, location),
        visible: !hasAnyActiveFilter,
        location: location,
      );
      references[location.id] = data;
      if (location.parentId == null) {
        roots.add(data);
      } else if (references[location.parentId] != null) {
        references[location.parentId]!.addChild(data);
      } else {
        nonSetReferences[data] = location.parentId!;
      }
    }
    for (final asset in assets) {
      final TreeViewItemData data = TreeViewItemData(
        id: asset.id,
        headerBuilder: (context) => assetHeaderBuilder(context, asset),
        visible: !hasAnyActiveFilter,
        asset: asset,
      );
      references[asset.id] = data;
      final String? ancestorId = asset.parentId ?? asset.locationId;
      if (ancestorId == null) {
        roots.add(data);
      } else if (references[ancestorId] != null) {
        references[ancestorId]!.addChild(data);
      } else {
        nonSetReferences[data] = ancestorId;
      }
    }

    while (nonSetReferences.isNotEmpty) {
      final List<String> toRemove = [];
      for (final ref in nonSetReferences.entries) {
        final TreeViewItemData data = ref.key;
        final String ancestorId = ref.value;
        if (references[ancestorId] != null) {
          toRemove.add(ancestorId);
          references[ancestorId]!.addChild(data);
        }
      }
      if (toRemove.isEmpty && nonSetReferences.isNotEmpty) {
        throw Exception(
            'Could not find parent objects for itens ids: ${nonSetReferences.values.toList().join(',')}');
        //break;
      }
      for (final String id in toRemove) {
        nonSetReferences.removeWhere((key, value) => value == id);
      }
    }

    // filter
    if (hasAnyActiveFilter) {
      for (final entry in references.entries) {
        final TreeViewItemData data = entry.value;
        String ancestorId = data.asset?.parentId ??
            data.asset?.locationId ??
            data.location?.parentId ??
            '';
        // energy filter
        bool valid = filterEnergyTypeActive &&
            data.asset != null &&
            data.asset!.sensorType == 'energy';
        // critical filter
        valid = valid ||
            filterCriticalActive &&
                data.asset != null &&
                data.asset!.status == 'alert';
        // text filter
        valid = valid ||
            (searchText.isNotEmpty &&
                (data.asset != null &&
                  data.asset!.name.toLowerCase().contains(searchText.toLowerCase().trim())
                ) ||
                (data.location != null &&
                  data.location!.name.toLowerCase().contains(searchText.toLowerCase().trim())
                )
            );
        if (valid) {
          data.setVisiblity(true);
          while (ancestorId.isNotEmpty) {
            references[ancestorId]!.setVisiblity(true);
            final TreeViewItemData ancestorData = references[ancestorId]!;
            ancestorId = ancestorData.asset?.parentId ??
                ancestorData.asset?.locationId ??
                ancestorData.location?.parentId ??
                '';
          }
        }
      }
    }

    return roots;
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
          child: FutureBuilder<List<dynamic>>(
            future: loading,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "There was an error while trying to load company data.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppMetrics.defaultSpacing),
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
                final List<Asset> assets = snapshot.data![0];
                final List<Location> locations = snapshot.data![1];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppMetrics.defaultSpacing),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [                          
                          Autocomplete<String>(
                            optionsBuilder: (textEdittingValue) {
                              return [];
                            },
                            onSelected: (val){
                              if(mounted){
                                setState((){
                                  searchText = val;
                                });
                              }
                              debugPrint('==> selected $val');
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
                                onEditingComplete: () {
                                  if(mounted){
                                    setState((){
                                      searchText = textEditingController.text;
                                    });
                                  }                             
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
                          const SizedBox(
                              height: AppMetrics.defaultSpacing * 0.5),
                          Row(
                            children: [
                              FilterButton(
                                asset: 'lib/assets/bolt.svg',
                                text: 'Sensor de Energia',
                                highlighted: filterEnergyTypeActive,
                                onPressed: () {
                                  setState(() {
                                    filterEnergyTypeActive =
                                        !filterEnergyTypeActive;
                                  });
                                },
                              ),
                              const SizedBox(
                                width: AppMetrics.defaultSpacing * 0.5,
                              ),
                              FilterButton(
                                asset: 'lib/assets/critical.svg',
                                text: 'Crítico',
                                highlighted: filterCriticalActive,
                                onPressed: () {
                                  setState(() {
                                    filterCriticalActive =
                                        !filterCriticalActive;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppMetrics.defaultSpacing),
                        child: TreeViewer(
                          treeData: getTreeData(context, locations, assets),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
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

class TreeViewItemData {
  final String id;
  final Widget Function(BuildContext) headerBuilder;
  late final List<TreeViewItemData> children;
  bool visible;
  final Asset? asset;
  final Location? location;
  TreeViewItemData({
    required this.id,
    required this.headerBuilder,
    this.visible = true,
    this.asset,
    this.location,
    List<TreeViewItemData>? children,
  }) {
    this.children = children ?? [];
  }

  void addChild(TreeViewItemData child) {
    children.add(child);
  }

  void setVisiblity(bool value) {
    visible = value;
  }
}
