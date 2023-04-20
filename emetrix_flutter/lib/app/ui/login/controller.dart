import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emetrix_flutter/app/core/core.dart';
import 'package:emetrix_flutter/app/core/login/login.dart';
import 'package:emetrix_flutter/app/core/login/service.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/login/state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginControllerNotifier, LoginState>((ref) {
  final service = ref.watch(loginServiceProvider);
  final service2 = ref.watch(storesServiceProvider);
  return LoginControllerNotifier(service, service2);
});

class LoginControllerNotifier extends StateNotifier<LoginState> {
  final LoginService loginService;
  final StoresService homeService;

  LoginControllerNotifier(this.loginService, this.homeService)
      : super(const LoginState());

  Future<bool> sendRequest(String name, String pass) async {
    final Login response = await loginService.sendAccess(name, pass);
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      logger.d('ERROR: ${response.idError}');
      return false;
    } else {
      final resp = response.resp;
      final obj = resp.toRawJson();
      await _saveUserDataToDB(obj);
      state = state.copyWith(state: States.succes, loginData: response);
      logger.d('Login Success save to DB');
      return true;
    }
  }

  Future<void> _saveUserDataToDB(String objToString) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');

    if (userData == null) {
      await prefs.setString('loginInfo', objToString);
      logger.d('LoginInfo added FIRST TIME SHARED');
    } else {
      logger.d('LoginInfo EXIST');
      return;
    }
    state = state.copyWith(state: States.succes);
  }

  Future<Stores> getStores() async {
    final response = await homeService.getStores();
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      return Stores(idError: 1, resp: []);
    } else {
      state = state.copyWith(state: States.succes);
      return response;
    }
  }

  Future<Stores> getAditionalStores() async {
    final response = await homeService.getAditionalStores();
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      return Stores(idError: 1, resp: []);
    } else {
      state = state.copyWith(state: States.succes);
      return response;
    }
  }

  Future<void> saveStoresData(List<String> stores) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('storesData', stores);
    logger.d('STORES SET ON SHARED');
  }

  //
}
