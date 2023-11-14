/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/

import 'dart:convert';

import 'package:isar/isar.dart';
part 'productos.g.dart';

@collection
class ProductosIsar {
  Id id = Isar.autoIncrement;
  Producto? productos;

  ProductosIsar({this.productos});
}

@embedded
class Producto {
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

  Producto({
    this.idCategoria,
    this.idMarca,
    this.sku,
    this.nombre,
    this.descripcion,
    this.precioMax,
    this.precioMin,
    this.precioProm,
    this.precioPedido,
    this.fotoUrl,
    this.unidadPedidos,
  });

  factory Producto.fromRawJson(String str) =>
      Producto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idCategoria: json["idCategoria"],
        idMarca: json["idMarca"],
        sku: json["sku"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precioMax: json["precioMax"]?.toDouble(),
        precioMin: json["precioMin"]?.toDouble(),
        precioProm: json["precioProm"],
        precioPedido: json["precioPedido"],
        fotoUrl: json["fotoUrl"],
        unidadPedidos: json["unidadPedidos"],
      );

  Map<String, dynamic> toJson() => {
        "idCategoria": idCategoria,
        "idMarca": idMarca,
        "sku": sku,
        "nombre": nombre,
        "descripcion": descripcion,
        "precioMax": precioMax,
        "precioMin": precioMin,
        "precioProm": precioProm,
        "precioPedido": precioPedido,
        "fotoUrl": fotoUrl,
        "unidadPedidos": unidadPedidos,
      };
}

// class Productos {
//   String? idCategoria;
//   String? idMarca;
//   String? sku;
//   String? nombre;
//   String? descripcion;
//   double? precioMax;
//   double? precioMin;
//   int? precioProm;
//   String? precioPedido;
//   String? fotoUrl;
//   String? unidadPedidos;

//   Productos(
//       {this.idCategoria,
//       this.idMarca,
//       this.sku,
//       this.nombre,
//       this.descripcion,
//       this.precioMax,
//       this.precioMin,
//       this.precioProm,
//       this.precioPedido,
//       this.fotoUrl,
//       this.unidadPedidos});

//   Productos.fromJson(Map<String, dynamic> json) {
//     idCategoria = json['idCategoria'];
//     idMarca = json['idMarca'];
//     sku = json['sku'];
//     nombre = json['nombre'];
//     descripcion = json['descripcion'];
//     precioMax = json['precioMax'];
//     precioMin = json['precioMin'];
//     precioProm = json['precioProm'];
//     precioPedido = json['precioPedido'];
//     fotoUrl = json['fotoUrl'];
//     unidadPedidos = json['unidadPedidos'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['idCategoria'] = idCategoria;
//     data['idMarca'] = idMarca;
//     data['sku'] = sku;
//     data['nombre'] = nombre;
//     data['descripcion'] = descripcion;
//     data['precioMax'] = precioMax;
//     data['precioMin'] = precioMin;
//     data['precioProm'] = precioProm;
//     data['precioPedido'] = precioPedido;
//     data['fotoUrl'] = fotoUrl;
//     data['unidadPedidos'] = unidadPedidos;
//     return data;
//   }
// }

//-----
class ProductosJson {
  final int idError;
  final RespProd resp;

  ProductosJson({
    required this.idError,
    required this.resp,
  });

  factory ProductosJson.fromRawJson(String str) =>
      ProductosJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductosJson.fromJson(Map<String, dynamic> json) => ProductosJson(
        idError: json["idError"],
        resp: RespProd.fromJson(json["resp"]),
      );

  Map<String, dynamic> toJson() => {
        "idError": idError,
        "resp": resp.toJson(),
      };
}

class RespProd {
  final List<Producto> productos;

  RespProd({
    required this.productos,
  });

  factory RespProd.fromRawJson(String str) =>
      RespProd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RespProd.fromJson(Map<String, dynamic> json) => RespProd(
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
      };
}




// class ProductosJson {
//   int? idError;
//   List<Productos>? resp;

//   ProductosJson({this.idError, this.resp});

//   ProductosJson.fromJson(Map<String, dynamic> json) {
//     idError = json['idError'];
//     if (json['resp'] != null) {
//       resp = <Productos>[];
//       json['resp'].forEach((v) {
//         resp!.add(Productos.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['idError'] = idError;
//     data['resp'] = resp != null ? resp!.map((v) => v.toJson()).toList() : null;
//     return data;
//   }
// }
