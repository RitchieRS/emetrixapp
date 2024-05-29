import 'dart:io';

import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendings_resp.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/respository.dart';

class PendingsService {
  final PendingsRepository repository;
  PendingsService(this.repository);

  Future setCheckInOutImages({
    required Pendiente pending,
    required File image,
  }) async {
    //   final result =
    await repository.setCheckInOutImages(pending: pending, image: image);
    // return result;
  }

  Future<PendienteResp> sendPendings(Pendiente pendiente) async {
    final result = await repository.sendPendings(pending: pendiente);
    return result;
  }
}
