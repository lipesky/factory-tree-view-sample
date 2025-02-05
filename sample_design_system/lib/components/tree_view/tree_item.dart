import 'package:flutter/material.dart';
import 'package:sample_design_system/components/tree_view/tree_view_item_data.dart';

class TreeItem<T> extends StatelessWidget {
  final TreeViewItemData<T> data;
  final bool isRoot;
  final Widget Function(
          BuildContext context, TreeViewItemData<T> data, bool isRoot)
      headerBuilder;
  const TreeItem({
    required this.data,
    this.isRoot = false,
    required this.headerBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!data.visible) {
      return const SizedBox();
    }
    if (data.children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8).copyWith(left: isRoot ? 0 : 28),
        child: headerBuilder(context, data, false),
      );
    }
    return ExpansionTile(
      title: headerBuilder(context, data, false),
      shape: const Border(),
      tilePadding: const EdgeInsets.only(left: 5, right: 5),
      dense: true,
      visualDensity: const VisualDensity(
        vertical: -2,
        horizontal: VisualDensity.minimumDensity,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: data.children
          .map(
            (child) => Container(
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black.withOpacity(0.06),
                    width: 1,
                  ),
                ),
              ),
              child: TreeItem<T>(
                data: child,
                headerBuilder: headerBuilder,
              ),
            ),
          )
          .toList(),
    );
  }
}
