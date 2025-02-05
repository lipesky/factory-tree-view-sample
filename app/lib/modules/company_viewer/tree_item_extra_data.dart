import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sample_design_system/components/misc/location_assets_item_type.dart';
part 'tree_item_extra_data.freezed.dart';
part 'tree_item_extra_data.g.dart';

@freezed
class TreeItemExtraData with _$TreeItemExtraData {

  const factory TreeItemExtraData({
    String? searchableText,
    String? ancestorId,
    required String name, 
    @Default(false) bool isCritical,
    @Default(false) bool isEnergy,
    required LocationAssetsType type,
  }) =_TreeItemExtraData;

  factory TreeItemExtraData.fromJson(Map<String, Object?> json)
      => _$TreeItemExtraDataFromJson(json);
}