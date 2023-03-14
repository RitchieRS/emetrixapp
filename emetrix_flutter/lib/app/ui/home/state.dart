import 'package:emetrix_flutter/app/core/home/home.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    SondeoModel? homeData,
    @Default(States.loading) States state,
  }) = _HomeState;
}

enum States { succes, error, loading }
