import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AddActState with _$AddActState {
  const factory AddActState({
    Stores? addActStores,
    @Default(States.loading) States state,
  }) = _AddAct;
}

enum States { succes, error, loading }
