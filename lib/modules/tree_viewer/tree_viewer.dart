import 'package:factory_tree_viewer/modules/tree_viewer/company_tree_viewer_page.dart';
import 'package:factory_tree_viewer/modules/tree_viewer/tree_item.dart';
import 'package:flutter/material.dart';

class TreeViewer extends StatefulWidget {
  final List<TreeViewItemData> treeData;
  const TreeViewer({
    required this.treeData,
    super.key,
  });

  @override
  State<TreeViewer> createState() => _TreeViewerState();
}

class _TreeViewerState extends State<TreeViewer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(
        children: widget.treeData.map(
          (data) {
            return TreeItem(data: data, isRoot: true);
          }
        ).toList(),
      ),
    );
  }
}
