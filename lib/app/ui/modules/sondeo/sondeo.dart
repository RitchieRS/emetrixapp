// ignore_for_file: use_build_context_synchronously
import 'package:emetrix_flutter/app/core/services/database/database.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';
import 'package:emetrix_flutter/app/ui/modules/products_sku/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/ui/main/controller.dart';
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
    required this.mainStore,
  });
  final List<RespM> sondeosList;
  final Store2 store;
  final String storeUuid;
  final SondeosFromStore? mainStore;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SondeoPageState();
}

class _SondeoPageState extends ConsumerState<SondeoPage>
    with AutomaticKeepAliveClientMixin {
  List<(String, int)> mandatorySteps = [];
  int missingSteps = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getStepsState();
      identifyRequiredSteps();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final onlyFirst = ref.watch(onlyFirstProvider);
    final finishedSections = ref.watch(finishedSondeos);
    final completeAll = finishedSections.length == widget.sondeosList.length;
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
          Text(
              '${finishedSections.length} de ${widget.sondeosList.length} sondeos',
              style: t.textDisabled)
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: size.height * 0.11,
      actions: [
        IconButton(
            onPressed: () => onExit(finishedSections, true, onlyFirst),
            icon: Icon(Icons.exit_to_app,
                color: completeAll ? c.error : Theme.of(context).hintColor)),
      ],
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: c.surface),
    );
    debugPrint('Finished Sections: $finishedSections');
    //*Close and save to db the current Navigator state, when the app restart, restore the Navigator state

    return PopScope(
      canPop: finishedSections.isEmpty ? true : false,
      onPopInvoked: (didPop) async {
        if (finishedSections.isNotEmpty) {
          final state = StepsState(
              completedSections: finishedSections, firstOption: onlyFirst);
          await ref
              .read(databaseProvider)
              .saveStepsState(storeUuid: widget.storeUuid, state: state);
        }
      },
      child: Scaffold(
        appBar: appbar,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList.builder(
              itemCount: widget.sondeosList.length,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
              itemBuilder: (BuildContext context, int index) {
                final enabled = index != 0 && onlyFirst; //One then all
                // final enabled = index <= currentOption;        //One by one
                // final enabled = index <= sondeosList2.length;  //All

                return FadeIn(
                  child: TypeSondeo(
                    onTap: () async {
                      if (widget.mainStore?.finishedSections != null) {
                        MesagessService().showWarning(
                            context: context, message: 'Sondeo Completado');
                        return;
                      }

                      try {
                        if (!enabled) {
                          await navigateToSondeo(index, finishedSections);
                          setState(() {});
                          return;
                        }
                      } catch (error) {
                        logger.e(error);
                      }
                    },
                    enebled: !enabled,
                    sondeoItem: widget.sondeosList[index],
                    index: index,
                    isLast:
                        index + 1 == widget.sondeosList.length ? true : false,
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

  Future<void> navigateToSondeo(int index, List<int> finishedSections) async {
    if (widget.sondeosList[index].sondeo == 'Asistencia') {
      if (finishedSections.contains(index)) {
        await _messaje('Cuidado', 'Ya tomaste asistencia.', null);
        return;
      }
    }
    if (widget.sondeosList[index].sondeo == 'Salida') {
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
    await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return // sondeosList2[index].preguntas?.first.tipo == 'asistencia'
          widget.sondeosList[index].sondeo == 'Asistencia' ||
                  widget.sondeosList[index].sondeo == 'Salida'
              ? MapView(
                  store: widget.store,
                  sondeoItem: widget.sondeosList[index],
                  index: index,
                  storeUuid: widget.storeUuid,
                )
              : widget.sondeosList[index].capturaSku == 1
                  ? ProductsSkuPage(
                      store: widget.store,
                      sondeoItem: widget.sondeosList[index],
                      index: index,
                      stepsLenght: widget.sondeosList.length,
                      storeUuid: widget.storeUuid,
                      stepUuid: widget.sondeosList[index].uuid ?? '',
                    )
                  : SingleSondeoPage(
                      store: widget.store,
                      sondeoItem: widget.sondeosList[index],
                      index: index,
                      stepsLenght: widget.sondeosList.length,
                      storeUuid: widget.storeUuid,
                      stepUuid: widget.sondeosList[index].uuid ?? '',
                    );
    }));
  }

  void identifyRequiredSteps() {
    for (final sondeo in widget.sondeosList) {
      if (sondeo.obligatorio == 1) {
        final index = widget.sondeosList.indexOf(sondeo);
        mandatorySteps.add((sondeo.sondeo ?? '', index));
      }
    }
    debugPrint(mandatorySteps.toString());
    setState(() {});
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
  }

  Future<void> _getStepsState() async {
    if (widget.mainStore?.finishedSections != null) {
      ref.read(onlyFirstProvider.notifier).update(
          (state) => widget.mainStore?.finishedSections?.firstOption ?? true);
      ref.read(finishedSondeos.notifier).update((state) =>
          widget.mainStore?.finishedSections?.completedSections ?? []);
      setState(() {});
    } else {
      ref.read(onlyFirstProvider.notifier).update((state) => true);
      ref.read(finishedSondeos.notifier).update((state) => []);
      setState(() {});
    }
  }

  Future<void> onExit(
      List<int> finishedSections, bool isIcon, bool onlyFirst) async {
    if (widget.mainStore?.savedToPendings != null) {
      Navigator.pop(context);
      return;
    }

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
    if (!finishedSections
        .contains(widget.sondeosList.indexOf(widget.sondeosList.last))) {
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
      ref.read(finishedSondeos.notifier).update((state) => []); //

      showProgress(context: context, title: 'Guardando progreso');
      await Future.delayed(const Duration(seconds: 1));
      //Build Pending
      await ref.read(sondeoController.notifier).buildFinalPending(
          widget.sondeosList.first, widget.store, ref, widget.storeUuid);

      navigator.pop();
      ref.read(mainIndex.notifier).setIndex(1);
      await ref.read(databaseProvider).saveStepsState(
          storeUuid: widget.storeUuid,
          state: StepsState(
            completedSections: finishedSections,
            firstOption: onlyFirst,
          ));
      await ref
          .read(databaseProvider)
          .setFinisedFlagOnStore(storeUuid: widget.storeUuid);

      //get the stores in the home to refresh state
      navigator.pop();
      await ref.read(routeOTD.notifier).getStoresFromIsar(ref);
      return;
    }
    return;
  }

  @override
  bool get wantKeepAlive => true;

  //
}
