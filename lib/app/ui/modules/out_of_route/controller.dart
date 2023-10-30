import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<StoreGeneral>> getAllStoresIsar(WidgetRef ref) async {
    List<StoreGeneral> stores = [];
    state = state.copyWith(state: States.loading);
    await Future.delayed(const Duration(seconds: 1));
    stores = await ref.watch(databaseProvider).getAllStores();

    if (stores.isNotEmpty) {
      state = state.copyWith(state: States.succes);
      return stores;
    }
    state = state.copyWith(state: States.error);
    return [];
  }

  Future<void> saveStoresToIsar(
      List<StoreGeneral> routes, WidgetRef ref) async {
    await ref.watch(databaseProvider).saveStores(routes);
  }

  Future<List<String>?> getSondeosFromApi(
      List<StoreGeneral> routes, WidgetRef ref) async {
    List<String> sondeos = [];

    try {
      //Obtener los sondeos
      for (StoreGeneral store in routes) {
        final sondeo =
            await ref.read(routeOTD.notifier).getSondeo2(store.id ?? '');
        if (sondeo.idError != 0) {
          return null;
        }
        sondeos.add(jsonEncode(sondeo));
      }
      return sondeos;
    } catch (e) {
      throw Exception('Failed get sondeos from api: $e');
    }
  }

  Future<void> setSondeosToDB(List<String> sondeos) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedList = prefs.getStringList('sondeos');
    debugPrint('Saved Sondeos: $savedList');

    if (savedList != null) {
      savedList.addAll(sondeos);
      prefs
          .setStringList('sondeos', savedList)
          .whenComplete(() => debugPrint('Sondeos Added $sondeos'));
    } else {
      prefs
          .setStringList('sondeos', sondeos)
          .whenComplete(() => debugPrint('Sondeos Added FirstTime $sondeos'));
    }
  }

//
}

final cardProvider = StateProvider<bool>((ref) {
  return false;
});
