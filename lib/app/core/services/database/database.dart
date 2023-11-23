import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});

class Database {
  final uuid = const Uuid();
  late Future<Isar> database;
  Database() {
    database = _openDatabase();
  }

  Future<Isar> _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        SondeosFromStoreSchema,
        StoreGeneralSchema,
        PendienteSchema,
        ProductosIsarSchema,
      ], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<bool> isStoreGeneralsEmpty() async {
    final isar = await database;
    final count = await isar.storeGenerals.count();
    if (count > 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isProductsEmpty() async {
    final isar = await database;
    final count = await isar.productosIsars.count();
    if (count > 0) {
      return false;
    } else {
      return true;
    }
  }

  //
  // Save SondeosFromStore
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
          totalProgress: 0,
          uuid: uuid.v4(),
        );

        await isar.sondeosFromStores.put(isarStore); // insert & update
      }
    });
  }

  //Get all sondeosFromStore
  Future<List<SondeosFromStore>> getStores() async {
    final isar = await database;
    final list = await isar.sondeosFromStores.where().findAll();
    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

  //Deleta an item from sondeosFromStore
  Future<bool> deleteStore(int id) async {
    final isar = await database;
    bool deleted = false;
    await isar.writeTxn(() async {
      final lenght = await isar.sondeosFromStores.count();
      if (lenght <= 1) {
        deleted = await isar.sondeosFromStores.delete(id);
        await isar.sondeosFromStores.clear();
        return deleted;
      }
      deleted = await isar.sondeosFromStores.delete(id);
    });
    return deleted;
  }

  //Insert data to an specific SondeoFromStore
  Future<void> updateSondeoFromStore(
      {required String storeUuid,
      required int stepIndex,
      required int stepsLenght,
      required double progress,
      required List<QuestionResponse> sondeoQuestionResponses}) async {
    final isar = await database;

    await isar.writeTxn(() async {
      final store = await isar.sondeosFromStores
          .filter()
          .uuidEqualTo(storeUuid)
          .findFirst();

      if (store == null) return;
      final step = SondeoCollection(
        indexStep: stepIndex,
        sondeos: sondeoQuestionResponses,
        sondeoProgress: progress,
      );

      //Save data the sondeos on db
      store.storeSteps = [...?store.storeSteps, step];
      //Save the totalProgress
      double totalProgress = 0;
      double sondeoProgress = 0;
      double stepProgress = 0;
      store.storeSteps?.forEach((element) {
        sondeoProgress = element.sondeoProgress ?? 0;
        stepProgress = (stepProgress + sondeoProgress);
      });
      totalProgress = stepProgress / sondeoQuestionResponses.length;
      store.totalProgress = totalProgress / stepsLenght;
      await isar.sondeosFromStores.put(store);

      //
    });
  }

  //SetCheckIn/Checkout
  Future<void> setCheckInOut(
      {required String storeUuid,
      required String lat,
      required String long,
      required String pic,
      required bool isCheckin}) async {
    final isar = await database;
    final checkinout = CheckInOut(latitud: lat, longitud: long, picture: pic);

    await isar.writeTxn(() async {
      final store = await isar.sondeosFromStores
          .filter()
          .uuidEqualTo(storeUuid)
          .findFirst();

      if (store == null) return;

      if (isCheckin) {
        store.checkIn = checkinout;
      } else {
        store.checkOut = checkinout;
      }

      await isar.sondeosFromStores.put(store);
      //
    });
  }

  //GetASpecificStoreByUuid
  Future<bool> existStoreData({required String storeUuid}) async {
    final isar = await database;
    final store = await isar.sondeosFromStores
        .filter()
        .uuidEqualTo(storeUuid)
        .findFirst();

    if (store == null) return false;
    return true;
  }

  //GetASpecificStoreByUuid
  Future<SondeosFromStore?> getStoreByUuid({required String storeUuid}) async {
    final isar = await database;
    final store = await isar.sondeosFromStores
        .filter()
        .uuidEqualTo(storeUuid)
        .findFirst();

    if (store == null) return null;
    return store;
  }

  //SavePending
  Future<void> savePending(Pendiente pending) async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.pendientes.put(pending); // insert & update
    });
  }

  //GetAllPendings
  Future<List<Pendiente>> getAllPendings() async {
    final isar = await database;
    final list = await isar.pendientes.where().findAll();
    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

  //DeletePending
  Future<bool> deletePending(int id) async {
    final isar = await database;
    bool deleted = false;
    await isar.writeTxn(() async {
      final lenght = await isar.pendientes.count();
      if (lenght <= 1) {
        deleted = await isar.pendientes.delete(id);
        await isar.pendientes.clear();
        return deleted;
      }
      deleted = await isar.pendientes.delete(id);
    });
    return deleted;
  }

  //
  //Save all stores available
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

  Future<void> saveAllProductsDB(List<Producto> listProducts) async {
    final isar = await database;
    final List<ProductosIsar> list = [];

    for (Producto product in listProducts) {
      final productosIsar = ProductosIsar(productos: product);
      list.add(productosIsar);
    }

    await isar.writeTxn(() async {
      await isar.productosIsars.putAll(list); // insert & update
    });
  }

  Future<List<ProductosIsar>> getAllProducts() async {
    final isar = await database;
    final list = await isar.productosIsars.where().findAll();
    if (list.isNotEmpty) {
      return list;
    }
    return [];
  }

//
}
