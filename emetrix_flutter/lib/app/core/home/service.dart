import 'home.dart';
import 'repository.dart';

class HomeService {
  final HomeRepository repository;
  HomeService(this.repository);

  Future<SondeoModel> getStores() async {
    final resp = await repository.getStores();
    return resp;
  }
}
