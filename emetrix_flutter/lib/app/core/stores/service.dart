import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'repository.dart';

class StoresService {
  final StoresRepository repository;
  StoresService(this.repository);

  Future<Stores> getStores() async {
    final resp = await repository.getStores();
    return resp;
  }
}
