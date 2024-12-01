import 'dart:convert';

class PendienteResp {
  final int idError;
  final String resp;

  PendienteResp({
    required this.idError,
    required this.resp,
  });

  factory PendienteResp.fromRawJson(String str) =>
      PendienteResp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PendienteResp.fromJson(Map<String, dynamic> json) => PendienteResp(
        idError: json["idError"],
        resp: json["resp"],
      );

  Map<String, dynamic> toJson() => {
        "idError": idError,
        "resp": resp,
      };
}
