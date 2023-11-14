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
mixin _$PendingsState {
  List<Pendiente> get data => throw _privateConstructorUsedError;
  States get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PendingsStateCopyWith<PendingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingsStateCopyWith<$Res> {
  factory $PendingsStateCopyWith(
          PendingsState value, $Res Function(PendingsState) then) =
      _$PendingsStateCopyWithImpl<$Res, PendingsState>;
  @useResult
  $Res call({List<Pendiente> data, States state});
}

/// @nodoc
class _$PendingsStateCopyWithImpl<$Res, $Val extends PendingsState>
    implements $PendingsStateCopyWith<$Res> {
  _$PendingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Pendiente>,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PendingsCopyWith<$Res>
    implements $PendingsStateCopyWith<$Res> {
  factory _$$_PendingsCopyWith(
          _$_Pendings value, $Res Function(_$_Pendings) then) =
      __$$_PendingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Pendiente> data, States state});
}

/// @nodoc
class __$$_PendingsCopyWithImpl<$Res>
    extends _$PendingsStateCopyWithImpl<$Res, _$_Pendings>
    implements _$$_PendingsCopyWith<$Res> {
  __$$_PendingsCopyWithImpl(
      _$_Pendings _value, $Res Function(_$_Pendings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? state = null,
  }) {
    return _then(_$_Pendings(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Pendiente>,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ));
  }
}

/// @nodoc

class _$_Pendings implements _Pendings {
  const _$_Pendings(
      {final List<Pendiente> data = const [], this.state = States.loading})
      : _data = data;

  final List<Pendiente> _data;
  @override
  @JsonKey()
  List<Pendiente> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final States state;

  @override
  String toString() {
    return 'PendingsState(data: $data, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pendings &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PendingsCopyWith<_$_Pendings> get copyWith =>
      __$$_PendingsCopyWithImpl<_$_Pendings>(this, _$identity);
}

abstract class _Pendings implements PendingsState {
  const factory _Pendings({final List<Pendiente> data, final States state}) =
      _$_Pendings;

  @override
  List<Pendiente> get data;
  @override
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$_PendingsCopyWith<_$_Pendings> get copyWith =>
      throw _privateConstructorUsedError;
}
