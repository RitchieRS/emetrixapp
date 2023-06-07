/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Store {
  String? id;
  String? tienda;
  double? latitud;
  double? longitud;
  String? idGrupo;
  String? idCadena;
  int? definirNombre;
  String? clasificacion;
  int? rangoGPS;
  int? checkGPS;

  Store(
      {this.id,
      this.tienda,
      this.latitud,
      this.longitud,
      this.idGrupo,
      this.idCadena,
      this.definirNombre,
      this.clasificacion,
      this.rangoGPS,
      this.checkGPS});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        tienda: json["tienda"],
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
        idGrupo: json["idGrupo"],
        idCadena: json["idCadena"],
        definirNombre: json["definirNombre"],
        clasificacion: json["clasificacion"],
        rangoGPS: json["rangoGPS"],
        checkGPS: json["checkGPS"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tienda'] = tienda;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['idGrupo'] = idGrupo;
    data['idCadena'] = idCadena;
    data['definirNombre'] = definirNombre;
    data['clasificacion'] = clasificacion;
    data['rangoGPS'] = rangoGPS;
    data['checkGPS'] = checkGPS;
    return data;
  }
}

class Stores {
  int? idError;
  List<Store?>? resp;

  Stores({this.idError, this.resp});

  Stores.fromJson(Map<String, dynamic> json) {
    idError = json['idError'];
    if (json['resp'] != null) {
      resp = <Store>[];
      json['resp'].forEach((v) {
        resp!.add(Store.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idError'] = idError;
    data['resp'] = resp != null ? resp!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}









// // To parse this JSON data, do
// //
// //     final stores = storesFromJson(jsonString);

// import 'dart:convert';

// class Stores {
//   Stores({
//     required this.idError,
//     required this.resp,
//   });

//   final int idError;
//   final List<Store> resp;

//   factory Stores.fromRawJson(String str) => Stores.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Stores.fromJson(Map<String, dynamic> json) => Stores(
//         idError: json["idError"],
//         resp: List<Store>.from(json["resp"].map((x) => Store.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "idError": idError,
//         "resp": List<dynamic>.from(resp.map((x) => x.toJson())),
//       };
// }

// class Store {
//   Store({
//     required this.id,
//     required this.tienda,
//     required this.latitud,
//     required this.longitud,
//     required this.idGrupo,
//     required this.idCadena,
//     required this.definirNombre,
//     required this.clasificacion,
//     required this.rangoGps,
//     required this.checkGps,
//   });

//   final String id;
//   final String tienda;
//   final double latitud;
//   final double longitud;
//   final String idGrupo;
//   final String idCadena;
//   final int definirNombre;
//   final String clasificacion;
//   final int rangoGps;
//   final String checkGps;

//   factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Store.fromJson(Map<String, dynamic> json) => Store(
//         id: json["id"],
//         tienda: json["tienda"],
//         latitud: json["latitud"]?.toDouble(),
//         longitud: json["longitud"]?.toDouble(),
//         idGrupo: json["idGrupo"],
//         idCadena: json["idCadena"],
//         definirNombre: json["definirNombre"],
//         clasificacion: json["clasificacion"],
//         rangoGps: json["rangoGPS"],
//         checkGps: json["checkGPS"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "tienda": tienda,
//         "latitud": latitud,
//         "longitud": longitud,
//         "idGrupo": idGrupo,
//         "idCadena": idCadena,
//         "definirNombre": definirNombre,
//         "clasificacion": clasificacion,
//         "rangoGPS": rangoGps,
//         "checkGPS": checkGps,
//       };
// }
