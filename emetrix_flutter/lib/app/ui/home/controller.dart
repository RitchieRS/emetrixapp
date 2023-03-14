import 'package:emetrix_flutter/app/core/home/service.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/ui/home/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeControllerNotifier, HomeState>((ref) {
  final service = ref.watch(homeServiceProvider);
  return HomeControllerNotifier(service);
});

class HomeControllerNotifier extends StateNotifier<HomeState> {
  final HomeService loginService;

  HomeControllerNotifier(this.loginService) : super(const HomeState());

  Future<bool> init() async {
    return _getStores();
  }

  Future<bool> _getStores() async {
    //obtener el listado de accesos
    final response = await loginService.getStores();
    debugPrint('RES: ${response.resp}');
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      debugPrint('ERROR: ${response.idError}');
      return false;
    } else {
      state = state.copyWith(state: States.succes, homeData: response);
      debugPrint('HOME: ${response.idError}');
      return true;
    }
  }

//
}
