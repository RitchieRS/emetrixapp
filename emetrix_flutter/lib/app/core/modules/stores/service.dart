import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'repository.dart';

class StoresService {
  final StoresRepository repository;
  StoresService(this.repository);

  Future<Stores> getStores() async {
    final response = await repository.getStores();
    final List<Store?> mainStores = [];
    response.resp?.forEach(
      (store) {
        if (store?.definirNombre == 0) {
          mainStores.add(store);
        }
      },
    );
    final Stores stores = Stores(idError: response.idError, resp: mainStores);
    return stores;
  }

  Future<Stores> getAditionalStores() async {
    final response = await repository.getStores();
    final List<Store?> mainStores = [];
    response.resp?.forEach(
      (store) {
        if (store?.definirNombre == 1) {
          mainStores.add(store);
        }
      },
    );
    final Stores stores = Stores(idError: response.idError, resp: mainStores);
    return stores;
  }
}
