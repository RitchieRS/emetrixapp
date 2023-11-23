/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/

class Store {
  final String? id;
  final String? tienda;
  final double? latitud;
  final double? longitud;
  final String? idGrupo;
  final String? idCadena;
  final int? definirNombre;
  final String? clasificacion;
  final int? rangoGPS;
  final String? checkGPS;

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
        checkGPS: json["checkGPS"] is String
            ? json["checkGPS"]
            : json["checkGPS"] is int
                ? json["checkGPS"].toString()
                : null,
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
  List<Store>? resp;

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
    data['resp'] = resp != null ? resp!.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
