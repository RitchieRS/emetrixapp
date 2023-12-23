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
mixin _$RouteOTDState {
  List<SondeosFromStore> get data => throw _privateConstructorUsedError;
  States get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RouteOTDStateCopyWith<RouteOTDState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteOTDStateCopyWith<$Res> {
  factory $RouteOTDStateCopyWith(
          RouteOTDState value, $Res Function(RouteOTDState) then) =
      _$RouteOTDStateCopyWithImpl<$Res, RouteOTDState>;
  @useResult
  $Res call({List<SondeosFromStore> data, States state});
}

/// @nodoc
class _$RouteOTDStateCopyWithImpl<$Res, $Val extends RouteOTDState>
    implements $RouteOTDStateCopyWith<$Res> {
  _$RouteOTDStateCopyWithImpl(this._value, this._then);

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
              as List<SondeosFromStore>,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RouteOTDImplCopyWith<$Res>
    implements $RouteOTDStateCopyWith<$Res> {
  factory _$$RouteOTDImplCopyWith(
          _$RouteOTDImpl value, $Res Function(_$RouteOTDImpl) then) =
      __$$RouteOTDImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SondeosFromStore> data, States state});
}

/// @nodoc
class __$$RouteOTDImplCopyWithImpl<$Res>
    extends _$RouteOTDStateCopyWithImpl<$Res, _$RouteOTDImpl>
    implements _$$RouteOTDImplCopyWith<$Res> {
  __$$RouteOTDImplCopyWithImpl(
      _$RouteOTDImpl _value, $Res Function(_$RouteOTDImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? state = null,
  }) {
    return _then(_$RouteOTDImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SondeosFromStore>,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ));
  }
}

/// @nodoc

class _$RouteOTDImpl implements _RouteOTD {
  const _$RouteOTDImpl(
      {final List<SondeosFromStore> data = const [],
      this.state = States.loading})
      : _data = data;

  final List<SondeosFromStore> _data;
  @override
  @JsonKey()
  List<SondeosFromStore> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final States state;

  @override
  String toString() {
    return 'RouteOTDState(data: $data, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteOTDImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteOTDImplCopyWith<_$RouteOTDImpl> get copyWith =>
      __$$RouteOTDImplCopyWithImpl<_$RouteOTDImpl>(this, _$identity);
}

abstract class _RouteOTD implements RouteOTDState {
  const factory _RouteOTD(
      {final List<SondeosFromStore> data, final States state}) = _$RouteOTDImpl;

  @override
  List<SondeosFromStore> get data;
  @override
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$RouteOTDImplCopyWith<_$RouteOTDImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
