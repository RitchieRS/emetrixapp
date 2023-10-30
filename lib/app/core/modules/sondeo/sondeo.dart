import 'dart:convert';

import 'package:isar/isar.dart';
part 'sondeo.g.dart';

@collection
class SondeosFromStore {
  Id id = Isar.autoIncrement;
  Store2? store;
  double? progress;
  List<SondeoCollection>? sondeosRespuestas;

  SondeosFromStore({
    this.store,
    this.progress,
    this.sondeosRespuestas,
  });
}

@embedded
class SondeoCollection {
  int? indexSondeo;
  List<QuestionResponse>? collection;
  SondeoCollection({this.collection, this.indexSondeo});
}

@embedded
class QuestionResponse {
  QuestionResponse({
    this.question,
    this.index,
    this.response,
  });
  Preguntas? question;
  String? response;
  int? index;
}

//---------

class SondeoModel {
  int? idError;
  List<RespM>? resp;

  SondeoModel({
    this.idError,
    this.resp,
  });

  factory SondeoModel.fromRawJson(String str) =>
      SondeoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SondeoModel.fromJson(Map<String, dynamic> json) => SondeoModel(
        idError: json["idError"],
        resp: json["resp"] == null
            ? []
            : List<RespM>.from(json["resp"]!.map((x) => RespM.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idError": idError,
        "resp": resp == null
            ? []
            : List<dynamic>.from(resp!.map((x) => x.toJson())),
      };
}

class RespM {
  String? id;
  String? sondeo;
  String? orden;
  int? capturaSku;
  int? capturaNfc;
  int? obligatorio;
  int? noAsistencia;
  int? puntajeTotal;
  String? tarea;
  String? linkWeb;
  int? abreLinkWebview;
  int? iterativo;
  int? iteracion;
  List<Preguntas>? preguntas;

  RespM({
    this.id,
    this.sondeo,
    this.orden,
    this.capturaSku,
    this.capturaNfc,
    this.obligatorio,
    this.noAsistencia,
    this.puntajeTotal,
    this.tarea,
    this.linkWeb,
    this.abreLinkWebview,
    this.iterativo,
    this.iteracion,
    this.preguntas,
  });

  factory RespM.fromRawJson(String str) => RespM.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RespM.fromJson(Map<String, dynamic> json) => RespM(
        id: json["id"],
        sondeo: json["sondeo"],
        orden: json["orden"],
        capturaSku: json["capturaSKU"],
        capturaNfc: json["capturaNFC"],
        obligatorio: json["obligatorio"],
        noAsistencia: json["noAsistencia"],
        puntajeTotal: json["puntajeTotal"],
        tarea: json["tarea"],
        linkWeb: json["linkWeb"],
        abreLinkWebview: json["abreLinkWebview"],
        iterativo: json["iterativo"],
        iteracion: json["iteracion"],
        preguntas: json["preguntas"] == null
            ? []
            : List<Preguntas>.from(
                json["preguntas"]!.map((x) => Preguntas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sondeo": sondeo,
        "orden": orden,
        "capturaSKU": capturaSku,
        "capturaNFC": capturaNfc,
        "obligatorio": obligatorio,
        "noAsistencia": noAsistencia,
        "puntajeTotal": puntajeTotal,
        "tarea": tarea,
        "linkWeb": linkWeb,
        "abreLinkWebview": abreLinkWebview,
        "iterativo": iterativo,
        "iteracion": iteracion,
        "preguntas": preguntas == null
            ? []
            : List<dynamic>.from(preguntas!.map((x) => x.toJson())),
      };
}

@embedded
class Preguntas {
  String? id;
  String? pregunta;
  String? tipo;
  double? puntaje;
  int? obligatorio;
  String? dependePregunta;
  String? dependeRespuesta;
  double? valorMinimo;
  double? valorMaximo;
  int? fotoGaleria;
  int? fotoGuardarCopia;
  String? idPreguntaRespuesta;
  String? respuesta;
  String? idTienda;
  String? idIniciativa;
  String? ordenI;
  List<Opciones>? opciones;
  int? capturaNTiempos;

  Preguntas({
    this.id,
    this.pregunta,
    this.tipo,
    this.puntaje,
    this.obligatorio,
    this.dependePregunta,
    this.dependeRespuesta,
    this.valorMinimo,
    this.valorMaximo,
    this.fotoGaleria,
    this.fotoGuardarCopia,
    this.idPreguntaRespuesta,
    this.respuesta,
    this.idTienda,
    this.idIniciativa,
    this.ordenI,
    this.opciones,
    this.capturaNTiempos,
  });

  factory Preguntas.fromRawJson(String str) =>
      Preguntas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Preguntas.fromJson(Map<String, dynamic> json) => Preguntas(
        id: json["id"],
        pregunta: json["pregunta"],
        tipo: json["tipo"],
        puntaje: json["puntaje"]?.toDouble(),
        obligatorio: json["obligatorio"],
        dependePregunta: json["dependePregunta"],
        dependeRespuesta: json["dependeRespuesta"],
        valorMinimo: json["valorMinimo"]?.toDouble(),
        valorMaximo: json["valorMaximo"]?.toDouble(),
        fotoGaleria: json["fotoGaleria"],
        fotoGuardarCopia: json["fotoGuardarCopia"],
        idPreguntaRespuesta: json["idPreguntaRespuesta"],
        respuesta: json["respuesta"],
        idTienda: json["idTienda"],
        idIniciativa: json["idIniciativa"],
        ordenI: json["ordenI"],
        opciones: json["opciones"] == null
            ? []
            : List<Opciones>.from(
                json["opciones"]!.map((x) => Opciones.fromJson(x))),
        capturaNTiempos: json["capturaNTiempos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pregunta": pregunta,
        "tipo": tipo,
        "puntaje": puntaje,
        "obligatorio": obligatorio,
        "dependePregunta": dependePregunta,
        "dependeRespuesta": dependeRespuesta,
        "valorMinimo": valorMinimo,
        "valorMaximo": valorMaximo,
        "fotoGaleria": fotoGaleria,
        "fotoGuardarCopia": fotoGuardarCopia,
        "idPreguntaRespuesta": idPreguntaRespuesta,
        "respuesta": respuesta,
        "idTienda": idTienda,
        "idIniciativa": idIniciativa,
        "ordenI": ordenI,
        "opciones": opciones == null
            ? []
            : List<dynamic>.from(opciones!.map((x) => x.toJson())),
        "capturaNTiempos": capturaNTiempos,
      };
}

@embedded
class Opciones {
  String? id;
  String? opcion;
  double? puntos;

  Opciones({
    this.id,
    this.opcion,
    this.puntos,
  });

  factory Opciones.fromRawJson(String str) =>
      Opciones.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Opciones.fromJson(Map<String, dynamic> json) => Opciones(
        id: json["id"],
        opcion: json["opcion"],
        puntos: json["puntos"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "opcion": opcion,
        "puntos": puntos,
      };
}

//-----

@embedded
class Store2 {
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

  Store2(
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

  factory Store2.fromJson(Map<String, dynamic> json) => Store2(
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
