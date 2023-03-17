import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:flutter/rendering.dart';

class StoresRepository {
  Future<Stores> getStores() async {
    try {
      final response = await Dio().get(
          'https://emetrix.com.mx/tracker/descargar_tiendas.php?',
          queryParameters: {
            'idProyecto': '366',
            'idUsuario': '8775',
          });

      if (response.statusCode == 200) {
        debugPrint('SUCCES STORES ${response.statusCode}');
        final Stores stores = Stores.fromJson(jsonDecode(response.data));
        debugPrint('STORES ${stores.resp?.first?.toJson()}');

        return stores;
      } else {
        debugPrint('Failed get Stores${response.statusCode}');
      }
    } catch (e) {
      debugPrint('ERRO STORES $e}');
      return Stores(idError: 1, resp: []);
    }
    return Stores(idError: 1, resp: []);
  }
}
