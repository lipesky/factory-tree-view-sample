import 'package:factory_tree_viewer/modules/fake_service/fake_service.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/asset.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/fake_service/model/location.dart';
import 'package:factory_tree_viewer/modules/shared/app_colors.dart';
import 'package:factory_tree_viewer/modules/shared/future_utils.dart';
import 'package:factory_tree_viewer/modules/shared/metrics.dart';
import 'package:factory_tree_viewer/modules/shared/tractian_app_bar.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/LocationAssetsTreeHeader.dart';
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
      BuildContext context, List<Location> locations, List<Asset> assets) {
    List<TreeViewItemData> roots = [];
    Map<String, TreeViewItemData> references = {};
    Map<TreeViewItemData, String> nonSetReferences = {};
    for (final location in locations) {
      final TreeViewItemData data = TreeViewItemData(
        id: location.id,
        headerBuilder: (context) => locationHeaderBuilder(context, location),
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

    return roots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractianAppBar(
        context,
        title: const Center(
          child:  Text(
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
          child: Padding(
            padding: const EdgeInsets.all(AppMetrics.defaultSpacing),
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
                    children: [
                      SearchAnchor.bar(
                        suggestionsBuilder: (context, controller) {
                          return [
                            Text('Suggestion 1'),
                          ];
                        },
                      ),
                      TreeViewer(
                          treeData: getTreeData(context, locations, assets)),
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
  TreeViewItemData({
    required this.id,
    required this.headerBuilder,
    List<TreeViewItemData>? children,
  }){
    this.children = children ?? [];
  }

  addChild(TreeViewItemData child) {
    children.add(child);
  }
}
