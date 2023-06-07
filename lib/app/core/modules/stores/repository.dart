import 'dart:convert';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoresRepository {
  //
  Future<Stores> getStores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');
    final userInfo = Resp.fromRawJson(userData ?? '');

    final url = Uri.parse('/descargar_tiendas.php').replace(queryParameters: {
      'idProyecto': userInfo.proyectos.first.id, //'366',
      'idUsuario': userInfo.usuario.id, //'8775',
    });

    try {
      final response = await dio.getUri(url);
      logger.d('Stores StatusCode: ${response.statusCode}');
      final Stores stores = Stores.fromJson(jsonDecode(response.data));
      return stores;
      //
    } catch (error) {
      logger.d('Error Stores: ${error.toString()}}');
      return Stores(idError: 1, resp: []);
    }
  }
}
