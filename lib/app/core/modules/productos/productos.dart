/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/

import 'package:isar/isar.dart';
part 'productos.g.dart';

@collection
class ProductosIsar {
  Id id = Isar.autoIncrement;
  Productos? productos;
  

  ProductosIsar({
    String? idCategoria,
    String? idMarca,
    String? sku,
    String? nombre,
    String? descripcion,
    double? precioMax,
    double? precioMin,
    int? precioProm,
    String? precioPedido,
    String? fotoUrl,
    String? unidadPedidos,
  });
}

@embedded
class Productos {
  String? idCategoria;
  String? idMarca;
  String? sku;
  String? nombre;
  String? descripcion;
  double? precioMax;
  double? precioMin;
  int? precioProm;
  String? precioPedido;
  String? fotoUrl;
  String? unidadPedidos;

  Productos(
      {this.idCategoria,
      this.idMarca,
      this.sku,
      this.nombre,
      this.descripcion,
      this.precioMax,
      this.precioMin,
      this.precioProm,
      this.precioPedido,
      this.fotoUrl,
      this.unidadPedidos});

  Productos.fromJson(Map<String, dynamic> json) {
    idCategoria = json['idCategoria'];
    idMarca = json['idMarca'];
    sku = json['sku'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    precioMax = json['precioMax'];
    precioMin = json['precioMin'];
    precioProm = json['precioProm'];
    precioPedido = json['precioPedido'];
    fotoUrl = json['fotoUrl'];
    unidadPedidos = json['unidadPedidos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategoria'] = this.idCategoria;
    data['idMarca'] = this.idMarca;
    data['sku'] = this.sku;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['precioMax'] = this.precioMax;
    data['precioMin'] = this.precioMin;
    data['precioProm'] = this.precioProm;
    data['precioPedido'] = this.precioPedido;
    data['fotoUrl'] = this.fotoUrl;
    data['unidadPedidos'] = this.unidadPedidos;
    return data;
  }
}

class ProductosJson {
  int? idError;
  List<Productos>? resp;

  ProductosJson({this.idError, this.resp});

  ProductosJson.fromJson(Map<String, dynamic> json) {
    idError = json['idError'];
    if (json['resp'] != null) {
      resp = <Productos>[];
      json['resp'].forEach((v) {
        resp!.add(Productos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idError'] = idError;
    data['resp'] = resp != null ? resp!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}

