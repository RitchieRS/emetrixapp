import 'dart:convert';

import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class StoresRepository {
  Future<Stores> getStores() async {
    try {
      final url =
          Uri.parse('https://emetrix.com.mx/tracker/descargar_tiendas.php')
              .replace(
                  queryParameters: {'idProyecto': '366', 'idUsuario': '8775'});

      final response = await http.get(url);

      if (response.statusCode == 200) {
        debugPrint('SUCCES STORES ${response.statusCode}');
        final Stores stores = Stores.fromJson(jsonDecode(response.body));
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
