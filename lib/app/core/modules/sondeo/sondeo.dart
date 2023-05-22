class SondeoModel {
  int? idError;
  List<RespM>? resp;

  SondeoModel({this.idError, this.resp});

  SondeoModel.fromJson(Map<String, dynamic> json) {
    idError = json['idError'];
    if (json['resp'] != null) {
      resp = <RespM>[];
      json['resp'].forEach((v) {
        resp!.add(RespM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idError'] = idError;
    if (resp != null) {
      data['resp'] = resp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RespM {
  String? id;
  String? sondeo;
  String? orden;
  num? capturaSKU;
  num? obligatorio;
  num? noAsistencia;
  num? puntajeTotal;
  String? tarea;
  String? linkWeb;
  num? abreLinkWebview;
  num? iterativo;
  num? iteracion;
  List<Preguntas>? preguntas;

  RespM(
      {this.id,
      this.sondeo,
      this.orden,
      this.capturaSKU,
      this.obligatorio,
      this.noAsistencia,
      this.puntajeTotal,
      this.tarea,
      this.linkWeb,
      this.abreLinkWebview,
      this.iterativo,
      this.iteracion,
      this.preguntas});

  RespM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sondeo = json['sondeo'];
    orden = json['orden'];
    capturaSKU = json['capturaSKU'];
    obligatorio = json['obligatorio'];
    noAsistencia = json['noAsistencia'];
    puntajeTotal = json['puntajeTotal'];
    tarea = json['tarea'];
    linkWeb = json['linkWeb'];
    abreLinkWebview = json['abreLinkWebview'];
    iterativo = json['iterativo'];
    iteracion = json['iteracion'];
    if (json['preguntas'] != null) {
      preguntas = <Preguntas>[];
      json['preguntas'].forEach((v) {
        preguntas!.add(Preguntas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sondeo'] = sondeo;
    data['orden'] = orden;
    data['capturaSKU'] = capturaSKU;
    data['obligatorio'] = obligatorio;
    data['noAsistencia'] = noAsistencia;
    data['puntajeTotal'] = puntajeTotal;
    data['tarea'] = tarea;
    data['linkWeb'] = linkWeb;
    data['abreLinkWebview'] = abreLinkWebview;
    data['iterativo'] = iterativo;
    data['iteracion'] = iteracion;
    if (preguntas != null) {
      data['preguntas'] = preguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Preguntas {
  String? id;
  String? pregunta;
  String? tipo;
  num? puntaje;
  num? obligatorio;
  String? dependePregunta;
  String? dependeRespuesta;
  num? fotoGaleria;
  num? fotoGuardarCopia;
  String? idPreguntaRespuesta;
  String? respuesta;
  String? idTienda;
  String? idIniciativa;
  String? ordenI;
  num? valorMinimo;
  num? valorMaximo;
  List<Opciones>? opciones;
  num? capturaNTiempos;

  Preguntas(
      {this.id,
      this.pregunta,
      this.tipo,
      this.puntaje,
      this.obligatorio,
      this.dependePregunta,
      this.dependeRespuesta,
      this.fotoGaleria,
      this.fotoGuardarCopia,
      this.idPreguntaRespuesta,
      this.respuesta,
      this.idTienda,
      this.idIniciativa,
      this.ordenI,
      this.valorMinimo,
      this.valorMaximo,
      this.opciones,
      this.capturaNTiempos});

  Preguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pregunta = json['pregunta'];
    tipo = json['tipo'];
    puntaje = json['puntaje'];
    obligatorio = json['obligatorio'];
    dependePregunta = json['dependePregunta'];
    dependeRespuesta = json['dependeRespuesta'];
    fotoGaleria = json['fotoGaleria'];
    fotoGuardarCopia = json['fotoGuardarCopia'];
    idPreguntaRespuesta = json['idPreguntaRespuesta'];
    respuesta = json['respuesta'];
    idTienda = json['idTienda'];
    idIniciativa = json['idIniciativa'];
    ordenI = json['ordenI'];
    valorMinimo = json['valorMinimo'];
    valorMaximo = json['valorMaximo'];
    if (json['opciones'] != null) {
      opciones = <Opciones>[];
      json['opciones'].forEach((v) {
        opciones!.add(Opciones.fromJson(v));
      });
    }
    capturaNTiempos = json['capturaNTiempos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pregunta'] = pregunta;
    data['tipo'] = tipo;
    data['puntaje'] = puntaje;
    data['obligatorio'] = obligatorio;
    data['dependePregunta'] = dependePregunta;
    data['dependeRespuesta'] = dependeRespuesta;
    data['fotoGaleria'] = fotoGaleria;
    data['fotoGuardarCopia'] = fotoGuardarCopia;
    data['idPreguntaRespuesta'] = idPreguntaRespuesta;
    data['respuesta'] = respuesta;
    data['idTienda'] = idTienda;
    data['idIniciativa'] = idIniciativa;
    data['ordenI'] = ordenI;
    data['valorMinimo'] = valorMinimo;
    data['valorMaximo'] = valorMaximo;
    if (opciones != null) {
      data['opciones'] = opciones!.map((v) => v.toJson()).toList();
    }
    data['capturaNTiempos'] = capturaNTiempos;
    return data;
  }
}

class Opciones {
  String? id;
  String? opcion;
  num? puntos;

  Opciones({this.id, this.opcion, this.puntos});

  Opciones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opcion = json['opcion'];
    puntos = json['puntos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['opcion'] = opcion;
    data['puntos'] = puntos;
    return data;
  }
}
