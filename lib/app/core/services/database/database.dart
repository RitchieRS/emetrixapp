import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
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
      return await Isar.open([
        SondeosFromStoreSchema,
        StoreGeneralSchema,
        PendienteIsarSchema,
        ProductosIsarSchema,
      ], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> clearSondeos() async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.sondeosFromStores.clear();
    });
  }

  Future<void> clearPendings() async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.pendienteIsars.clear();
    });
  }

  Future<void> clearStores() async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.storeGenerals.clear();
    });
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

  Future<void> setFinisedFlagOnStore({required String storeUuid}) async {
    final isar = await database;

    await isar.writeTxn(() async {
      final store = await isar.sondeosFromStores
          .filter()
          .uuidEqualTo(storeUuid)
          .findFirst();

      if (store == null) return;

      store.savedToPendings = true;

      //Save data the sondeos on db
      store.storeSteps = [...?store.storeSteps];
      await isar.sondeosFromStores.put(store);

      //
    });
  }

  Future<void> saveStepsState(
      {required String storeUuid, required StepsState state}) async {
    final isar = await database;

    await isar.writeTxn(() async {
      final store = await isar.sondeosFromStores
          .filter()
          .uuidEqualTo(storeUuid)
          .findFirst();

      if (store == null) return;

      store.finishedSections = state;

      //Save data the sondeos on db
      store.storeSteps = [...?store.storeSteps];
      await isar.sondeosFromStores.put(store);

      //
    });
  }

  //
  // Save SondeosFromStore
  Future<void> saveStores(
    List<StoreGeneral> routes,
    List<SondeoModel> sondeos,
    int userID,
  ) async {
    final isar = await database;
    final List<SondeosFromStore> list = [];

    for (StoreGeneral store in routes) {
      final index = routes.indexOf(store);

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
        userID: userID,
        store: storeG,
        totalProgress: 0,
        uuid: uuidU.v4(),
        storeSteps: null,
        sondeo: sondeos[index],
      );
      list.add(isarStore);
    }

    await isar.writeTxn(() async {
      await isar.sondeosFromStores.putAll(list); // insert & update
    });
  }

  //Get all sondeosFromStore
  Future<List<SondeosFromStore>> getStores({required int userID}) async {
    final isar = await database;
    final list =
        await isar.sondeosFromStores.filter().userIDEqualTo(userID).findAll();
    // .findAll();
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
  Future<void> saveStepData(
      {required String storeUuid,
      required String stepUuid,
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
        stepUuid: stepUuid,
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

  //Update data to an specific Step in a Sondeo
  Future<void> updateStepData(
      {required String storeUuid,
      required String stepUuid,
      required List<QuestionResponse> sondeoQuestionResponses}) async {
    final isar = await database;

    await isar.writeTxn(() async {
      final store = await isar.sondeosFromStores
          .filter()
          .uuidEqualTo(storeUuid)
          .findFirst();

      if (store == null) return;

      final responses = store.storeSteps
          ?.firstWhere((element) => element.stepUuid == stepUuid);

      responses?.sondeos?.forEach((element) {
        final index = responses.sondeos?.indexOf(element);

        //fusionar 2 listas con el mismo tamaño
        if (element.response != null &&
                sondeoQuestionResponses[index!].response == null ||
            element.response != null &&
                sondeoQuestionResponses[index!].response!.isEmpty) {
          return;
        }
        element.response = sondeoQuestionResponses[index!].response;
      });

      //Save data the sondeos on db
      store.storeSteps = [...?store.storeSteps];
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
  Future<SondeosFromStore?> getStoreByUuid({required String storeUuid}) async {
    final isar = await database;
    final store = await isar.sondeosFromStores
        .filter()
        .uuidEqualTo(storeUuid)
        .findFirst();

    if (store == null) return null;
    return store;
  }

//GetASpecificStoreByUuid
  Future<SondeosFromStore?> getStoreById({required int id}) async {
    final isar = await database;
    final store =
        await isar.sondeosFromStores.where().idEqualTo(id).findFirst();

    if (store == null) return null;
    return store;
  }

  //SavePending
  Future<void> savePending(PendienteIsar pending) async {
    final isar = await database;
    await isar.writeTxn(() async {
      await isar.pendienteIsars.put(pending); // insert & update
    });
  }

  //GetAllPendings
  Future<List<PendienteIsar>> getAllPendings() async {
    final isar = await database;
    final list = await isar.pendienteIsars.where().findAll();
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
      final lenght = await isar.pendienteIsars.count();
      if (lenght <= 1) {
        deleted = await isar.pendienteIsars.delete(id);
        await isar.pendienteIsars.clear();
        return deleted;
      }
      deleted = await isar.pendienteIsars.delete(id);
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
