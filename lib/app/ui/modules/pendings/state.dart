import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';

part 'state.freezed.dart';

@freezed
class PendingsState with _$PendingsState {
  const factory PendingsState({
    @Default([]) List<PendienteIsar> data,
    @Default(States.loading) States state,
  }) = _Pendings;
}

enum States { succes, error, loading }
