import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/core/services/internet/conection_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Services {
  static void checkConectivity({required BuildContext context}) {
    final Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        MesagessService.showMessage(
            context: context,
            message: 'Sin Conexión',
            icon: Icons.wifi_off_outlined);
      }
      // else if (result == ConnectivityResult.wifi ||
      //     result == ConnectivityResult.mobile ||
      //     result == ConnectivityResult.ethernet) {
      //   ConetionService.showMessage(
      //       context: context, message: 'En Linea', icon: Icons.wifi);
      // }
    });
  }
}
