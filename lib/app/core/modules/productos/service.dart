
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/productos/repository.dart';

class ProductosService {
  final ProductosRepository repository;
  ProductosService(this.repository);

  Future<ProductosJson> getProductsService() async {
    final response = await repository.getProducts();
    final ProductsResp? mainProductos = response.resp;
    final ProductosJson productosJson = ProductosJson(idError: response.idError, resp: mainProductos);
    return productosJson;
  }
}
