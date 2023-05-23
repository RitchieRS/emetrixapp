import 'dart:convert';
import 'sondeo.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';

class HomeRepository {
  //
  Future<SondeoModel> getStores(
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
    } catch (error) {
      logger.d('Error Sondeo: ${error.toString()}');
      return SondeoModel(idError: 1, resp: []);
    }
  }
}
