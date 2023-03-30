import 'package:emetrix_flutter/app/core/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sondeo.dart';
import 'repository.dart';

class HomeService {
  final HomeRepository repository;
  HomeService(this.repository);

  Future<SondeoModel> getStores(String idTienda) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('loginInfo');
    final obj = Login.fromRawJson(data ?? '');

    debugPrint('USER ID--> ${obj.resp.usuario.id}');
    debugPrint('PROYECT ID--> ${obj.resp.proyectos.first.id}');

    final resp = await repository.getStores(obj.resp.usuario.id,
        obj.resp.proyectos.first.id, idTienda); //Mandar los ids para el sondeo
    return resp;
  }
}
