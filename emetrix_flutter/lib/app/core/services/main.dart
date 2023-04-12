import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emetrix_flutter/app/core/services/internet/conection_service.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';

class Services {
  static void checkConectivity() {
    Get.put<ConetionService>(ConetionService(), permanent: true);
  }

  static ThemeData setTheme({bool isDarkMode = false}) {
    return ThemeChanger().setTheme(isDarkMode: isDarkMode);
  }
}
