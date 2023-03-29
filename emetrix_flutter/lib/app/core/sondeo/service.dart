import 'package:emetrix_flutter/app/core/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sondeo.dart';
import 'repository.dart';

class HomeService {
  final HomeRepository repository;
  HomeService(this.repository);

  Future<SondeoModel> getStores() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('loginInfo');
    final obj = Login.fromRawJson(data ?? '');

    final resp = await repository.getStores(obj.resp.usuario.id,
        obj.resp.proyectos.first.id, 'tienda'); //Mandar los ids para el sondeo
    return resp;
  }
}
