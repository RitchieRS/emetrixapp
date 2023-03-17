import 'package:emetrix_flutter/app/core/home/home.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    Stores? homeData,
    @Default(States.loading) States state,
  }) = _HomeState;
}

enum States { succes, error, loading }
