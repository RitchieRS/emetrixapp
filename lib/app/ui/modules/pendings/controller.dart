import 'dart:io';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendings_resp.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/service.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

final pendingsController =
    StateNotifierProvider<PendingsControllerNotifier, PendingsState>((ref) {
  final service = ref.watch(pendingsServiceProvider);
  return PendingsControllerNotifier(service);
});

class PendingsControllerNotifier extends StateNotifier<PendingsState> {
  final PendingsService pendingsService;
  PendingsControllerNotifier(this.pendingsService)
      : super(const PendingsState());

  Future<Resp> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');
    final userInfo = Resp.fromRawJson(userData ?? '');
    return userInfo;
  }

  Future<void> getPendings(WidgetRef ref) async {
    final pendings = await ref.read(databaseProvider).getAllPendings();
    if (pendings.isNotEmpty) {
      state = state.copyWith(data: pendings, state: States.succes);
      return;
    }
    state = state.copyWith(data: pendings, state: States.error);
  }

  Future<PendienteResp> sendPendings(Pendiente pending) async {
    ///logger.i('Checkin imagen sendPendings ${pending.contenido?.respuestas}' );
    final response = await pendingsService.sendPendings(pending);
    return response;
  }

  Future<void> sendCheckInOutImages({
    // required RespM sondeoItem,
    // required Store2 store,
    required WidgetRef ref,
    required String storeUuid,
    required String tipo,
    required File image,
    required SondeosFromStore storeIsar,
  }) async {
    final Resp userInfo = await _getUserInfo();
    // final storeIsar =
    //     await ref.read(databaseProvider).getStoreByUuid(storeUuid: storeUuid);
    final List<Respuestas> responses = [];

    responses.add(Respuestas(
      idPregunta: '1', //Checkin 1
      tipo: "asistencia", //checkin
      respuesta: "",
      size: null,
    ));

//Arma pendiente
    final pending = Pendiente(
      // idProyecto: '',
      estado: 0,
      idProyecto: userInfo.proyectos.first.id,
      idUsuario: userInfo.usuario.id,
      quien: Platform.isAndroid ? 'Android' : 'IOS',
      fecha: DateTime.now().toString(),
      tipo: tipo, //checkin / checkout
      conteo: '1/1',
      contenido: Contenido(
        idSondeo: storeIsar.sondeo?.resp?.first.id,
        idTienda: storeIsar.store?.id,
        estadoTienda: '2', //0 sin visitar, 1 medio visitar, 2 completamente
        latitud: storeIsar.checkOut?.latitud,
        longitud: storeIsar.checkOut?.longitud,
        respuestas: responses,
      ),
      config: Config(
        rangoTienda: storeIsar.store?.rangoGPS.toString(),
        sondeoObligatorio: storeIsar.sondeo?.resp?.first.obligatorio.toString(),
        gpsProyecto: userInfo.proyectos.first.gps.toString(),
        gpsTienda: storeIsar.store?.checkGPS.toString(),
        resolucionImagen: '1024',
      ),
      info: Info(
        bateria: '80%',
        brillo: '80%',
        conexion: 'Datos',
        datos: '--Sin permiso?--',
        gps2: '1',
        gps: '1',
        hotspot: 'false',
        imei: '',
        tag: tipo, //checkin / checkout
        // version: userInfo.versiones.first.toString(),
        version: '1.0',
      ),
    );

    await pendingsService.setCheckInOutImages(pending: pending, image: image);
  }

  Future<bool> deletePending(int id, WidgetRef ref) async {
    final result = await ref.read(databaseProvider).deletePending(id);
    return result;
  }

//
}
