import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';

class ConetionService extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
          messageText: Text('Sin conexión a Internet', style: t.textLight),
          isDismissible: true,
          duration: const Duration(seconds: 4),
          backgroundColor: c.black,
          icon: const Icon(Icons.wifi_off, color: Colors.white),
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 10,
          margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
          snackPosition: SnackPosition.TOP);
    } else {
      if (Get.isSnackbarOpen) {
        //Get.closeCurrentSnackbar();

        // Get.rawSnackbar(
        //     messageText: Text('En línea', style: t.textLight),
        //     isDismissible: true,
        //     duration: const Duration(seconds: 4),
        //     backgroundColor: c.black,
        //     icon: const Icon(Icons.wifi, color: Colors.white),
        //     snackStyle: SnackStyle.FLOATING,
        //     borderRadius: 10,
        //     margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
        //     snackPosition: SnackPosition.TOP);
      } else {
        Get.rawSnackbar(
            messageText: Text('En línea', style: t.textLight),
            isDismissible: true,
            duration: const Duration(seconds: 4),
            backgroundColor: c.black,
            icon: const Icon(Icons.wifi, color: Colors.white),
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 10,
            margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  //
}
