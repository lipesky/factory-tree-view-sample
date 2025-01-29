import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
class Asset with _$Asset{
  const factory Asset({
    required String id,
    required String name,
    String? locationId,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
    String? gatewayId,
  }) = _Asset;

  factory Asset.fromJson(Map<String, Object?> json)
      => _$AssetFromJson(json);
}