// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
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
              onRefresh: () =>
                  ref.read(pendingsController.notifier).getPendings(ref),
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
                                color: c.primary100.withOpacity(0.6),
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
                                    style: t.mediumDark),
                                subtitle: Text(
                                  _textToTime(DateTime.parse(
                                      item.pendiente?.fecha ?? '')),
                                  style: t.text,
                                ),
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

    showProgress(context: context, title: 'Preparando..');
    await Future.delayed(const Duration(seconds: 2));
    final images = <String>[];
    final storeIsar =
        await ref.read(databaseProvider).getStoreByUuid(storeUuid: storeUuid);

    item.pendiente?.contenido?.respuestas?.forEach((response) {
      if (response.tipo == 'foto' && response.respuesta != null ||
          response.tipo == 'imagen' && response.respuesta != null ||
          response.respuesta == 'fotoGuardarCopia' &&
              response.respuesta != null) {
        if (response.respuesta!.isNotEmpty) {
          images.add(response.respuesta!);
        }
      }
    });

    navigator.pop();
    showProgress(context: context, title: 'Enviando..');

    //-----
    //1.- Todas las imagenes se envian aparte
    //2.- Todo los demas se envia en el pendiente normal

    await ref.read(pendingsController.notifier).sendCheckInOutImages(
          storeIsar: storeIsar!,
          tipo: 'checkin',
          ref: ref,
          storeUuid: storeUuid,
          image: File(''),
        );

    if (images.isNotEmpty) {
      for (var images in images) {
        await ref.read(pendingsController.notifier).sendCheckInOutImages(
              storeIsar: storeIsar,
              tipo: 'imagen',
              ref: ref,
              storeUuid: storeUuid,
              image: File(images),
            );
      }
    }

    final result = await ref
        .read(pendingsController.notifier)
        .sendPendings(item.pendiente!);

    await ref.read(pendingsController.notifier).sendCheckInOutImages(
          storeIsar: storeIsar,
          tipo: 'checkout',
          ref: ref,
          storeUuid: storeUuid,
          image: File(''),
        );

    Navigator.pop(context);
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
    return DateFormat.jm().format(hour);
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
