import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

class Database {
  late Future<Isar> database;
  Database() {
    database = _openDatabase();
  }

  Future<Isar> _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([SondeosFromStoreSchema, StoreGeneralSchema],
          directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  //

  Future<void> saveStores(List<StoreGeneral> routes) async {
    final isar = await database;

    await isar.writeTxn(() async {
      for (StoreGeneral store in routes) {
        final storeG = Store2(
          checkGPS: store.checkGPS,
          clasificacion: store.clasificacion,
          definirNombre: store.definirNombre,
          id: store.id,
          idCadena: store.idCadena,
          idGrupo: store.idGrupo,
          latitud: store.latitud,
          longitud: store.longitud,
          rangoGPS: store.rangoGPS,
          tienda: store.tienda,
        );
        final isarStore = SondeosFromStore(
          store: storeG,
          progress: 0,
        );

        await isar.sondeosFromStores.put(isarStore); // insert & update
      }
    });
  }

  Future<List<SondeosFromStore>> getStores() async {
    final isar = await database;
    final list = await isar.sondeosFromStores.where().findAll();
    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

  Future<bool> deleteStore(int id) async {
    final isar = await database;
    bool deleted = false;
    await isar.writeTxn(() async {
      deleted = await isar.sondeosFromStores.delete(id);
    });
    return deleted;
  }

  //

  Future<void> saveAllStores(List<Store> stores) async {
    final isar = await database;

    await isar.writeTxn(() async {
      for (Store store in stores) {
        final isarStore = StoreGeneral(
          id: store.id,
          checkGPS: store.checkGPS,
          clasificacion: store.clasificacion,
          definirNombre: store.definirNombre,
          idCadena: store.idCadena,
          idGrupo: store.idGrupo,
          latitud: store.latitud,
          longitud: store.longitud,
          rangoGPS: store.rangoGPS,
          tienda: store.tienda,
        );

        await isar.storeGenerals.put(isarStore); // insert & update
      }
    });
  }

  Future<List<StoreGeneral>> getAllStores() async {
    final isar = await database;
    final list = await isar.storeGenerals.where().findAll();
    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

  //

  Future<void> clearDatabase() async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  //   Future<void> deleteItem(int index) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String>? routes = prefs.getStringList('routes');
  //   final List<String>? sondeos = prefs.getStringList('sondeos');

  //   routes?.removeAt(index);
  //   if (routes != null) {
  //     if (routes.isEmpty) {
  //       prefs.remove('routes');
  //       state = state.copyWith(state: States.error);
  //     } else {
  //       prefs.setStringList('routes', routes);
  //       state = state.copyWith(state: States.succes);
  //     }
  //   } else {
  //     debugPrint('SHARED ERROR: Error deleting in db');
  //   }

  //   sondeos?.removeAt(index);
  //   if (sondeos != null) {
  //     if (sondeos.isEmpty) {
  //       prefs.remove('sondeos');
  //       state = state.copyWith(state: States.error);
  //     } else {
  //       prefs.setStringList('sondeos', sondeos);
  //       state = state.copyWith(state: States.succes);
  //     }
  //   } else {
  //     debugPrint('SHARED ERROR sondeos: Error deleting in db');
  //   }

  //   return;
  // }
}
