import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required String id,
    required String name,
    String? parentId,
  }) = _Location;

  factory Location.fromJson(Map<String, Object?> json)
      => _$LocationFromJson(json);
}