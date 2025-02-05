// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetImpl _$$AssetImplFromJson(Map<String, dynamic> json) => _$AssetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      locationId: json['locationId'] as String?,
      parentId: json['parentId'] as String?,
      sensorId: json['sensorId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      gatewayId: json['gatewayId'] as String?,
    );

Map<String, dynamic> _$$AssetImplToJson(_$AssetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locationId': instance.locationId,
      'parentId': instance.parentId,
      'sensorId': instance.sensorId,
      'sensorType': instance.sensorType,
      'status': instance.status,
      'gatewayId': instance.gatewayId,
    };
