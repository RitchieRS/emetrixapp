import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/repository.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  final HomeRepository repository;
  HomeService(this.repository);

  Future<SondeoModel> getStores(String idTienda) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('loginInfo');
    final obj = Resp.fromRawJson(data ?? '');

    debugPrint('USER ID--> ${obj.usuario.id}');
    debugPrint('PROYECT ID--> ${obj.proyectos.first.id}');

    final resp = await repository.getSondeos(
        user: obj.usuario.id,
        proyect: obj.proyectos.first.id,
        store: idTienda); //Mandar los ids para el sondeo
    return resp;
  }
}
