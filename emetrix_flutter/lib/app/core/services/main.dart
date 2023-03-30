import 'package:emetrix_flutter/app/core/services/conection_service.dart';
import 'package:get/get.dart';

class Services {
  static void checkConectivity() {
    Get.put<ConetionService>(ConetionService(), permanent: true);
  }
}
