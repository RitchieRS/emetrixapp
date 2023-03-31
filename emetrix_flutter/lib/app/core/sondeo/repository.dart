import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'sondeo.dart';

class HomeRepository {
  Future<SondeoModel> getStores(
      {required String proyect,
      required String user,
      required String store}) async {
    try {
      final url = Uri.parse(
              // 'http://emetrix.com.mx/tracker/descargar_sondeos.php?idProyecto=366&idUsuario=8777&idTienda=87687'
              // 'https://emetrix.com.mx/tracker/descargar_sondeos.php?idProyecto=$proyect&idUsuario=$user&idTienda=$store'
              'https://emetrix.com.mx/tracker/descargar_sondeos.php?')
          .replace(queryParameters: {
        // 'idProyecto': '366',
        // 'idUsuario': '8779',
        // 'idTienda': '87687',
        'idProyecto': proyect,
        'idUsuario': user,
        'idTienda': store,
      });

      debugPrint('URL: $url');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        debugPrint('SUCCES HOME: ${response.statusCode}');
        debugPrint('SUCCES HOME: ${response.body}');

        SondeoModel home = SondeoModel.fromJson(json.decode(response.body));
        debugPrint('HOME PARSEDs: ${home.toString()}');
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
