import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
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

  Future<bool> init() async {
    return _getStores();
  }

  Future<bool> _getStores() async {
    final response = await homeService.getStores();
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      return false;
    } else {
      state = state.copyWith(state: States.succes, homeData: response);
      return true;
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
