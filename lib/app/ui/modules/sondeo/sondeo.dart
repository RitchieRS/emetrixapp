// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/ui/main/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:page_transition/page_transition.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/components.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/sondeo_individual.dart';
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
  List<(String, int)> mandatorySteps = [];
  int missingSteps = 0;

  @override
  void initState() {
    super.initState();
    sondeosList2 =
        ref.read(sondeoController.notifier).reorderList(widget.sondeosList);
    identifyRequiredSteps();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final onlyFirst = ref.watch(onlyFirstProvider);
    final finishedSections = ref.watch(finishedSondeos);
    final completeAll = finishedSections.length == sondeosList2.length;
    final appbar = AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.store.tienda}',
              style: isDark ? t.subtitleLight : t.subtitleDark,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2),
          Text('${finishedSections.length} de ${sondeosList2.length} sondeos',
              style: t.textDisabled)
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: size.height * 0.11,
      actions: [
        IconButton(
            onPressed: () => onExit(finishedSections, true),
            icon: Icon(Icons.exit_to_app,
                color: completeAll ? c.error : Theme.of(context).hintColor)),
      ],
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: c.surface),
    );
    debugPrint('Finished Sections: $finishedSections');
    //*Close and save to db the current Navigator state, when the app restart, restore the Navigator state

    return WillPopScope(
      onWillPop: () => Future.value(false),
      // onWillPop: () => onExit(finishedSections, false),
      child: Scaffold(
        appBar: appbar,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList.builder(
              itemCount: sondeosList2.length,
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                final enabled = index != 0 && onlyFirst; //One then all
                // final enabled = index <= currentOption;        //One by one
                // final enabled = index <= sondeosList2.length;  //All

                return FadeIn(
                  child: TypeSondeo(
                    onTap: !enabled
                        ? () => navigateToSondeo(index, finishedSections)
                        : null,
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

  Future<bool> _messaje(
      String title, String content, String? butonLabel) async {
    return await showMsj(
        context: context,
        title: title,
        content: content,
        destructive: false,
        canTapOutside: true,
        onlyOk: true,
        buttonLabel: butonLabel ?? 'Aceptar');
  }

  void navigateToSondeo(int index, List<int> finishedSections) async {
    if (sondeosList2[index].sondeo == 'Asistencia') {
      if (finishedSections.contains(index)) {
        await _messaje('Cuidado', 'Ya tomaste asistencia.', null);
        return;
      }
    }
    if (sondeosList2[index].sondeo == 'Salida') {
      if (finishedSections.contains(index)) {
        await _messaje('Cuidado', 'Ya hicíste checkOut.', null);
        return;
      }

      verifyIsFinished(finishedSections);
      setState(() {});
      String message = missingSteps <= 1
          ? 'Aún hay $missingSteps sondeo obligatorio.'
          : 'Aún hay $missingSteps sondeos obligatorios.';

      if (missingSteps != 0) {
        await _messaje('Cuidado', message, null);
        return;
      }
    }
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 350),
            type: PageTransitionType.rightToLeft,
            child:
                // sondeosList2[index].preguntas?.first.tipo == 'asistencia'
                sondeosList2[index].sondeo == 'Asistencia' ||
                        sondeosList2[index].sondeo == 'Salida'
                    ? MapView(
                        store: widget.store,
                        sondeoItem: sondeosList2[index],
                        index: index,
                        storeUuid: widget.storeUuid,
                      )
                    : SingleSondeoPage(
                        store: widget.store,
                        sondeoItem: sondeosList2[index],
                        index: index,
                        stepsLenght: sondeosList2.length,
                        storeUuid: widget.storeUuid,
                      )));
  }

  void identifyRequiredSteps() {
    for (final sondeo in sondeosList2) {
      if (sondeo.obligatorio == 1) {
        final index = sondeosList2.indexOf(sondeo);
        mandatorySteps.add((sondeo.sondeo ?? '', index));
      }
    }
    debugPrint(mandatorySteps.toString());
  }

  void verifyIsFinished(List<int> finishedSections) {
    setState(() {
      missingSteps = mandatorySteps.length;
    });

    if (finishedSections.isEmpty) {
      Navigator.pop(context);
      return;
    }

    for (final step in mandatorySteps) {
      if (finishedSections.contains(step.$2)) {
        setState(() => missingSteps--);
      } else {
        setState(() {
          missingSteps = mandatorySteps.length;
        });
      }
    }

    // for (final index in finishedSections) {
    //   for (final step in mandatorySteps) {
    //     if (index == step.$2) {
    //       missingSteps--;
    //     } else {
    //       missingSteps++;
    //     }
    //   }
    // }
  }

  Future<void> onExit(List<int> finishedSections, bool isIcon) async {
    final navigator = Navigator.of(context);
    verifyIsFinished(finishedSections);
    if (finishedSections.isEmpty) return;

    String message = missingSteps <= 1
        ? 'Aun hay $missingSteps sondeo obligatorio.'
        : 'Aun hay $missingSteps sondeos obligatorios.';

    if (missingSteps != 0) {
      await _messaje('Cuidado', message, null);
      return;
      // return false;
    }
    if (!finishedSections.contains(sondeosList2.indexOf(sondeosList2.last))) {
      await _messaje('Sondeo Incompleto', 'Debes Hacer CheckOut', null);
      return;
      // return false;
    }
    final option = await _messaje(
      'Sondeo completado',
      'Excelente completaste los sondeos. Guarda el progreso para salir.',
      'Guardar y Salir',
    );

    if (option) {
      ref.read(currentOptionProvider.notifier).update((state) => 0);
      ref.read(onlyFirstProvider.notifier).update((state) => true);
      ref.read(finishedSondeos.notifier).update((state) => []); //

      showProgress(context: context, title: 'Guardando progreso');
      await Future.delayed(const Duration(seconds: 1));
      //Build Pending
      await ref
          .read(sondeoController.notifier)
          .buildPending(sondeosList2[0], widget.store, ref, widget.storeUuid);

      navigator.pop();
      ref.read(mainIndex.notifier).setIndex(1);
      navigator.pop();
      return;
      // return true;
    }
    // if (isIcon == true) Navigator.pop(context);
    return;
    // return false;
  }

  //
}
