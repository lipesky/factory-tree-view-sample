// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return _Asset.fromJson(json);
}

/// @nodoc
mixin _$Asset {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get locationId => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  String? get sensorId => throw _privateConstructorUsedError;
  String? get sensorType => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get gatewayId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res, Asset>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? locationId,
      String? parentId,
      String? sensorId,
      String? sensorType,
      String? status,
      String? gatewayId});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res, $Val extends Asset>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locationId = freezed,
    Object? parentId = freezed,
    Object? sensorId = freezed,
    Object? sensorType = freezed,
    Object? status = freezed,
    Object? gatewayId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorId: freezed == sensorId
          ? _value.sensorId
          : sensorId // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorType: freezed == sensorType
          ? _value.sensorType
          : sensorType // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      gatewayId: freezed == gatewayId
          ? _value.gatewayId
          : gatewayId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetImplCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$$AssetImplCopyWith(
          _$AssetImpl value, $Res Function(_$AssetImpl) then) =
      __$$AssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? locationId,
      String? parentId,
      String? sensorId,
      String? sensorType,
      String? status,
      String? gatewayId});
}

/// @nodoc
class __$$AssetImplCopyWithImpl<$Res>
    extends _$AssetCopyWithImpl<$Res, _$AssetImpl>
    implements _$$AssetImplCopyWith<$Res> {
  __$$AssetImplCopyWithImpl(
      _$AssetImpl _value, $Res Function(_$AssetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locationId = freezed,
    Object? parentId = freezed,
    Object? sensorId = freezed,
    Object? sensorType = freezed,
    Object? status = freezed,
    Object? gatewayId = freezed,
  }) {
    return _then(_$AssetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      locationId: freezed == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorId: freezed == sensorId
          ? _value.sensorId
          : sensorId // ignore: cast_nullable_to_non_nullable
              as String?,
      sensorType: freezed == sensorType
          ? _value.sensorType
          : sensorType // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      gatewayId: freezed == gatewayId
          ? _value.gatewayId
          : gatewayId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetImpl implements _Asset {
  const _$AssetImpl(
      {required this.id,
      required this.name,
      this.locationId,
      this.parentId,
      this.sensorId,
      this.sensorType,
      this.status,
      this.gatewayId});

  factory _$AssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? locationId;
  @override
  final String? parentId;
  @override
  final String? sensorId;
  @override
  final String? sensorType;
  @override
  final String? status;
  @override
  final String? gatewayId;

  @override
  String toString() {
    return 'Asset(id: $id, name: $name, locationId: $locationId, parentId: $parentId, sensorId: $sensorId, sensorType: $sensorType, status: $status, gatewayId: $gatewayId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.sensorId, sensorId) ||
                other.sensorId == sensorId) &&
            (identical(other.sensorType, sensorType) ||
                other.sensorType == sensorType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gatewayId, gatewayId) ||
                other.gatewayId == gatewayId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, locationId, parentId,
      sensorId, sensorType, status, gatewayId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      __$$AssetImplCopyWithImpl<_$AssetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetImplToJson(
      this,
    );
  }
}

abstract class _Asset implements Asset {
  const factory _Asset(
      {required final String id,
      required final String name,
      final String? locationId,
      final String? parentId,
      final String? sensorId,
      final String? sensorType,
      final String? status,
      final String? gatewayId}) = _$AssetImpl;

  factory _Asset.fromJson(Map<String, dynamic> json) = _$AssetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get locationId;
  @override
  String? get parentId;
  @override
  String? get sensorId;
  @override
  String? get sensorType;
  @override
  String? get status;
  @override
  String? get gatewayId;
  @override
  @JsonKey(ignore: true)
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
