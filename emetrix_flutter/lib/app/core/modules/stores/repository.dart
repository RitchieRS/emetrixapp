import 'dart:convert';
import 'package:emetrix_flutter/app/core/core.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';

class StoresRepository {
  //
  Future<Stores> getStores() async {
    final url = Uri.parse('/descargar_tiendas.php').replace(queryParameters: {
      'idProyecto': '366',
      'idUsuario': '8775',
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
