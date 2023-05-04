import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentOptionProvider = StateProvider<int>((ref) => 0);

final sondeoController = StateNotifierProvider<Auth, dynamic>((_) => Auth(''));

class Auth extends StateNotifier {
  Auth(super.state);

  List<RespM> reorderList(List<RespM> list) {
    List<RespM> reoderedList = [];

    list.any((element) {
      if (element.sondeo == 'Asistencia') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'Tomar Fotografía') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'todo') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });
    list.any((element) {
      if (element.sondeo == 'FOTOS') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'VIDEOS') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'preguntas') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'SOS') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'cronometro 2') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'cronometro 4') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'Carga de Videos') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    list.any((element) {
      if (element.sondeo == 'NFC') {
        reoderedList.add(element);
        return true;
      } else {
        return false;
      }
    });

    // reoderedList.add(RespM(sondeo: 'Salida'));

    return reoderedList;
  }
}
