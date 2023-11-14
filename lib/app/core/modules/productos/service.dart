import 'package:emetrix_flutter/app/core/modules/productos/productos.dart';
import 'package:emetrix_flutter/app/core/modules/productos/repository.dart';

class ProductosService {
  final ProductosRepository repository;
  ProductosService(this.repository);

  Future<ProductosJson> getProductsService() async {
    final response = await repository.getProducts();
    final List<Producto> mainProductos = [];
    for (var producto in response.resp.productos) {
      mainProductos.add(producto);
    }
    final ProductosJson productosJson = ProductosJson(
        idError: response.idError, resp: RespProd(productos: mainProductos));
    return productosJson;
  }
}
