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
abstract class _$$_AddActCopyWith<$Res> implements $AddActStateCopyWith<$Res> {
  factory _$$_AddActCopyWith(_$_AddAct value, $Res Function(_$_AddAct) then) =
      __$$_AddActCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Stores? addActStores, States state});
}

/// @nodoc
class __$$_AddActCopyWithImpl<$Res>
    extends _$AddActStateCopyWithImpl<$Res, _$_AddAct>
    implements _$$_AddActCopyWith<$Res> {
  __$$_AddActCopyWithImpl(_$_AddAct _value, $Res Function(_$_AddAct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addActStores = freezed,
    Object? state = null,
  }) {
    return _then(_$_AddAct(
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

class _$_AddAct implements _AddAct {
  const _$_AddAct({this.addActStores, this.state = States.loading});

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
            other is _$_AddAct &&
            (identical(other.addActStores, addActStores) ||
                other.addActStores == addActStores) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, addActStores, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddActCopyWith<_$_AddAct> get copyWith =>
      __$$_AddActCopyWithImpl<_$_AddAct>(this, _$identity);
}

abstract class _AddAct implements AddActState {
  const factory _AddAct({final Stores? addActStores, final States state}) =
      _$_AddAct;

  @override
  Stores? get addActStores;
  @override
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$_AddActCopyWith<_$_AddAct> get copyWith =>
      throw _privateConstructorUsedError;
}
