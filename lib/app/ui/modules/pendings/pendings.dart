// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import 'package:emetrix_flutter/app/core/modules/pendientes/pendientes.dart';
import 'package:emetrix_flutter/app/ui/modules/pendings/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/pendings/widgets/empty_list.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class PendingsPage extends ConsumerStatefulWidget {
  const PendingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PendingsPageState();
}

class _PendingsPageState extends ConsumerState<PendingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(pendingsController.notifier).getPendings(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pendingsController);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const GeneralTitle(title: 'Pendientes', showMenu: true),
      body: FadeIn(
          child: RefreshIndicator(
              onRefresh: () => ref.read(pendingsController.notifier).getPendings(ref) 
              ,
              child: FutureBuilder(
                future: ref.read(pendingsController.notifier).getPendings(ref),
                builder: (context, snapshot) {
                  if (state.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final item = state.data[index];

                        return FadeInUp(
                          child: Center(
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width * 0.95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: c.primary300),
                                color: c.primary200.withOpacity(0.2),
                              ),
                              child: ListTile(
                                onTap: () => checkNetwork(item, index),
                                visualDensity:
                                    const VisualDensity(vertical: -3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                leading: Icon(Icons.task_outlined,
                                    color: c.primary500),
                                trailing: const Icon(Icons.send, size: 20),
                                title: Text(item.pendiente?.tipo ?? '',
                                    style: t.mediumBold),
                                subtitle: Text(
                                    _textToTime(DateTime.parse(
                                        item.pendiente?.fecha ?? '')),
                                    style: t.textDisabled2),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return EmptyList(
                      onRefresh: ref
                          .read(pendingsController.notifier)
                          .getPendings(ref),
                    );
                  }
                },
              ))),
    );

    // switch (state.state) {
    //   case States.succes:
    //     return Scaffold(
    //       appBar: const GeneralTitle(title: 'Pendientes', showMenu: true),
    //       body: FadeIn(
    //           child: RefreshIndicator(
    //         onRefresh: () =>
    //             ref.read(pendingsController.notifier).getPendings(ref),
    //         child: ListView.builder(
    //           itemCount: state.data.length,
    //           itemBuilder: (context, index) {
    //             final item = state.data[index];

    //             return Center(
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(8),
    //                 clipBehavior: Clip.hardEdge,
    //                 child: SizedBox(
    //                   width: size.width * 0.95,
    //                   child: ListTile(
    //                     onTap: () => sendPending(item, index),
    //                     tileColor: c.primary100.withOpacity(0.6),
    //                     leading: Icon(Icons.task_outlined, color: c.primary500),
    //                     trailing: const Icon(Icons.send),
    //                     title: Text(item.tipo ?? ''),
    //                     subtitle:
    //                         Text(_textToTime(DateTime.parse(item.fecha ?? ''))),
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       )),
    //     );

    //   case States.error:
    //     return EmptyList(
    //       onRefresh: ref.read(pendingsController.notifier).getPendings(ref),
    //     );

    //   case States.loading:
    //     return const Scaffold(
    //       appBar: GeneralTitle(title: 'Pendientes'),
    //       // drawer: MyDrawer(),
    //       body: GeneralLoading(loadingCards: 3),
    //     );
    // }
  }

