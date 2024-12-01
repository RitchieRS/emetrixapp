import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class OutOfRouteState with _$OutOfRouteState {
  const factory OutOfRouteState({
    List<StoreGeneral>? homeData,
    @Default(States.loading) States state,
  }) = _OutOfRoute;
}

enum States { succes, error, loading }
