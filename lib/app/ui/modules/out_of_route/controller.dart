import 'dart:convert';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/login/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/modules/stores/service.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/state.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';

final outORControllerProvider =
    StateNotifierProvider<OutOfRouteControllerNotifier, OutOfRouteState>((ref) {
  final service = ref.watch(storesServiceProvider);
  return OutOfRouteControllerNotifier(service);
});

class OutOfRouteControllerNotifier extends StateNotifier<OutOfRouteState> {
  final StoresService homeService;

  OutOfRouteControllerNotifier(this.homeService)
      : super(const OutOfRouteState());

  Future<void> verifyStores(WidgetRef ref) async {
    final stores = await ref.watch(databaseProvider).getAllStores();

    if (stores.isEmpty) {
      state = state.copyWith(state: States.loading);
      await getStoresFromApi(ref);
      final stores = await ref.watch(databaseProvider).getAllStores();
      state = state.copyWith(state: States.succes, homeData: stores);
      return;
    }

    state = state.copyWith(state: States.succes, homeData: stores);
  }

  Future<List<StoreGeneral>> getAllStoresIsar(WidgetRef ref) async {
    List<StoreGeneral> stores = [];
    state = state.copyWith(state: States.loading);
    stores = await ref.watch(databaseProvider).getAllStores();

    if (stores.isNotEmpty) {
      state = state.copyWith(state: States.succes);
      return stores;
    }
    state = state.copyWith(state: States.error);
    return [];
  }

  Future<void> getStoresFromApi(WidgetRef ref) async {
    List<Store> allStores = [];
    final stores = await ref.read(loginControllerProvider.notifier).getStores();
    final storesAdditional =
        await ref.read(loginControllerProvider.notifier).getAditionalStores();

    stores.resp?.forEach((store) {
      allStores.add(store);
    });
    storesAdditional.resp?.forEach((store) {
      allStores.add(store);
    });

    await ref
        .read(loginControllerProvider.notifier)
        .saveStoresData(allStores, ref);
  }

  //----------------------

  List<RespM> _reorderList(List<RespM> list) {
    List<(int, RespM)> list2 = [];
    List<RespM> reorderList = [];

    //Clonacion de asistencia para checkout
    final checkin =
        list.firstWhere((element) => element.sondeo == 'Asistencia');
    String json = jsonEncode(checkin.toJson());
    final checkin2 = RespM.fromJson(jsonDecode(json));
    checkin2.sondeo = 'Salida';
    checkin2.orden = '1000';
    list.add(checkin2);

    for (var element in list) {
      final number = int.parse(element.orden ?? '');
      list2.add((number, element));
    }
    list2.sort((a, b) => a.$1.compareTo(b.$1));

    for (var element in list2) {
      reorderList.add(element.$2);
    }

    return reorderList;
  }

  List<SondeoModel> reorderSteps(List<SondeoModel> sondeos) {
    final List<SondeoModel> reorderStoreList = [];

    for (var element in sondeos) {
      final reorderList = _reorderList(element.resp ?? []);
      final temp = SondeoModel(resp: reorderList);
      reorderStoreList.add(temp);
    }

    return reorderStoreList;
  }

  Future<void> saveStoresToIsar(
    int userID,
    List<StoreGeneral> routes,
    List<SondeoModel> sondeos,
    WidgetRef ref,
  ) async {
    // final reorderSondeos = reorderSteps(sondeos);
    await ref.read(databaseProvider).saveStores(routes, sondeos, userID);
  }

  //----------------------

  Future<List<SondeoModel>?> getSondeosFromApi(
      List<StoreGeneral> routes, WidgetRef ref) async {
    List<SondeoModel> sondeos = [];
    // List<String> sondeos = [];

    try {
      //Obtener los sondeos
      for (StoreGeneral store in routes) {
        final sondeo =
            await ref.read(routeOTD.notifier).getSondeo2(store.id ?? '');
        if (sondeo.idError != 0) {
          return null;
        }
        sondeos.add(sondeo);
        // sondeos.add(jsonEncode(sondeo));
      }
      return sondeos;
    } catch (e) {
      throw Exception('Failed get sondeos from api: $e');
    }
  }

//
}

final cardProvider = StateProvider<bool>((ref) {
  return false;
});
