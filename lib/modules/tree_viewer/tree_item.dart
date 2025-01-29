import 'package:factory_tree_viewer/modules/tree_viewer/company_tree_viewer_page.dart';
import 'package:flutter/material.dart';

class TreeItem extends StatelessWidget {
  final TreeViewItemData data;
  final bool isRoot;
  const TreeItem({
    required this.data,
    this.isRoot = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (data.children.isEmpty) {
      return Padding(
        padding: isRoot ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 8).copyWith(left: 24),
        child: data.headerBuilder(context),
      );
    }
    return ExpansionTile(
      title: data.headerBuilder(context),
      shape: const Border(),
      tilePadding: const EdgeInsets.only(left: 5, right: 16),
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      children: data.children
          .map(
            (child) => Container(
              margin: const EdgeInsets.only(left: 16),
              // padding: const EdgeInsets.only(left: 8),
              decoration:  BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black.withOpacity(0.06),
                    width: 1,
                  ),
                ),
              ),
              child: TreeItem(
                data: child,
              ),
            ),
          )
          .toList(),
    );
  }
}
