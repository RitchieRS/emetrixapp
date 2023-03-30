import 'dart:convert';

import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/sondeo/service.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final routeOTD =
    StateNotifierProvider<RouteOTDControllerNotifier, RouteOTDState>((ref) {
  final service = ref.watch(sondeoServiceProvider);
  return RouteOTDControllerNotifier(service);
  // return RouteOTDControllerNotifier();
});

class RouteOTDControllerNotifier extends StateNotifier<RouteOTDState> {
  final HomeService sondeoService;

  RouteOTDControllerNotifier(this.sondeoService) : super(const RouteOTDState());

  Future<List<Store>> getStores() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? routes = prefs.getStringList('routes');
    final List<Store> stores = [];

    if (routes != null) {
      debugPrint('Exist stores in db: $routes ${routes.length}');
      for (var element in routes) {
        stores.add(Store.fromJson(jsonDecode(element)));
      }
      state = state.copyWith(data: stores, state: States.succes);
      return stores;
    } else {
      debugPrint('NULL LIST');
      state = state.copyWith(data: stores, state: States.error);
      return [];
    }
  }

  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? routes = prefs.getStringList('routes');

    routes?.removeAt(index);
    if (routes != null) {
      if (routes.isEmpty) {
        prefs.remove('routes');
        state = state.copyWith(state: States.error);
      } else {
        prefs.setStringList('routes', routes);
        state = state.copyWith(state: States.succes);
      }
    } else {
      debugPrint('SHARED ERROR: Error deleting in db');
    }
    return;
  }

  Future<SondeoModel> getSondeo(String idTienda) async {
    final sondeo = sondeoService.getStores(idTienda);
    return sondeo;
  }

//
}
