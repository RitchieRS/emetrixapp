// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddActState {
  Stores? get addActStores => throw _privateConstructorUsedError;
  States get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddActStateCopyWith<AddActState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddActStateCopyWith<$Res> {
  factory $AddActStateCopyWith(
          AddActState value, $Res Function(AddActState) then) =
      _$AddActStateCopyWithImpl<$Res, AddActState>;
  @useResult
  $Res call({Stores? addActStores, States state});
}

/// @nodoc
class _$AddActStateCopyWithImpl<$Res, $Val extends AddActState>
    implements $AddActStateCopyWith<$Res> {
  _$AddActStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addActStores = freezed,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      addActStores: freezed == addActStores
          ? _value.addActStores
          : addActStores // ignore: cast_nullable_to_non_nullable
              as Stores?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddActImplCopyWith<$Res>
    implements $AddActStateCopyWith<$Res> {
  factory _$$AddActImplCopyWith(
          _$AddActImpl value, $Res Function(_$AddActImpl) then) =
      __$$AddActImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Stores? addActStores, States state});
}

/// @nodoc
class __$$AddActImplCopyWithImpl<$Res>
    extends _$AddActStateCopyWithImpl<$Res, _$AddActImpl>
    implements _$$AddActImplCopyWith<$Res> {
  __$$AddActImplCopyWithImpl(
      _$AddActImpl _value, $Res Function(_$AddActImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addActStores = freezed,
    Object? state = null,
  }) {
    return _then(_$AddActImpl(
      addActStores: freezed == addActStores
          ? _value.addActStores
          : addActStores // ignore: cast_nullable_to_non_nullable
              as Stores?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ));
  }
}

/// @nodoc

class _$AddActImpl implements _AddAct {
  const _$AddActImpl({this.addActStores, this.state = States.loading});

  @override
  final Stores? addActStores;
  @override
  @JsonKey()
  final States state;

  @override
  String toString() {
    return 'AddActState(addActStores: $addActStores, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddActImpl &&
            (identical(other.addActStores, addActStores) ||
                other.addActStores == addActStores) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addActStores, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddActImplCopyWith<_$AddActImpl> get copyWith =>
      __$$AddActImplCopyWithImpl<_$AddActImpl>(this, _$identity);
}

abstract class _AddAct implements AddActState {
  const factory _AddAct({final Stores? addActStores, final States state}) =
      _$AddActImpl;

  @override
  Stores? get addActStores;
  @override
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$AddActImplCopyWith<_$AddActImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
