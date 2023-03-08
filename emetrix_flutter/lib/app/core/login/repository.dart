import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class LoginRepository {
  Future<Login> requestAccess(
      {required String user, required String password}) async {
    //200--success
    try {
      final url = Uri.parse('https://emetrix.com.mx/tracker/login.php');
      final response =
          await http.post(url, body: {"usuario": user, "password": password});

      if (response.statusCode == 200) {
        debugPrint('Success Login${response.statusCode}');
        final responseLogin = Login.fromRawJson(response.body);
        return responseLogin;
      } else {
        debugPrint('Acces status: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('ERROR Access//////---- ${error.toString()}');
      return Login(
          idError: 1,
          resp: Resp(
              usuario: Usuario(
                  id: '',
                  fechaVencimiento: DateTime(0),
                  versionApp: 0,
                  versionAppHasbro: 0,
                  telefonosSoporte: '',
                  correosSoporte: ''),
              proyectos: [],
              versiones: []));
    }
    //
    return Login(
        idError: 1,
        resp: Resp(
            usuario: Usuario(
                id: '',
                fechaVencimiento: DateTime(0),
                versionApp: 0,
                versionAppHasbro: 0,
                telefonosSoporte: '',
                correosSoporte: ''),
            proyectos: [],
            versiones: []));
  }
}
