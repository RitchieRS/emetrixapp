import 'dart:convert';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/core/stores/service.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/addActivities/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final addActControllerProvider =
    StateNotifierProvider<AddActControllerNotifier, AddActState>((ref) {
  final service = ref.watch(storesServiceProvider);
  return AddActControllerNotifier(service);
});

class AddActControllerNotifier extends StateNotifier<AddActState> {
  final StoresService homeService;

  AddActControllerNotifier(this.homeService) : super(const AddActState());

  Future<List<Store>> getAllStoresFromDB() async {
    List<Store> stores = [];
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storesData = prefs.getStringList('storesData');
    debugPrint('L: $storesData');

    if (storesData != null) {
      for (String store in storesData) {
        stores.add(Store.fromJson(jsonDecode(store)));
      }
      state = state.copyWith(state: States.succes);
      return stores;
    } else {
      state = state.copyWith(state: States.error);
      return [];
    }
  }

  Future<List<Store>> getAdditionalStoresDB() async {
    List<Store> mainStores = [];
    final stores = await getAllStoresFromDB();
    debugPrint('LL: ${mainStores.length}');

    for (Store store in stores) {
      if (store.definirNombre == 1) {
        mainStores.add(store);
      }
    }

    debugPrint('LL2: ${mainStores.length}');
    return mainStores;
  }

//
}
