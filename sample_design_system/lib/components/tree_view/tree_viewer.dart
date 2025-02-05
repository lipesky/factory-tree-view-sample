import 'package:sample_design_system/components/tree_view/tree_item.dart';
import 'package:sample_design_system/components/tree_view/tree_view_item_data.dart';
import 'package:flutter/material.dart';

class TreeViewer<T> extends StatefulWidget {
  final List<TreeViewItemData<T>> treeData;
  final Widget Function(BuildContext context, TreeViewItemData<T> data, bool isRoot) headerBuilder;
  const TreeViewer({
    required this.treeData,
    required this.headerBuilder,
    super.key,
  });

  @override
  State<TreeViewer<T>> createState() => _TreeViewerState<T>();
}

class _TreeViewerState<T> extends State<TreeViewer<T>> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.treeData.length,
        itemBuilder: (context, index){
          return TreeItem<T>(
            data: widget.treeData[index],
            headerBuilder: widget.headerBuilder,
            isRoot: true,
          );
        },
      );
  }
}
