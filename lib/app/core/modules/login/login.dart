// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

class Login {
  Login({
    required this.idError,
    required this.resp,
  });

  final int idError;
  final Resp resp;

  factory Login.fromRawJson(String str) => Login.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        idError: json["idError"],
        resp: Resp.fromJson(json["resp"]),
      );

  Map<String, dynamic> toJson() => {
        "idError": idError,
        "resp": resp.toJson(),
      };
}

class Resp {
  Resp({
    required this.usuario,
    required this.proyectos,
    required this.versiones,
  });

  final Usuario usuario;
  final List<Proyecto> proyectos;
  final List<dynamic> versiones;

  factory Resp.fromRawJson(String str) => Resp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Resp.fromJson(Map<String, dynamic> json) => Resp(
        usuario: Usuario.fromJson(json["usuario"]),
        proyectos: List<Proyecto>.from(
            json["proyectos"].map((x) => Proyecto.fromJson(x))),
        versiones: List<dynamic>.from(json["versiones"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "usuario": usuario.toJson(),
        "proyectos": List<dynamic>.from(proyectos.map((x) => x.toJson())),
        "versiones": List<dynamic>.from(versiones.map((x) => x)),
      };
}

class Proyecto {
  Proyecto({
    required this.id,
    required this.nombre,
    required this.tipoUsuario,
    required this.gps,
    required this.filtroCategoria,
    required this.filtroMarca,
    required this.nuevaTienda,
    required this.visitaExtra,
    required this.indicadoresRendimiento,
    required this.capacitaciones,
    required this.descargaSondeosOnline,
    required this.deleteFiles,
    required this.asistencia,
    required this.descargaSondeosPreguntasXtienda,
    required this.menus,
    required this.resolucionImagen,
  });

  final String id;
  final String nombre;
  final String tipoUsuario;
  final int gps;
  final String filtroCategoria;
  final String filtroMarca;
  final int nuevaTienda;
  final int visitaExtra;
  final int indicadoresRendimiento;
  final int capacitaciones;
  final int descargaSondeosOnline;
  final int deleteFiles;
  final int asistencia;
  final int descargaSondeosPreguntasXtienda;
  final List<Menu> menus;
  final int resolucionImagen;

  factory Proyecto.fromRawJson(String str) =>
      Proyecto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
        id: json["id"],
        nombre: json["nombre"],
        tipoUsuario: json["tipoUsuario"],
        gps: json["gps"],
        filtroCategoria: json["filtroCategoria"],
        filtroMarca: json["filtroMarca"],
        nuevaTienda: json["nuevaTienda"],
        visitaExtra: json["visitaExtra"],
        indicadoresRendimiento: json["indicadoresRendimiento"],
        capacitaciones: json["capacitaciones"],
        descargaSondeosOnline: json["descargaSondeosOnline"],
        deleteFiles: json["deleteFiles"],
        asistencia: json["asistencia"],
        descargaSondeosPreguntasXtienda:
            json["descargaSondeosPreguntasXtienda"],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        resolucionImagen: json["resolucionImagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipoUsuario": tipoUsuario,
        "gps": gps,
        "filtroCategoria": filtroCategoria,
        "filtroMarca": filtroMarca,
        "nuevaTienda": nuevaTienda,
        "visitaExtra": visitaExtra,
        "indicadoresRendimiento": indicadoresRendimiento,
        "capacitaciones": capacitaciones,
        "descargaSondeosOnline": descargaSondeosOnline,
        "deleteFiles": deleteFiles,
        "asistencia": asistencia,
        "descargaSondeosPreguntasXtienda": descargaSondeosPreguntasXtienda,
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
        "resolucionImagen": resolucionImagen,
      };
}

class Menu {
  Menu({
    required this.id,
  });

  final int id;

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Usuario {
  Usuario({
    required this.id,
    required this.fechaVencimiento,
    required this.versionApp,
    required this.versionAppHasbro,
    required this.telefonosSoporte,
    required this.correosSoporte,
  });

  final String id;
  final DateTime fechaVencimiento;
  final int versionApp;
  final int versionAppHasbro;
  final String telefonosSoporte;
  final String correosSoporte;

  factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        fechaVencimiento: DateTime.parse(json["fecha_vencimiento"]),
        versionApp: json["version_app"],
        versionAppHasbro: json["version_app_hasbro"],
        telefonosSoporte: json["telefonosSoporte"],
        correosSoporte: json["correosSoporte"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_vencimiento": fechaVencimiento.toIso8601String(),
        "version_app": versionApp,
        "version_app_hasbro": versionAppHasbro,
        "telefonosSoporte": telefonosSoporte,
        "correosSoporte": correosSoporte,
      };
}
