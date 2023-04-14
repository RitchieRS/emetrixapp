import 'package:get/get.dart';
import 'package:emetrix_flutter/app/core/services/internet/conection_service.dart';

class Services {
  static void checkConectivity() {
    Get.put<ConetionService>(ConetionService(), permanent: true);
  }
}
