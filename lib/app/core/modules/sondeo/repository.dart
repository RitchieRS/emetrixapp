import 'dart:convert';
import 'sondeo.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';

class HomeRepository {
  //
  Future<SondeoModel> getSondeos(
      {required String proyect,
      required String user,
      required String store}) async {
    final url = Uri.parse('/descargar_sondeos.php?').replace(queryParameters: {
      'idProyecto': proyect,
      'idUsuario': user,
      'idTienda': store,
    });

    try {
      final response = await dio.getUri(url);
      logger.d('Sondeo StatusCode: ${response.statusCode}');
      SondeoModel home = SondeoModel.fromJson(json.decode(response.data));
      return home;
    } catch (error, s) {
      logger.e('Error Sondeo: ${error.toString()}\n${s.toString()}');
      return SondeoModel(idError: 1, resp: []);
    }
  }
}
