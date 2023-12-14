// ignore_for_file: use_build_context_synchronously
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/map_page.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MyCard2 extends ConsumerStatefulWidget {
  const MyCard2(
      {super.key,
      required this.onDeleted,
      required this.index,
      required this.store});
  final int index;
  final SondeosFromStore? store;
  final Function onDeleted;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard2> {
  final int progress = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.11; // 125
    final width = size.width * 0.95;
    final backWidget = Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(right: size.height * 0.01),
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.redAccent));
    final iconColor = c.primary500;

    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Center(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: c.primary200.withOpacity(0.2),
              border: Border.all(color: c.primary300),
            ),
            child: Dismissible(
              key: UniqueKey(),
              background: backWidget,
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) => confirmDimiss(),
              onDismissed: (direction) => widget.onDeleted(),
              child: ExpansionPanelList.radio(
                expandedHeaderPadding: const EdgeInsets.all(0),
                elevation: 0,
                animationDuration: const Duration(milliseconds: 350),
                children: [
                  ExpansionPanelRadio(
                      backgroundColor: c.surface,
                      canTapOnHeader: false, // True
                      value: widget.store ?? Store(),
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          onTap: () async {
                            final gps = await verifyGps();
                            if (!gps) return;

                            await showMsj2();
                          },
                          minVerticalPadding: 0,
                          leading:
                              Icon(Icons.storefront_outlined, color: iconColor),
                          title: Text('${widget.store?.store?.tienda}',
                              style: t.mediumBold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                              'Progreso: ${(widget.store?.totalProgress?.toStringAsFixed(2) ?? 0)}%',
                              style:
                                  progress == 0 ? t.textDisabled2 : t.textBlue),
                        );
                      },
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: size.width * 0.2, top: 0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Cadena: ${widget.store?.store?.idCadena}',
                                      style: t.text),
                                  Text('Grupo: ${widget.store?.store?.idGrupo}',
                                      style: t.text),
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.1),
                            child: TextButton.icon(
                                label: const Text('Maps'),
                                onPressed: () => goMaps(),
                                icon: Icon(Icons.location_on,
                                    color: c.primary.withOpacity(0.8),
                                    size: size.height * 0.03)),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> verifyGps() async {
    final permission = await Geolocator.isLocationServiceEnabled();
    if (permission) {
      return true;
    } else {
      await showMsj(
          context: context,
          title: 'Gps',
          content:
              'Actíva la ubicación de tu dispositivo para poder continuar.',
          buttonLabel: 'Aceptar',
          destructive: false,
          children:
              Icon(Icons.location_on_outlined, size: 50, color: c.primary500),
          onlyOk: true);
      return false;
    }
  }

  void goMaps() {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 350),
            type: PageTransitionType.rightToLeft,
            child: MapsPage(store: widget.store?.store)));
  }

  Future<bool> confirmDimiss() async {
    final delete = await showMsj(
      context: context,
      title: '¿Eliminar?',
      content:
          'Ten en cuenta que necesitarás conexión a internet para añadir nuevamente una tienda. \n\n¿Seguro que deseas eliminar esta tienda de Ruta del Dia?',
      buttonLabel: 'Eliminar',
      destructive: true,
      justifyContent: true,
    );
    return Future.value(delete);
  }

  Future<void> showMsj2() async {
    final startSondeo = await showMsj(
      context: context,
      title: widget.store?.store?.tienda ?? '',
      content: '',
      // content: '''
      //     Verifica GPS: ${widget.store?.store?.checkGPS == '1' || widget.store?.store?.checkGPS == 1 ? 'Si' : 'No'}
      //     \n Cadena: ${widget.store?.store?.idCadena}
      //     \n Grupo: ${widget.store?.store?.idGrupo}
      // ''',
      children: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Verifica GPS: ${widget.store?.store?.checkGPS == '1' || widget.store?.store?.checkGPS == 1 ? 'Si' : 'No'}'),
              Text('Cadena: ${widget.store?.store?.idCadena}'),
              Text('Grupo: ${widget.store?.store?.idGrupo}'),
            ]),
      ),
      buttonLabel:
          widget.store?.finishedSections != null ? 'Ver sondeo' : 'Comenzar',
      destructive: false,
      onlyOk: true,
      justifyContent: false,
      canTapOutside: true,
    );

    if (startSondeo) {
      await _start(widget.index);
      return;
    }
  }

  Future<void> _start(int index) async {
    final navigator = Navigator.of(context);
    // final sondeos = await ref.read(routeOTD.notifier).getSondeoFromDB();

    // if (sondeos[index].idError != 0) {
    //   showYesNoMsj(
    //       context: context,
    //       yesOnly: true,
    //       title: 'Error',
    //       content:
    //           'Se produjo un error inesperado. Si el error persiste, elimina las tiendas e intentalo de nuevo.');
    // } else {
    // }

    navigator.push(CupertinoPageRoute(builder: (context) {
      return SondeoPage(
          storeUuid: widget.store?.uuid ?? '',
          mainStore: widget.store,
          sondeosList: widget.store?.sondeo?.resp ?? [],
          store: widget.store?.store ?? Store2());
    }));
  }

  //
}
