import 'package:emetrix_flutter/app/core/login/login.dart';
import 'package:emetrix_flutter/app/core/login/service.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/login/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> init(String name, String pass) async {
    return _sendRequest(name, pass);
  }

  Future<bool> _sendRequest(String name, String pass) async {
    //obtener la data del usuario
    final Login response = await loginService.sendAccess(name, pass);
    if (response.idError != 0) {
      state = state.copyWith(state: States.error);
      debugPrint('ERROR: ${response.idError}');
      return false;
    } else {
      //Guardar la data en shared
      final resp = response.resp;
      final obj = resp.toRawJson();
      await _saveUserData(obj);
      state = state.copyWith(state: States.succes, loginData: response);
      debugPrint('Login Success save to DB');
      return true;
    }
  }

  Future _saveUserData(String objToString) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');

    if (userData == null) {
      prefs.setString('loginInfo', objToString);
      debugPrint('LoginInfo added FIRST TIME SHARED');
    } else {
      debugPrint('LoginInfo EXIST');
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

  Future saveStoresData(List<String> stores) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('storesData', stores);
    debugPrint('STORES SET ON SHARED');
  }

  // _saveUserData(String objToString) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? userData = prefs.getString('user');

  //   if (userData == null) {
  //     prefs.setString('user', objToString);
  //     print('Addeed USERDATA FIRST TIME SHARED');
  //   } else {
  //     return;
  //   }
  //   state = state.copyWith(state: States.succes);
  // }
}

// //final authorize = StateNotifierProvider<Auth, bool>((_) => Auth(false));
// final userAuth = StateNotifierProvider<Auth, bool>((_) => Auth(false));
// final passAuth = StateNotifierProvider<Auth, bool>((_) => Auth(false));

// final obscurePassword = StateNotifierProvider<Auth, bool>((_) => Auth(true));
// final loading = StateNotifierProvider<Auth, bool>((_) => Auth(false));

// class Auth extends StateNotifier<bool> {
//   Auth(super.state);

//   bool ok() {
//     return state = true;
//   }

//   bool denied() {
//     return state = false;
//   }

//   bool refreshState() {
//     return state = !state;
//   }
// }

// final user =
//     StateNotifierProvider<SetColors, Color>((_) => SetColors(c.disabled));
// final pass =
//     StateNotifierProvider<SetColors, Color>((_) => SetColors(c.disabled));

// class SetColors extends StateNotifier<Color> {
//   SetColors(super.state);

//   Color defaul() {
//     return state = c.disabled;
//   }

//   Color ok() {
//     return state = c.primary;
//   }

//   Color denied() {
//     return state = c.error;
//   }
// }
