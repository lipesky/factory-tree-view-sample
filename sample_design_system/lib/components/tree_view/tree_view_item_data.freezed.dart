// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_view_item_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TreeViewItemData<T> {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String? get ancestorId => throw _privateConstructorUsedError;
  set ancestorId(String? value) => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  set visible(bool value) => throw _privateConstructorUsedError;
  List<TreeViewItemData<T>> get children => throw _privateConstructorUsedError;
  set children(List<TreeViewItemData<T>> value) =>
      throw _privateConstructorUsedError;
  T? get extra => throw _privateConstructorUsedError;
  set extra(T? value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TreeViewItemDataCopyWith<T, TreeViewItemData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeViewItemDataCopyWith<T, $Res> {
  factory $TreeViewItemDataCopyWith(
          TreeViewItemData<T> value, $Res Function(TreeViewItemData<T>) then) =
      _$TreeViewItemDataCopyWithImpl<T, $Res, TreeViewItemData<T>>;
  @useResult
  $Res call(
      {String id,
      String? ancestorId,
      bool visible,
      List<TreeViewItemData<T>> children,
      T? extra});
}

/// @nodoc
class _$TreeViewItemDataCopyWithImpl<T, $Res, $Val extends TreeViewItemData<T>>
    implements $TreeViewItemDataCopyWith<T, $Res> {
  _$TreeViewItemDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ancestorId = freezed,
    Object? visible = null,
    Object? children = null,
    Object? extra = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TreeViewItemData<T>>,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TreeViewItemDataImplCopyWith<T, $Res>
    implements $TreeViewItemDataCopyWith<T, $Res> {
  factory _$$TreeViewItemDataImplCopyWith(_$TreeViewItemDataImpl<T> value,
          $Res Function(_$TreeViewItemDataImpl<T>) then) =
      __$$TreeViewItemDataImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? ancestorId,
      bool visible,
      List<TreeViewItemData<T>> children,
      T? extra});
}

/// @nodoc
class __$$TreeViewItemDataImplCopyWithImpl<T, $Res>
    extends _$TreeViewItemDataCopyWithImpl<T, $Res, _$TreeViewItemDataImpl<T>>
    implements _$$TreeViewItemDataImplCopyWith<T, $Res> {
  __$$TreeViewItemDataImplCopyWithImpl(_$TreeViewItemDataImpl<T> _value,
      $Res Function(_$TreeViewItemDataImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ancestorId = freezed,
    Object? visible = null,
    Object? children = null,
    Object? extra = freezed,
  }) {
    return _then(_$TreeViewItemDataImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ancestorId: freezed == ancestorId
          ? _value.ancestorId
          : ancestorId // ignore: cast_nullable_to_non_nullable
              as String?,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TreeViewItemData<T>>,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$TreeViewItemDataImpl<T> implements _TreeViewItemData<T> {
  _$TreeViewItemDataImpl(
      {required this.id,
      this.ancestorId,
      this.visible = true,
      required this.children,
      this.extra});

  @override
  String id;
  @override
  String? ancestorId;
  @override
  @JsonKey()
  bool visible;
  @override
  List<TreeViewItemData<T>> children;
  @override
  T? extra;

  @override
  String toString() {
    return 'TreeViewItemData<$T>(id: $id, ancestorId: $ancestorId, visible: $visible, children: $children, extra: $extra)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TreeViewItemDataImplCopyWith<T, _$TreeViewItemDataImpl<T>> get copyWith =>
      __$$TreeViewItemDataImplCopyWithImpl<T, _$TreeViewItemDataImpl<T>>(
          this, _$identity);
}

abstract class _TreeViewItemData<T> implements TreeViewItemData<T> {
  factory _TreeViewItemData(
      {required String id,
      String? ancestorId,
      bool visible,
      required List<TreeViewItemData<T>> children,
      T? extra}) = _$TreeViewItemDataImpl<T>;

  @override
  String get id;
  set id(String value);
  @override
  String? get ancestorId;
  set ancestorId(String? value);
  @override
  bool get visible;
  set visible(bool value);
  @override
  List<TreeViewItemData<T>> get children;
  set children(List<TreeViewItemData<T>> value);
  @override
  T? get extra;
  set extra(T? value);
  @override
  @JsonKey(ignore: true)
  _$$TreeViewItemDataImplCopyWith<T, _$TreeViewItemDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
