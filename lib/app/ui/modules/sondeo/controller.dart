import 'dart:io';
import 'dart:convert';
import 'package:emetrix_flutter/app/core/modules/pendientes/service.dart';
import 'package:emetrix_flutter/app/core/providers/providers.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/modules/login/login.dart';
import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';

//* Pagina de sondeos en general
final currentOptionProvider = StateProvider<int>((ref) => 0);
final onlyFirstProvider = StateProvider<bool>((ref) => true);
final finishedSondeos = StateProvider<List<int>>((ref) => []);

//Controller
final sondeoController = StateNotifierProvider<Auth, SondeoState>((ref) {
  final service = ref.watch(pendingsServiceProvider);
  return Auth(service);
});

class Auth extends StateNotifier<SondeoState> {
  Auth(this.pendingsService) : super(const SondeoState());
  final PendingsService pendingsService;

  Future<Resp> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('loginInfo');
    final userInfo = Resp.fromRawJson(userData ?? '');
    return userInfo;
  }

  List<RespM> reorderList(List<RespM> list) {
    List<(int, RespM)> list2 = List.empty(growable: true);
    List<RespM> reorderList = List.empty(growable: true);

    //Clonacion de asistencia para checkout
    final checkin =
        list.firstWhere((element) => element.sondeo == 'Asistencia');
    String json = jsonEncode(checkin.toJson());
    final checkin2 = RespM.fromJson(jsonDecode(json));
    checkin2.sondeo = 'Salida';
    checkin2.orden = '1000';
    list.add(checkin2);

    for (var element in list) {
      final number = int.parse(element.orden ?? '');
      list2.add((number, element));
    }
    list2.sort((a, b) => a.$1.compareTo(b.$1));

    for (var element in list2) {
      reorderList.add(element.$2);
    }

    return reorderList;
  }

//   Future<void> buildPending({
//     required RespM sondeoItem,
//     required Store2 store,
//     required WidgetRef ref,
//     required String storeUuid,
//     required String tipo,
//     required File image,
//   }) async {
//     final Resp userInfo = await _getUserInfo();
//     final storeIsar =
//         await ref.read(databaseProvider).getStoreByUuid(storeUuid: storeUuid);
//     final List<Respuestas> responses = [];

//     responses.add(Respuestas(
//       idPregunta: '1', //Checkin 1
//       tipo: "asistencia", //checkin
//       respuesta: "",
//       size: null,
//     ));

// //Arma pendiente
//     final pending = Pendiente(
//       // idProyecto: '',
//       estado: 0,
//       idProyecto: userInfo.proyectos.first.id,
//       idUsuario: userInfo.usuario.id,
//       quien: Platform.isAndroid ? 'Android' : 'IOS',
//       fecha: DateTime.now().toString(),
//       tipo: tipo, //checkin / checkout
//       conteo: '1/1',
//       contenido: Contenido(
//         idSondeo: sondeoItem.id,
//         idTienda: store.id,
//         estadoTienda: '2', //0 sin visitar, 1 medio visitar, 2 completamente
//         latitud: storeIsar?.checkOut?.latitud,
//         longitud: storeIsar?.checkOut?.longitud,
//         respuestas: responses,
//       ),
//       config: Config(
//         rangoTienda: store.rangoGPS.toString(),
//         sondeoObligatorio: sondeoItem.obligatorio.toString(),
//         gpsProyecto: userInfo.proyectos.first.gps.toString(),
//         gpsTienda: store.checkGPS.toString(),
//         resolucionImagen: '1024',
//       ),
//       info: Info(
//         bateria: '80%',
//         brillo: '80%',
//         conexion: 'Datos',
//         datos: '--Sin permiso?--',
//         gps2: '1',
//         gps: '1',
//         hotspot: 'false',
//         imei: '',
//         tag: tipo, //checkin / checkout
//         // version: userInfo.versiones.first.toString(),
//         version: '1.0',
//       ),
//     );

//     await pendingsService.setCheckInOutImages(pending: pending, image: image);
//   }

  Future<void> buildFinalPending(
      RespM sondeoItem, Store2 store, WidgetRef ref, String storeUuid) async {
    final userInfo = await _getUserInfo();
    final savedStore =
        await ref.read(databaseProvider).getStoreByUuid(storeUuid: storeUuid);
    final List<Respuestas> responses = [];

    savedStore?.storeSteps?.forEach((element) {
      element.sondeos?.forEach((element2) {
        final resp = Respuestas(
          idPregunta: element2.question?.id,
          respuesta: element2.response,
          tipo: element2.question?.tipo,
        );
        responses.add(resp);
      });
    });

//Arma pendiente
    final pending = Pendiente(
      // idProyecto: '',
      estado: 0,
      idProyecto: userInfo.proyectos.first.id,
      idUsuario: userInfo.usuario.id,
      quien: Platform.isAndroid ? 'Android' : 'IOS',
      fecha: DateTime.now().toString(),
      tipo: 'Sondeo', //checkin / checkout
      conteo: '1/1',
      contenido: Contenido(
        idSondeo: sondeoItem.id,
        idTienda: store.id,
        estadoTienda: '2', //0 sin visitar, 1 medio visitar, 2 completamente
        latitud: savedStore?.checkOut?.latitud,
        longitud: savedStore?.checkOut?.longitud,
        respuestas: responses,
      ),
      config: Config(
        rangoTienda: store.rangoGPS.toString(),
        sondeoObligatorio: sondeoItem.obligatorio.toString(),
        gpsProyecto: userInfo.proyectos.first.gps.toString(),
        gpsTienda: store.checkGPS.toString(),
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
        tag: 'sondeo', //checkin / checkout
        // version: userInfo.versiones.first.toString(),
        version: '1.0',
      ),
    );

    final pendient = PendienteIsar(pendiente: pending, storeUuid: storeUuid);

    //Guardarlo a bd
    await ref.read(databaseProvider).savePending(pendient);
  }
}
