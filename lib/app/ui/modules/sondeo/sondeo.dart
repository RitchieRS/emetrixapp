// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:page_transition/page_transition.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/widgets/type_sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SondeoPage extends ConsumerStatefulWidget {
  const SondeoPage({
    super.key,
    required this.sondeosList,
    required this.store,
    required this.storeUuid,
  });
  final List<RespM> sondeosList;
  final Store2 store;
  final String storeUuid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage> {
  List<RespM> sondeosList2 = [];

  @override
  void initState() {
    super.initState();
    sondeosList2 =
        ref.read(sondeoController.notifier).reorderList(widget.sondeosList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider);
    final onlyFirst = ref.watch(onlyFirstProvider);
    final finishedSections = ref.watch(finishedSondeos);
    final completeAll = finishedSections.length == sondeosList2.length;
    debugPrint('Finished Sections: $finishedSections');
    // final currentOption = ref.watch(currentOptionProvider);
    //*Close and save to db the current Navigator state, when the app restart, restore the Navigator state

    return WillPopScope(
      // onWillPop: () => onPop(),
      onWillPop: () => onExit(finishedSections),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.store.tienda}',
                  style: isDark == ThemeMode.dark
                      ? t.subtitleLight
                      : t.subtitleDark,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2),
              Text(
                  '${finishedSections.length} de ${sondeosList2.length} sondeos',
                  style: t.textDisabled)
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: size.height * 0.11,
          actions: [
            IconButton(
                onPressed: () => onExit(finishedSections),
                icon: Icon(Icons.exit_to_app,
                    color:
                        completeAll ? c.error : Theme.of(context).hintColor)),
          ],
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: c.surface),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            //

            SliverList.builder(
              // padding: EdgeInsets.only(
              //     left: size.height * 0.01, right: size.height * 0.01),
              itemCount: sondeosList2.length,
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                final enabled = index != 0 && onlyFirst; //One then all
                // final enabled = index <= currentOption;        //One by one
                // final enabled = index <= sondeosList2.length;  //All

                return FadeIn(
                  child: TypeSondeo(
                    onTap: !enabled ? () => navigateToSondeo(index) : null,
                    enebled: !enabled,
                    sondeoItem: sondeosList2[index],
                    index: index,
                    isLast: index + 1 == sondeosList2.length ? true : false,
                  ),
                );
              },
            )
            //
          ],
        ),
      ),
    );
  }

  void navigateToSondeo(int index) {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 350),
            type: PageTransitionType.rightToLeft,
            child: SingleSondeoPage(
              store: widget.store,
              sondeoItem: sondeosList2[index],
              index: index,
              stepsLenght: sondeosList2.length,
              storeUuid: widget.storeUuid,
            )));
  }

  Future<bool> onExit(List<int> finishedSections) async {
    final navigator = Navigator.of(context);

    if (finishedSections.length == sondeosList2.length) {
      final option = await showMsj(
          context: context,
          title: 'Sondeo completado',
          content:
              'Excelente completaste los sondeos. Guarda el progreso para salir.',
          destructive: false,
          onlyOk: true,
          canTapOutside: true,
          buttonLabel: 'Guardar y Salir');

      if (option) {
        ref.read(currentOptionProvider.notifier).update((state) => 0);
        ref.read(onlyFirstProvider.notifier).update((state) => true);
        ref.read(finishedSondeos.notifier).update((state) => []); //
        ref.read(showProgress1.notifier).update((state) => false);

        showProgress(context: context, title: 'Guardando progreso..');
        await Future.delayed(const Duration(seconds: 1));
        navigator.pop();
        navigator.pop();
      }
      return true;
    }

    await showMsj(
        context: context,
        title: 'Cuidado...',
        content: 'Aun hay sondeos obligatorios.',
        destructive: false,
        canTapOutside: true,
        onlyOk: true,
        buttonLabel: 'Aceptar');
    return false;
  }

  //
}
