import 'login.dart';
import 'package:emetrix_flutter/app/core/core.dart';

class LoginRepository {
  //
  Future<Login> requestAccess(
      {required String user, required String password}) async {
    final url = Uri.parse('/login.php').replace(queryParameters: {
      'usuario': user,
      'password': password,
    });

    try {
      final response = await dio.getUri(url);
      logger.d('Login StatusCode: ${response.statusCode}');
      final responseLogin = Login.fromRawJson(response.data);
      return responseLogin;
      //
    } catch (error) {
      logger.d('Error Access: ${error.toString()}');
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
  }
}
