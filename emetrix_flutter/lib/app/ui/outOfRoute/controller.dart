import 'dart:convert';

import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/state.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final outORControllerProvider =
    StateNotifierProvider<OutOfRouteControllerNotifier, OutOfRouteState>((ref) {
  final service = ref.watch(storesServiceProvider);
  return OutOfRouteControllerNotifier(service);
});

class OutOfRouteControllerNotifier extends StateNotifier<OutOfRouteState> {
  final StoresService homeService;

  OutOfRouteControllerNotifier(this.homeService)
      : super(const OutOfRouteState());

  Future<List<Store>> getStoresDB() async {
    List<Store> stores = [];
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storesData = prefs.getStringList('storesData');

    if (storesData != null) {
      for (var store in storesData) {
        stores.add(Store.fromJson(jsonDecode(store)));
      }
      state = state.copyWith(state: States.succes);
      return stores;
    } else {
      state = state.copyWith(state: States.error);
      return [];
    }
  }

  Future setRoutesOTD(List<String> routes) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedList = prefs.getStringList('routes');
    debugPrint('SavedList $savedList');

    if (savedList != null) {
      if (savedList.isNotEmpty) {
        savedList.addAll(routes);
        prefs
            .setStringList('routes', savedList)
            .whenComplete(() => debugPrint('ROTD Added $routes'));
      }
    } else {
      prefs
          .setStringList('routes', routes)
          .whenComplete(() => debugPrint('ROTD Added FirstTime $routes'));
    }
  }

  Future<List<String>> getSondeosFromApi(
      List<Store> routes, WidgetRef ref) async {
    List<String> sondeos = [];

    try {
      //Obtener los sondeos
      for (Store element in routes) {
        final sondeo =
            await ref.read(routeOTD.notifier).getSondeo(element.id ?? '');
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

// final number = Provider<int>((_) => 0);

// final card = StateNotifierProvider<Auth, bool>((_) => Auth(false));

// class Auth extends StateNotifier<bool> {
//   Auth(super.state);

//   bool show() {
//     return state = true;
//   }

//   bool hide() {
//     return state = false;
//   }

//   bool refreshState() {
//     return state = !state;
//   }
// }

final cardProvider = StateProvider<bool>((ref) {
  return false;
});
