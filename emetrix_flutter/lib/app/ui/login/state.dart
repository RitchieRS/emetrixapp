import 'package:emetrix_flutter/app/core/login/login.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    Login? loginData,
    @Default(States.loading) States state,
  }) = _LoginState;
}

enum States { succes, error, loading }
