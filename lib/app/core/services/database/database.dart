import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
      return await Isar.open([SondeosFromStoreSchema, StoreGeneralSchema],
          directory: dir.path);
    }
    return Future.value(Isar.getInstance());
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

  Future<void> saveAllProductsDB(List<Productos> stores) async {
    final isar = await database;

    await isar.writeTxn(() async {
      for (Productos p in stores) {
        final productosIsar = ProductosIsar(
            idCategoria: p.idCategoria,
            idMarca: p.idMarca,
            sku: p.sku,
            nombre: p.nombre,
            descripcion: p.descripcion,
            precioMax: p.precioMax,
            precioMin: p.precioMin,
            precioProm: p.precioProm,
            precioPedido: p.precioPedido,
            fotoUrl: p.fotoUrl,
            unidadPedidos: p.unidadPedidos);

        await isar.productosIsars.put(productosIsar); // insert & update
      }
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
