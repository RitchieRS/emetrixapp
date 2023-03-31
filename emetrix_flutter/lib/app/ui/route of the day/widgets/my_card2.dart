import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:emetrix_flutter/app/ui/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
              decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(14),
                color: Colors.red,
              ),
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white)),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          var result = await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  title: Text('Cuidado',
                      style: t.subtitle, textAlign: TextAlign.center),
                  content: Text(
                      '¿Seguro que deseas eliminar esta tienda de Ruta del Dia?',
                      style: t.text2),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style:
                            TextButton.styleFrom(foregroundColor: c.disabled),
                        child: Text('Cancelar', style: t.textDisabledBold)),
                    OutlinedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: OutlinedButton.styleFrom(
                            foregroundColor: c.error,
                            side: BorderSide(color: c.error)),
                        child: Text('Eliminar', style: t.textError))
                  ],
                );
              });
          return Future.value(result);
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
                  final navigator = Navigator.of(context);
                  debugPrint('STORE ID--> ${widget.resp?.id ?? ''}');

                  final sondeo = await ref
                      .read(routeOTD.notifier)
                      .getSondeo(widget.resp?.id ?? '');

                  if (sondeo.idError != 0) {
                    showMyMessage(
                        title: 'Error',
                        content:
                            'Se produjo un error inesperado. Ten en cuenta que para realizar un sondeo se requiere acceso a la red. Intenta nuevamente. Si el error persiste, verifica tu conexión a Internet. ');
                  } else {
                    navigator.push(MaterialPageRoute(builder: (context) {
                      return SondeoPage(sondeo: sondeo.resp?.first ?? RespM());
                    }));
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Ink(
                  height: size.height * 0.107,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                      color: c.disabled.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.storefront_sharp,
                          color: c.secondary.withOpacity(0.7),
                        ),
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
                                      style: t.medium,
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
                          onPressed: () => goMaps(),
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

  Future goMaps() async {
    final lat = widget.resp?.latitud;
    final lon = widget.resp?.longitud;
    final Uri url =
        Uri.parse('http://maps.google.com/maps?z=12&t=m&q=loc:$lat+$lon');
    debugPrint(url.toString());
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future showMyMessage({required String title, required String content}) async {
    // var result =
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: Text(title, style: t.subtitle, textAlign: TextAlign.center),
            content: Text(content, style: t.text2),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: TextButton.styleFrom(foregroundColor: c.disabled),
                  child: Text('Cancelar', style: t.textDisabledBold)),
              OutlinedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: c.primary,
                      side: BorderSide(color: c.primary)),
                  child: Text('Aceptar', style: t.textBlue))
            ],
          );
        });
  }

  //
}
