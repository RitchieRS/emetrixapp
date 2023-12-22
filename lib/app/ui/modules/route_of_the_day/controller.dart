import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/service.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

final routeOTD =
    StateNotifierProvider<RouteOTDControllerNotifier, RouteOTDState>((ref) {
  final service = ref.watch(sondeoServiceProvider);
  return RouteOTDControllerNotifier(service);
});

class RouteOTDControllerNotifier extends StateNotifier<RouteOTDState> {
  final HomeService sondeoService;
  RouteOTDControllerNotifier(this.sondeoService) : super(const RouteOTDState());
 
  Future<List<SondeosFromStore>> getStoresFromIsar(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    var userStore = prefs.getString("lastUserId"); //save List
    List<SondeosFromStore> stores = await ref.watch(databaseProvider).getStores();
    state = state.copyWith(state: States.loading);

   
    var existList = prefs.containsKey(userStore ?? '');
    var filterStore = prefs.getStringList(userStore ?? '');
     logger.d("Tiendas User $userStore Stores$existList");
    if(existList && stores.isNotEmpty){
      stores = stores.where((s) =>
                  filterStore?.contains(s.store?.id.toString()) ?? false
        ).toList();
         logger.d("Tiendas User $userStore Stores$filterStore");
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
    
  }

  Future<void> deleteItem(int id, WidgetRef ref) async {
    final stores = await ref.watch(databaseProvider).getStores();
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
