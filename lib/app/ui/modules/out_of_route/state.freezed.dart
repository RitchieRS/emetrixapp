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
mixin _$OutOfRouteState {
  Stores? get homeData => throw _privateConstructorUsedError;
  States get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OutOfRouteStateCopyWith<OutOfRouteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutOfRouteStateCopyWith<$Res> {
  factory $OutOfRouteStateCopyWith(
          OutOfRouteState value, $Res Function(OutOfRouteState) then) =
      _$OutOfRouteStateCopyWithImpl<$Res, OutOfRouteState>;
  @useResult
  $Res call({Stores? homeData, States state});
}

/// @nodoc
class _$OutOfRouteStateCopyWithImpl<$Res, $Val extends OutOfRouteState>
    implements $OutOfRouteStateCopyWith<$Res> {
  _$OutOfRouteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeData = freezed,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      homeData: freezed == homeData
          ? _value.homeData
          : homeData // ignore: cast_nullable_to_non_nullable
              as Stores?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OutOfRouteCopyWith<$Res>
    implements $OutOfRouteStateCopyWith<$Res> {
  factory _$$_OutOfRouteCopyWith(
          _$_OutOfRoute value, $Res Function(_$_OutOfRoute) then) =
      __$$_OutOfRouteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Stores? homeData, States state});
}

/// @nodoc
class __$$_OutOfRouteCopyWithImpl<$Res>
    extends _$OutOfRouteStateCopyWithImpl<$Res, _$_OutOfRoute>
    implements _$$_OutOfRouteCopyWith<$Res> {
  __$$_OutOfRouteCopyWithImpl(
      _$_OutOfRoute _value, $Res Function(_$_OutOfRoute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeData = freezed,
    Object? state = null,
  }) {
    return _then(_$_OutOfRoute(
      homeData: freezed == homeData
          ? _value.homeData
          : homeData // ignore: cast_nullable_to_non_nullable
              as Stores?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ));
  }
}

/// @nodoc

class _$_OutOfRoute implements _OutOfRoute {
  const _$_OutOfRoute({this.homeData, this.state = States.loading});

  @override
  final Stores? homeData;
  @override
  @JsonKey()
  final States state;

  @override
  String toString() {
    return 'OutOfRouteState(homeData: $homeData, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OutOfRoute &&
            (identical(other.homeData, homeData) ||
                other.homeData == homeData) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, homeData, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutOfRouteCopyWith<_$_OutOfRoute> get copyWith =>
      __$$_OutOfRouteCopyWithImpl<_$_OutOfRoute>(this, _$identity);
}

abstract class _OutOfRoute implements OutOfRouteState {
  const factory _OutOfRoute({final Stores? homeData, final States state}) =
      _$_OutOfRoute;

  @override
  Stores? get homeData;
  @override
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$_OutOfRouteCopyWith<_$_OutOfRoute> get copyWith =>
      throw _privateConstructorUsedError;
}
