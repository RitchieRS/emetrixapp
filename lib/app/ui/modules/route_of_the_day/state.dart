import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class RouteOTDState with _$RouteOTDState {
  const factory RouteOTDState({
    @Default([]) List<StoreIsar> data,
    @Default(States.loading) States state,
  }) = _RouteOTD;
}

enum States { succes, error, loading }
