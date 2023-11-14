import 'dart:convert';
import 'package:isar/isar.dart';
part 'pendientes.g.dart';

@collection
class Pendiente {
  Id id = Isar.autoIncrement;
  int? estado; // 0 no enviado, 1 enviado, 2 error
  String? idProyecto;
  String? idUsuario;
  String? quien;
  String? fecha;
  String? tipo;
  String? conteo;
  Contenido? contenido;
  Info? info;
  Config? config;
  Pendiente(
      {this.idProyecto,
      this.idUsuario,
      this.estado,
      this.quien,
      this.fecha,
      this.tipo,
      this.conteo,
      this.contenido,
      this.info,
      this.config});

  Pendiente.fromJson(Map<String, dynamic> json) {
    idProyecto = json['idProyecto'];
    idUsuario = json['idUsuario'];
    quien = json['quien'];
    fecha = json['fecha'];
    tipo = json['tipo'];
    conteo = json['conteo'];
    contenido = json['contenido'] != null
        ? Contenido.fromJson(json['contenido'])
        : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() => {
        "idProyecto": idProyecto,
        "idUsuario": idUsuario,
        "quien": quien,
        "fecha": fecha.toString(),
        "tipo": tipo,
        "conteo": conteo,
        "contenido": contenido?.toJson(),
        "info": info?.toJson(),
        "config": config?.toJson(),
      };

  String toRawJson() => json.encode(toJson());
}

@embedded
class Contenido {
  String? idTienda;
  String? estadoTienda;
  String? idSondeo;
  String? sku;
  String? latitud;
  String? longitud;
  List<Respuestas>? respuestas;

  Contenido(
      {this.idTienda,
      this.estadoTienda,
      this.idSondeo,
      this.sku,
      this.latitud,
      this.longitud,
      this.respuestas});

  Contenido.fromJson(Map<String, dynamic> json) {
    idTienda = json['idTienda'];
    estadoTienda = json['estadoTienda'];
    idSondeo = json['idSondeo'];
    sku = json['sku'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    if (json['respuestas'] != null) {
      respuestas = <Respuestas>[];
      json['respuestas'].forEach((v) {
        respuestas!.add(Respuestas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTienda'] = idTienda;
    data['estadoTienda'] = estadoTienda;
    data['idSondeo'] = idSondeo;
    data['sku'] = sku;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    if (respuestas != null) {
      data['respuestas'] = respuestas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@embedded
class Respuestas {
  String? idPregunta;
  String? tipo;
  String? size;
  String? respuesta;
  Respuestas({this.idPregunta, this.tipo, this.size, this.respuesta});

  Respuestas.fromJson(Map<String, dynamic> json) {
    idPregunta = json['idPregunta'];
    tipo = json['tipo'];
    size = json['size'];
    respuesta = json['respuesta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPregunta'] = idPregunta;
    data['tipo'] = tipo;
    data['size'] = size;
    data['respuesta'] = respuesta;
    return data;
  }
}

@embedded
class Info {
  String? hotspot;
  String? conexion;
  String? brillo;
  String? bateria;
  String? gps;
  String? imei;
  String? tag;
  String? gps2;
  String? version;
  String? datos;

  Info(
      {this.hotspot,
      this.conexion,
      this.brillo,
      this.bateria,
      this.gps,
      this.imei,
      this.tag,
      this.gps2,
      this.version,
      this.datos});

  Info.fromJson(Map<String, dynamic> json) {
    hotspot = json['hotspot'];
    conexion = json['conexion'];
    brillo = json['brillo'];
    bateria = json['bateria'];
    gps = json['gps'];
    imei = json['imei'];
    tag = json['tag'];
    gps2 = json['gps2'];
    version = json['version'];
    datos = json['datos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotspot'] = hotspot;
    data['conexion'] = conexion;
    data['brillo'] = brillo;
    data['bateria'] = bateria;
    data['gps'] = gps;
    data['imei'] = imei;
    data['tag'] = tag;
    data['gps2'] = gps2;
    data['version'] = version;
    data['datos'] = datos;
    return data;
  }
}

@embedded
class Config {
  String? gpsProyecto;
  String? resolucionImagen;
  String? sondeoObligatorio;
  String? capturaSku;
  String? gpsTienda;
  String? rangoTienda;

  Config(
      {this.gpsProyecto,
      this.resolucionImagen,
      this.sondeoObligatorio,
      this.capturaSku,
      this.gpsTienda,
      this.rangoTienda});

  Config.fromJson(Map<String, dynamic> json) {
    gpsProyecto = json['gpsProyecto'];
    resolucionImagen = json['resolucionImagen'];
    sondeoObligatorio = json['sondeoObligatorio'];
    capturaSku = json['capturaSku'];
    gpsTienda = json['gpsTienda'];
    rangoTienda = json['rangoTienda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gpsProyecto'] = gpsProyecto;
    data['resolucionImagen'] = resolucionImagen;
    data['sondeoObligatorio'] = sondeoObligatorio;
    data['capturaSku'] = capturaSku;
    data['gpsTienda'] = gpsTienda;
    data['rangoTienda'] = rangoTienda;
    return data;
  }
}
