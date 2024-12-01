import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/ui/modules/login/controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/service.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:emetrix_flutter/app/core/global/core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

final routeOTD =
    StateNotifierProvider<RouteOTDControllerNotifier, RouteOTDState>((ref) {
  final service = ref.watch(sondeoServiceProvider);
  return RouteOTDControllerNotifier(service);
});

class RouteOTDControllerNotifier extends StateNotifier<RouteOTDState> {
  final HomeService sondeoService;
  RouteOTDControllerNotifier(this.sondeoService) : super(const RouteOTDState());
 
  Future<int> _getUserID() async {
    //Get User ID
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');
    final userInfo = Resp.fromRawJson(userData ?? '');
    return int.parse(userInfo.usuario.id);
  }

  Future<List<SondeosFromStore>> getStoresFromIsar(WidgetRef ref) async {
    state = state.copyWith(state: States.loading);
    final userID = await _getUserID();
    var stores = await ref.watch(databaseProvider).getStores(userID: userID);

    final storesfromsrv = await ref.read(loginControllerProvider.notifier).getStores();
    
    if (stores.isNotEmpty) {

      stores.forEach((element) {
        storesfromsrv.resp?.forEach((storesrv) {
             element.store!.checkGPS = storesrv.checkGPS;
             if(element.store!.id == storesrv.id ){
                 element.store!.rangoGPS = storesrv.rangoGPS; 
             }
             
        });
      });
    
      
            
      
      state = state.copyWith(data: stores, state: States.succes);
      return stores;
    }
    state = state.copyWith(data: stores, state: States.error);
    return [];
  }

 /* Future<List<SondeosFromStore>> getStoresFromIsar(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    var userStore = prefs.getString("lastUserId"); //save List
    final userID = await _getUserID();
    List<SondeosFromStore> stores = await ref.watch(databaseProvider).getStores(userID: userID);
    state = state.copyWith(state: States.loading);

    var existList = prefs.containsKey(userStore ?? '');
    var filterStore = prefs.getStringList(userStore ?? '');
     logger.d("Tiendas User $userStore Stores$filterStore store $stores");
    if(existList && filterStore!.isNotEmpty && stores.isNotEmpty){
      stores = stores.where((s) =>
                  filterStore?.contains(s.store?.id.toString()) ?? false
        ).toList();
         logger.d("Tiendas User $userStore Stores$filterStore store $stores");
         state = state.copyWith(data: stores, state: States.succes);
      return stores;
    }
    /*else if (stores.isNotEmpty) {
       state = state.copyWith(data: stores, state: States.succes);
       return stores;
    }*/
    else{
     state = state.copyWith(data: stores, state: States.error);
    return [];
    }

  }*/

  Future<void> deleteItem(int id, WidgetRef ref) async {
    final userID = await _getUserID();
    final stores = await ref.watch(databaseProvider).getStores(userID: userID);
    stores.removeWhere((element) => element.id == id);
    final success = await ref.watch(databaseProvider).deleteStore(id);
    if (stores.isEmpty) {
      state = state.copyWith(state: States.error);
      return;
    }

    if (success) {
      state = state.copyWith(state: States.succes);
      return;
    }
    //Mostrar mensaje de error al eliminar en este caso
  }

  Future<SondeoModel> getSondeo2(String idTienda) async {
    final sondeo = sondeoService.getStores(idTienda);
    return sondeo;
  }

  // Future<List<SondeoModel>> getSondeoFromDB() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String>? sondeos = prefs.getStringList('sondeos');
  //   final List<SondeoModel> sondeosObj = [];

  //   if (sondeos != null) {
  //     for (var element in sondeos) {
  //       sondeosObj.add(SondeoModel.fromJson(jsonDecode(element)));
  //     }
  //   } else {
  //     debugPrint('SHARED ERROR sondeos: Error get in db');
  //   }
  //   return sondeosObj;
  // }

//
}
