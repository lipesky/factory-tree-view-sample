// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_item_extra_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TreeItemExtraDataImpl _$$TreeItemExtraDataImplFromJson(
        Map<String, dynamic> json) =>
    _$TreeItemExtraDataImpl(
      searchableText: json['searchableText'] as String?,
      ancestorId: json['ancestorId'] as String?,
      name: json['name'] as String,
      isCritical: json['isCritical'] as bool? ?? false,
      isEnergy: json['isEnergy'] as bool? ?? false,
      type: $enumDecode(_$LocationAssetsTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$TreeItemExtraDataImplToJson(
        _$TreeItemExtraDataImpl instance) =>
    <String, dynamic>{
      'searchableText': instance.searchableText,
      'ancestorId': instance.ancestorId,
      'name': instance.name,
      'isCritical': instance.isCritical,
      'isEnergy': instance.isEnergy,
      'type': _$LocationAssetsTypeEnumMap[instance.type]!,
    };

const _$LocationAssetsTypeEnumMap = {
  LocationAssetsType.location: 'location',
  LocationAssetsType.asset: 'asset',
  LocationAssetsType.component: 'component',
};
