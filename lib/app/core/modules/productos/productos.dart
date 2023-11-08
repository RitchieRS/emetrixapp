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
 //List<Productos>? productos;
  ProductosIsar({
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
}


class ProductosJson {
    int? idError;
    ProductsResp? resp;

    ProductosJson({
        this.idError,
        this.resp,
    });

    factory  ProductosJson.fromRawJson(String str) =>
       ProductosJson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

     factory ProductosJson.fromJson(Map<String, dynamic> json) => ProductosJson(
        idError: json["idError"],
        resp: ProductsResp.fromJson(json["resp"]),
    );

    Map<String, dynamic> toJson() => {
        "idError": idError,
        "resp": resp?.toJson(),
    };

      
}

class ProductsResp {
   ProductsResp({
    required this.productos,
  });
  late final List<Productos> productos;
  
  ProductsResp.fromJson(Map<String, dynamic> json){
    productos = List.from(json['productos']).map((e)=>Productos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productos'] = productos.map((e)=>e.toJson()).toList();
    return _data;
  }
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

    Productos({
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

    factory Productos.fromRawJson(String str) => Productos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        idCategoria: json["idCategoria"],
        idMarca: json["idMarca"],
        sku: json["sku"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precioMax: json["precioMax"].toDouble(),
        precioMin: json["precioMin"].toDouble(),
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


