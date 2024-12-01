import 'package:isar/isar.dart';
part 'all_stores.g.dart';

@collection
class StoreGeneral {
  Id idIsar = Isar.autoIncrement;
  String? id;
  String? tienda;
  double? latitud;
  double? longitud;
  String? idGrupo;
  String? idCadena;
  int? definirNombre;
  String? clasificacion;
  int? rangoGPS;
  String? checkGPS;

  StoreGeneral(
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

  factory StoreGeneral.fromJson(Map<String, dynamic> json) => StoreGeneral(
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
