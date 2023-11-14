import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendings_resp.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'state.dart';

final pendingsController =
    StateNotifierProvider<PendingsControllerNotifier, PendingsState>((ref) {
  final service = ref.watch(pendingsServiceProvider);
  return PendingsControllerNotifier(service);
});

class PendingsControllerNotifier extends StateNotifier<PendingsState> {
  final PendingsService pendingsService;
  PendingsControllerNotifier(this.pendingsService)
      : super(const PendingsState());

  Future<void> getPendings(WidgetRef ref) async {
    final pendings = await ref.read(databaseProvider).getAllPendings();
    if (pendings.isNotEmpty) {
      state = state.copyWith(data: pendings, state: States.succes);
      return;
    }
    state = state.copyWith(data: pendings, state: States.error);
  }

  Future<PendienteResp> sendPendings(Pendiente pending) async {
    final response = await pendingsService.sendPendings(pending);
    return response;
  }

  Future<bool> deletePending(int id, WidgetRef ref) async {
    final result = await ref.read(databaseProvider).deletePending(id);
    return result;
  }

//
}
