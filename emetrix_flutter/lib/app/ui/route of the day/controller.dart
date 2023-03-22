import 'dart:convert';

import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routeOTD =
    StateNotifierProvider<RouteOTDControllerNotifier, RouteOTDState>((ref) {
  // final service = ref.watch(storesServiceProvider);
  // return RouteOTDControllerNotifier(service);
  return RouteOTDControllerNotifier();
});

class RouteOTDControllerNotifier extends StateNotifier<RouteOTDState> {
  // final StoresService homeService;

  RouteOTDControllerNotifier() : super(const RouteOTDState());

  Future<void> getStores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? routes = prefs.getStringList('routes');
    final List<Store> stores = [];
    debugPrint('Stores on shared: $routes');

    if (routes != null) {
      print('Stores saved on shared: $routes ${routes.length}');
      for (var element in routes) {
        stores.add(Store.fromJson(jsonDecode(element)));
      }
      state = state.copyWith(data: stores, state: States.succes);
    } else {
      debugPrint('NULL LIST');
      state = state.copyWith(data: stores, state: States.error);
    }
  }

//
}
