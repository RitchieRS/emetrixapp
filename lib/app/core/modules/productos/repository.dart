import 'dart:convert';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductosRepository {
  //
  Future<ProductosJson> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');
    final userInfo = Resp.fromRawJson(userData ?? '');

    final url = Uri.parse('/descargar_productos_x_proyecto.php').replace(queryParameters: {
      'idProyecto': userInfo.proyectos.first.id, //'366',
      'idUsuario': userInfo.usuario.id, //'8775',
    });
   
    try {
      final response = await dio.getUri(url);
       
      logger.d('Productos ProductosRepository ${response.statusCode}');
      logger.d('Productos ProductosRepository ${response.data}');
      final ProductosJson productos = ProductosJson.fromJson(jsonDecode(response.data));
      logger.d('Productos ProductosRepository $productos');
      return productos;
      //
    } catch (error) {
      logger.d('Error Productos : ${error.toString()}}');
      return ProductosJson (idError: 1, resp: null );
    }
  }
}
