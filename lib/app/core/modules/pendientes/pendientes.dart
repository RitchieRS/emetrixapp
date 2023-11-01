
import 'package:isar/isar.dart';

part 'pendientes.g.dart';

@collection
class Pendiente {
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
        ? new Contenido.fromJson(json['contenido'])
        : null;
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProyecto'] = this.idProyecto;
    data['idUsuario'] = this.idUsuario;
    data['quien'] = this.quien;
    data['fecha'] = this.fecha;
    data['tipo'] = this.tipo;
    data['conteo'] = this.conteo;
    if (this.contenido != null) {
      data['contenido'] = this.contenido!.toJson();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config!.toJson();
    }
    return data;
  }
}

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
        respuestas!.add(new Respuestas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTienda'] = this.idTienda;
    data['estadoTienda'] = this.estadoTienda;
    data['idSondeo'] = this.idSondeo;
    data['sku'] = this.sku;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    if (this.respuestas != null) {
      data['respuestas'] = this.respuestas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPregunta'] = this.idPregunta;
    data['tipo'] = this.tipo;
    data['size'] = this.size;
    data['respuesta'] = this.respuesta;
    return data;
  }
}

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotspot'] = this.hotspot;
    data['conexion'] = this.conexion;
    data['brillo'] = this.brillo;
    data['bateria'] = this.bateria;
    data['gps'] = this.gps;
    data['imei'] = this.imei;
    data['tag'] = this.tag;
    data['gps2'] = this.gps2;
    data['version'] = this.version;
    data['datos'] = this.datos;
    return data;
  }
}

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpsProyecto'] = this.gpsProyecto;
    data['resolucionImagen'] = this.resolucionImagen;
    data['sondeoObligatorio'] = this.sondeoObligatorio;
    data['capturaSku'] = this.capturaSku;
    data['gpsTienda'] = this.gpsTienda;
    data['rangoTienda'] = this.rangoTienda;
    return data;
  }
}