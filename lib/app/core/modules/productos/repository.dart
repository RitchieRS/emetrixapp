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

    final url = Uri.parse('/descargar_productos_x_proyecto.php')
        .replace(queryParameters: {
      'idProyecto': userInfo.proyectos.first.id, //'366',
      'idUsuario': userInfo.usuario.id, //'8775',
    });

    try {
      final response = await dio.getUri(url);
      logger.d('Productos StatusCode: ${response.statusCode}');
      final productos = ProductosJson.fromRawJson(response.data);
      return productos;
      //
    } catch (error) {
      logger.e('Error Productos : ${error.toString()}');
      return ProductosJson(idError: 1, resp: RespProd(productos: []));
    }
  }
}
