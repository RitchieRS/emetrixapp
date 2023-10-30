// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:page_transition/page_transition.dart';

class MyCard2 extends ConsumerStatefulWidget {
  const MyCard2(
      {super.key,
      required this.onDeleted,
      required this.index,
      required this.store});
  final int index;
  final Store2? store;
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: FadeIn(
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
                  backgroundColor: c.primary200.withOpacity(0.2),
                  canTapOnHeader: false, // True
                  value: widget.store ?? Store(),
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      onTap: () => showMsj2(),
                      minVerticalPadding: 0,
                      leading:
                          Icon(Icons.storefront_outlined, color: iconColor),
                      title: Text('${widget.store?.tienda}',
                          style: t.mediumBold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text('Progreso: $progress%',
                          style: progress == 0 ? t.textDisabled2 : t.textBlue),
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
                              Text('Cadena: ${widget.store?.idCadena}',
                                  style: t.text),
                              Text('Grupo: ${widget.store?.idGrupo}',
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
    );
  }

  void goMaps() {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 350),
            type: PageTransitionType.rightToLeft,
            child: MapsPage(store: widget.store)));
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
      title: widget.store?.tienda ?? '',
      content:
          'Cadena: ${widget.store?.idCadena}\nGrupo: ${widget.store?.idGrupo}',
      buttonLabel: 'Comenzar',
      destructive: false,
      onlyOk: true,
      justifyContent: false,
      canTapOutside: true,
    );

    if (startSondeo) {
      await start(widget.index);
      return;
    }
  }

  Future start(int index) async {
    final navigator = Navigator.of(context);
    ref.read(showProgress1.notifier).update((state) => true);
    final sondeos = await ref.read(routeOTD.notifier).getSondeoFromDB();

    if (sondeos[index].idError != 0) {
      ref.read(showProgress1.notifier).update((state) => false);

      showYesNoMsj(
          context: context,
          yesOnly: true,
          title: 'Error',
          content:
              'Se produjo un error inesperado. Si el error persiste, elimina las tiendas e intentalo de nuevo.');
    } else {
      // Emulated Delay
      // await Future.delayed(const Duration(seconds: 1));

      navigator.push(MaterialPageRoute(builder: (context) {
        return SondeoPage(
            sondeosList: sondeos[index].resp ?? [],
            store: widget.store ?? Store2());
      }));
    }
  }

  //
}
