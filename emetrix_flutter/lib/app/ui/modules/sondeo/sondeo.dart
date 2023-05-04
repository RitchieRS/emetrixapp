// ignore_for_file: use_build_context_synchronously

import 'package:emetrix_flutter/app/ui/modules/sondeo/components/type_sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({super.key, required this.sondeosList, required this.store});
  final List<RespM> sondeosList;
  final Store store;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage> {
  List<RespM> sondeosList2 = [];

  @override
  void initState() {
    super.initState();

    setState(() {});
    sondeosList2 =
        ref.read(sondeoController.notifier).reorderList(widget.sondeosList);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);
    final currentOption = ref.watch(currentOptionProvider);

    //Close and save to db the current Navigator state, when the app restart, restore the Navigator state

    return WillPopScope(
      onWillPop: () async {
        return await onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.store.tienda}',
              style:
                  isDark == ThemeMode.dark ? t.subtitleLight : t.subtitleDark,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: size.height * 0.1,
          actions: [
            IconButton(
                onPressed: () => onExit(currentOption),
                icon: Icon(Icons.exit_to_app, color: c.error)),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            //

            ListView.builder(
              padding: EdgeInsets.only(
                  left: size.height * 0.01, right: size.height * 0.01),
              itemCount: sondeosList2.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final enabled = index <= currentOption;

                return TypeSondeo(
                  onTap: enabled
                      ? () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: const Duration(milliseconds: 350),
                                  type: PageTransitionType.rightToLeft,
                                  child: SondeosBuilder(
                                    store: widget.store,
                                    sondeoItem: sondeosList2[index],
                                    index: index,
                                  )));
                        }
                      : null,
                  enebled: enabled,
                  sondeoItem: sondeosList2[index],
                  index: index,
                  isLast: index + 1 == sondeosList2.length ? true : false,
                );
              },
            )
            //
          ],
        ),
      ),
    );
  }

  Future<bool> onPop() async {
    final bool exit = await showMsj(
        context: context,
        title: 'Cuidado...',
        content:
            'Perderás todo el progreso si sales ahora. ¿Seguro deseas salir?',
        destructive: true,
        buttonLabel: 'Salir');

    if (exit) {
      ref.read(currentOptionProvider.notifier).update((state) => 0);
    }

    setState(() {
      ref.read(showProgress1.notifier).update((state) => false);
    });

    return Future.value(exit);
  }

  Future onExit(int currentOption) async {
    final navigator = Navigator.of(context);

    //Check First Validations of each component

    if (currentOption == sondeosList2.length) {
      final option = await showMsj(
          context: context,
          title: 'Salir',
          content:
              'Excelente completaste los sondeos. Guarda el progreso para salir.',
          destructive: false,
          buttonLabel: 'Guardar y Salir');

      if (option) {
        ref.read(currentOptionProvider.notifier).update((state) => 0);

        setState(() {
          ref.read(showProgress1.notifier).update((state) => false);
        });
        navigator.pop();
      }
      return;
    }

    await showMsj(
        context: context,
        title: 'Cuidado...',
        content: 'Aun hay sondeos obligatorios.',
        destructive: false,
        onlyOk: true,
        buttonLabel: 'Aceptar');
  }
}
