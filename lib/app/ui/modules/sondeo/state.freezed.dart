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
mixin _$SondeoState {
// @Default([]) List<SondeosFromStore> data,
  States get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SondeoStateCopyWith<SondeoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SondeoStateCopyWith<$Res> {
  factory $SondeoStateCopyWith(
          SondeoState value, $Res Function(SondeoState) then) =
      _$SondeoStateCopyWithImpl<$Res, SondeoState>;
  @useResult
  $Res call({States state});
}

/// @nodoc
class _$SondeoStateCopyWithImpl<$Res, $Val extends SondeoState>
    implements $SondeoStateCopyWith<$Res> {
  _$SondeoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SondeoImplCopyWith<$Res>
    implements $SondeoStateCopyWith<$Res> {
  factory _$$SondeoImplCopyWith(
          _$SondeoImpl value, $Res Function(_$SondeoImpl) then) =
      __$$SondeoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({States state});
}

/// @nodoc
class __$$SondeoImplCopyWithImpl<$Res>
    extends _$SondeoStateCopyWithImpl<$Res, _$SondeoImpl>
    implements _$$SondeoImplCopyWith<$Res> {
  __$$SondeoImplCopyWithImpl(
      _$SondeoImpl _value, $Res Function(_$SondeoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$SondeoImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as States,
    ));
  }
}

/// @nodoc

class _$SondeoImpl implements _Sondeo {
  const _$SondeoImpl({this.state = States.loading});

// @Default([]) List<SondeosFromStore> data,
  @override
  @JsonKey()
  final States state;

  @override
  String toString() {
    return 'SondeoState(state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SondeoImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SondeoImplCopyWith<_$SondeoImpl> get copyWith =>
      __$$SondeoImplCopyWithImpl<_$SondeoImpl>(this, _$identity);
}

abstract class _Sondeo implements SondeoState {
  const factory _Sondeo({final States state}) = _$SondeoImpl;

  @override // @Default([]) List<SondeosFromStore> data,
  States get state;
  @override
  @JsonKey(ignore: true)
  _$$SondeoImplCopyWith<_$SondeoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
