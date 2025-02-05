// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_item_extra_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TreeItemExtraData _$TreeItemExtraDataFromJson(Map<String, dynamic> json) {
  return _TreeItemExtraData.fromJson(json);
}

/// @nodoc
mixin _$TreeItemExtraData {
  String? get searchableText => throw _privateConstructorUsedError;
  String? get ancestorId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isCritical => throw _privateConstructorUsedError;
  bool get isEnergy => throw _privateConstructorUsedError;
  LocationAssetsType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TreeItemExtraDataCopyWith<TreeItemExtraData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeItemExtraDataCopyWith<$Res> {
  factory $TreeItemExtraDataCopyWith(
          TreeItemExtraData value, $Res Function(TreeItemExtraData) then) =
      _$TreeItemExtraDataCopyWithImpl<$Res, TreeItemExtraData>;
  @useResult
  $Res call(
      {String? searchableText,
      String? ancestorId,
      String name,
      bool isCritical,
      bool isEnergy,
      LocationAssetsType type});
}

/// @nodoc
class _$TreeItemExtraDataCopyWithImpl<$Res, $Val extends TreeItemExtraData>
    implements $TreeItemExtraDataCopyWith<$Res> {
  _$TreeItemExtraDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchableText = freezed,
    Object? ancestorId = freezed,
    Object? name = null,
    Object? isCritical = null,
    Object? isEnergy = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      searchableText: freezed == searchableText
          ? _value.searchableText
          : searchableText // ignore: cast_nullable_to_non_nullable
              as String?,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isCritical: null == isCritical
          ? _value.isCritical
          : isCritical // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnergy: null == isEnergy
          ? _value.isEnergy
          : isEnergy // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocationAssetsType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TreeItemExtraDataImplCopyWith<$Res>
    implements $TreeItemExtraDataCopyWith<$Res> {
  factory _$$TreeItemExtraDataImplCopyWith(_$TreeItemExtraDataImpl value,
          $Res Function(_$TreeItemExtraDataImpl) then) =
      __$$TreeItemExtraDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? searchableText,
      String? ancestorId,
      String name,
      bool isCritical,
      bool isEnergy,
      LocationAssetsType type});
}

/// @nodoc
class __$$TreeItemExtraDataImplCopyWithImpl<$Res>
    extends _$TreeItemExtraDataCopyWithImpl<$Res, _$TreeItemExtraDataImpl>
    implements _$$TreeItemExtraDataImplCopyWith<$Res> {
  __$$TreeItemExtraDataImplCopyWithImpl(_$TreeItemExtraDataImpl _value,
      $Res Function(_$TreeItemExtraDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchableText = freezed,
    Object? ancestorId = freezed,
    Object? name = null,
    Object? isCritical = null,
    Object? isEnergy = null,
    Object? type = null,
  }) {
    return _then(_$TreeItemExtraDataImpl(
      searchableText: freezed == searchableText
          ? _value.searchableText
          : searchableText // ignore: cast_nullable_to_non_nullable
              as String?,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isCritical: null == isCritical
          ? _value.isCritical
          : isCritical // ignore: cast_nullable_to_non_nullable
              as bool,
      isEnergy: null == isEnergy
          ? _value.isEnergy
          : isEnergy // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LocationAssetsType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TreeItemExtraDataImpl implements _TreeItemExtraData {
  const _$TreeItemExtraDataImpl(
      {this.searchableText,
      this.ancestorId,
      required this.name,
      this.isCritical = false,
      this.isEnergy = false,
      required this.type});

  factory _$TreeItemExtraDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreeItemExtraDataImplFromJson(json);

  @override
  final String? searchableText;
  @override
  final String? ancestorId;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isCritical;
  @override
  @JsonKey()
  final bool isEnergy;
  @override
  final LocationAssetsType type;

  @override
  String toString() {
    return 'TreeItemExtraData(searchableText: $searchableText, ancestorId: $ancestorId, name: $name, isCritical: $isCritical, isEnergy: $isEnergy, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreeItemExtraDataImpl &&
            (identical(other.searchableText, searchableText) ||
                other.searchableText == searchableText) &&
            (identical(other.ancestorId, ancestorId) ||
                other.ancestorId == ancestorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isCritical, isCritical) ||
                other.isCritical == isCritical) &&
            (identical(other.isEnergy, isEnergy) ||
                other.isEnergy == isEnergy) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, searchableText, ancestorId, name,
      isCritical, isEnergy, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TreeItemExtraDataImplCopyWith<_$TreeItemExtraDataImpl> get copyWith =>
      __$$TreeItemExtraDataImplCopyWithImpl<_$TreeItemExtraDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreeItemExtraDataImplToJson(
      this,
    );
  }
}

abstract class _TreeItemExtraData implements TreeItemExtraData {
  const factory _TreeItemExtraData(
      {final String? searchableText,
      final String? ancestorId,
      required final String name,
      final bool isCritical,
      final bool isEnergy,
      required final LocationAssetsType type}) = _$TreeItemExtraDataImpl;

  factory _TreeItemExtraData.fromJson(Map<String, dynamic> json) =
      _$TreeItemExtraDataImpl.fromJson;

  @override
  String? get searchableText;
  @override
  String? get ancestorId;
  @override
  String get name;
  @override
  bool get isCritical;
  @override
  bool get isEnergy;
  @override
  LocationAssetsType get type;
  @override
  @JsonKey(ignore: true)
  _$$TreeItemExtraDataImplCopyWith<_$TreeItemExtraDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
