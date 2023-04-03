import 'dart:convert';

import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/state.dart';
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
