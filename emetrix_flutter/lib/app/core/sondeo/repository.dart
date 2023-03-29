import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'sondeo.dart';

class HomeRepository {
  Future<SondeoModel> getStores(
      String proyect, String user, String store) async {
    try {
      final url =
          Uri.parse('https://emetrix.com.mx/tracker/descargar_sondeos.php?')
              .replace(queryParameters: {
        // 'idProyecto': '366',
        // 'idUsuario': '8779',
        // 'idTienda': '87687',
        'idProyecto': proyect,
        'idUsuario': user,
        'idTienda': store,
      });
      final response = await http.get(url);

      if (response.statusCode == 200) {
        debugPrint('SUCCES HOME${response.statusCode}');
        print('SUCCES HOME${response.body}');

        SondeoModel home = SondeoModel.fromJson(json.decode(response.body));
        print('HOME PARSEDs: ${home.toString()}');
        return home;
      } else {
        debugPrint('Failed get Stores${response.statusCode}');
      }
    } catch (e) {
      return SondeoModel(idError: 1, resp: []);
    }
    return SondeoModel(idError: 1, resp: []);
  }
}