//----
  Future<void> checkNetwork(PendienteIsar item, int index) async {
    final network = await (Connectivity().checkConnectivity());
    if (network == ConnectivityResult.none) {
      showMsj(
        context: context,
        title: 'Sin Conexión',
        destructive: false,
        content: 'Conéctate a una red para enviar el pendiente.',
        buttonLabel: 'Aceptar',
        onlyOk: true,
        canTapOutside: true,
      );
      return;
    }
    await sendPending(item, index, item.storeUuid!);
  }

  Future<void> sendPending(
      PendienteIsar item, int index, String storeUuid) async {
    final navigator = Navigator.of(context);
    final sendPending = await showMessage();
    if (!sendPending) return;

    logger.e("Pendiente ${item.pendiente}");

    showProgress(context: context, title: 'Preparando..');
    await Future.delayed(const Duration(seconds: 2));
    final images = <String>[];
    List<List<String>> imagesTypes = [[]];
    var indicator=0;
    final storeIsar =
        await ref.read(databaseProvider).getStoreByUuid(storeUuid: storeUuid);

    showProgress(context: context, title: 'Enviando..');
    item.pendiente?.contenido?.respuestas?.forEach((response) {

       

      if (response.tipo == 'foto'  || response.tipo == 'CheckIn' || response.tipo == 'CheckOut'  && response.respuesta != null ||
          response.respuesta == 'fotoGuardarCopia' &&
              response.respuesta != null) {
        if (response.respuesta != null && response.respuesta!.isNotEmpty) {
            images.add(response.respuesta!);
            logger.i("Generando Respuestas:");

            ref.read(pendingsController.notifier).sendCheckInOutImages(
                  storeIsar: storeIsar! ,
                  tipo: response.tipo!,
                  ref: ref,
                  storeUuid: storeUuid,
                  image: File(response.respuesta!)
                  );
           
        }
      }
    });
    //Ver la lista de imagenes
    
    logger.i("images: ${images}");

    navigator.pop();
    

    /*if (imagesTypes.isNotEmpty) {
          for (int i = 0; i < imagesTypes.length; i++) {
            logger.i('Checkin imagen for' );
            await ref.read(pendingsController.notifier).sendCheckInOutImages(
                  storeIsar: storeIsar! ,
                  tipo: imagesTypes[i][1],
                  ref: ref,
                  storeUuid: storeUuid,
                  image: File(imagesTypes[i][0]),
                );
          }
      }*/

    //-----
    //1.- Todas las imagenes se envian aparte
    //2.- Todo los demas se envia en el pendiente normal

    logger.i('Checkin imagen');
    logger.i('Checkin imagen ${storeIsar?.checkIn?.picture! ?? 'NoImage'}' );

  
    
    
  logger.i('Checkin imagen pendiente${item.pendiente!.toJson()}');
    final result = await ref
        .read(pendingsController.notifier)
        .sendPendings(item.pendiente!);

    
/*logger.i('Checkin imagen for checkout' );
    await ref.read(pendingsController.notifier).sendCheckInOutImages(
          storeIsar: storeIsar,
          tipo: 'checkout',
          ref: ref,
          storeUuid: storeUuid,
          image: File(storeIsar.checkOut!.picture!),
        );*/
/*logger.i('Checkin imagen pendiente${item.pendiente!.toJson()}');
    final result = await ref
        .read(pendingsController.notifier)
        .sendPendings(item.pendiente!);
    Navigator.pop(context);*/
    logger.i('Result ${result.idError}' );
    if (result.idError == 0) {
      await showMsj(
          context: context,
          title: 'Pendiente enviado',
          content: 'Envio correcto.',
          destructive: false,
          onlyOk: true,
          buttonLabel: 'Aceptar');
      await ref.read(pendingsController.notifier).deletePending(index, ref);
      await ref.read(pendingsController.notifier).getPendings(ref);
      setState(() {});
      return;
    }

    await showMsj(
        context: context,
        title: 'Errror',
        content: 'Hubo un error al enviar el pendiente.',
        destructive: false,
        onlyOk: true,
        buttonLabel: 'Aceptar');
  }
//----

  String _textToTime(DateTime hour) {
    return 'Completado: ${DateFormat.jm().format(hour)}';
  }

  Future<bool> showMessage() async {
    final value = await showMsj(
        context: context,
        title: 'Enviar pendiente?',
        content: 'Enviaremos este pendiente.',
        destructive: false,
        buttonLabel: 'Enviar');

    return Future.value(value);
  }
}
