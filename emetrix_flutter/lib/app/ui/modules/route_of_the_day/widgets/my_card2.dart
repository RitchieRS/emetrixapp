// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/ui/utils/widgets/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

class MyCard2 extends ConsumerStatefulWidget {
  const MyCard2(
      {super.key,
      required this.onDeleted,
      required this.index,
      required this.resp});
  final int index;
  final Store? resp;
  final Function onDeleted;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard2> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeIn(
      child: Dismissible(
        // key: ValueKey<int>(widget.index),
        key: UniqueKey(),
        background: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: Container(
              padding: EdgeInsets.only(right: size.height * 0.01),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.redAccent)),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          final delete = await showMsj(
              context: context,
              title: 'Cuidado',
              content:
                  '¿Seguro que deseas eliminar esta tienda de Ruta del Dia?',
              buttonLabel: 'Eliminar',
              destructive: true);
          return Future.value(delete);
        },
        onDismissed: (direction) {
          widget.onDeleted(widget.index);
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.005),
          child: Center(
            child: Material(
              child: InkWell(
                onTap: () async {
                  await showMsj2(widget.resp?.tienda ?? '');

                  //
                },
                borderRadius: BorderRadius.circular(10),
                child: Ink(
                  height: size.height * 0.107,
                  width: size.width * 0.95,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.storefront_sharp, color: c.primary),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Container(
                                  width: size.width * 0.65,
                                  color: Colors.transparent,
                                  child: Text('${widget.resp?.tienda}',
                                      style: t.mediumBold,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Text('Cadena: ${widget.resp?.idCadena}',
                                  style: t.text)),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Text('Grupo: ${widget.resp?.idGrupo}',
                                  style: t.text)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              PageTransition(
                                  duration: const Duration(milliseconds: 350),
                                  type: PageTransitionType.rightToLeft,
                                  child: MapsPage(store: widget.resp))),
                          icon: Icon(Icons.location_on,
                              color: c.primary.withOpacity(0.8),
                              size: size.height * 0.03))
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future goMaps() async {
  //   final lat = widget.resp?.latitud;
  //   final lon = widget.resp?.longitud;
  //   final Uri url =
  //       Uri.parse('http://maps.google.com/maps?z=12&t=m&q=loc:$lat+$lon');
  //   debugPrint(url.toString());
  //   await launchUrl(url, mode: LaunchMode.externalApplication);
  // }

  Future showMsj2(String store) async {
    var result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return FadeIn(
            child: Consumer(
              builder: (context, ref, child) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: Text(store,
                      style: t.subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('¿Ir a los sondeos?',
                          style: t.text2, textAlign: TextAlign.center),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style:
                            TextButton.styleFrom(foregroundColor: c.disabled),
                        child: Text('Cancelar', style: t.textDisabledBold)),
                    ref.watch(showProgress1) == true
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: c.primary, strokeWidth: 2)))
                        : OutlinedButton(
                            onPressed: () => start(widget.index),
                            style: OutlinedButton.styleFrom(
                                foregroundColor: c.primary,
                                side: BorderSide(color: c.primary)),
                            child: Text('Comenzar', style: t.textBlue))
                  ],
                );
              },
            ),
          );
        });
    return Future.value(result);
  }

  Future start(int index) async {
    final navigator = Navigator.of(context);
    setState(() {
      ref.read(showProgress1.notifier).update((state) => true);
    });

    final sondeos = await ref.read(routeOTD.notifier).getSondeoFromDB();

    if (sondeos[index].idError != 0) {
      setState(() {
        ref.read(showProgress1.notifier).update((state) => false);
      });
      navigator.pop(true);

      showYesNoMsj(
          context: context,
          yesOnly: true,
          title: 'Error',
          content:
              'Se produjo un error inesperado. Si el error persiste, elimina las tiendas e intentalo de nuevo.');
    } else {
      // Emulated Delay
      await Future.delayed(const Duration(seconds: 1));

      navigator.pop(true);
      navigator.push(MaterialPageRoute(builder: (context) {
        return SondeoPage(
            sondeosList: sondeos[index].resp ?? [],
            store: widget.resp ?? Store());
      }));
    }
  }

  //
}
