import 'dart:convert';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendings_resp.dart';

class PendingsRepository {
  //
  Future<PendienteResp> sendPendings({required Pendiente pending}) async {
    final pendingJson = jsonEncode(pending);
    final url = Uri.parse('/enviar_pendiente.php').replace(queryParameters: {
      'params': pendingJson,
    });

    try {
      final response = await dio.postUri(url);
      logger.d('Pendings StatusCode: ${response.statusCode}');
      final result = PendienteResp.fromJson(jsonDecode(response.data));
      return result;
      //
    } catch (error) {
      logger.e('Error Send Pending: ${error.toString()}');
      return PendienteResp(idError: 1, resp: '');
    }
    //
  }
}
