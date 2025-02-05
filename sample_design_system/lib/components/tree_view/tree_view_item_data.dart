import 'package:freezed_annotation/freezed_annotation.dart';
part 'tree_view_item_data.freezed.dart';

@unfreezed
class TreeViewItemData<T> with _$TreeViewItemData<T> {
  factory TreeViewItemData({
    required String id,
    String? ancestorId,
    @Default(true) bool visible,
    required List<TreeViewItemData<T>> children,
    T? extra,
  }) = _TreeViewItemData;
}
