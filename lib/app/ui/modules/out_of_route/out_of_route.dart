// ignore_for_file: use_build_context_synchronously
// import 'dart:convert';
import 'package:emetrix_flutter/app/core/modules/stores/all_stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/general_loading.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/global/ui.dart';

import 'controller.dart';
import 'state.dart';
import 'widgets/my_card.dart';

class OutOfRoutePage extends ConsumerStatefulWidget {
  const OutOfRoutePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OutOfRoutePage> {
  List<StoreGeneral> storesMain = [];
  List<StoreGeneral> storesSelected = [];
  // List<String> stores = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getStoresDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(outORControllerProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.85;
    final height = size.height * 0.065;
    // final isDark = ref.watch(themeProvider);

    switch (state.state) {
      case States.succes:
        return Scaffold(
          appBar: const GradientTitle(title: 'Fuera de Ruta'),
          body: Material(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                //
                Container(
                  height: size.height * 0.87,
                  width: size.width,
                  color: Theme.of(context).dialogBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: RefreshIndicator(
                      onRefresh: getStoresDB,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        addSemanticIndexes: false,
                        physics: const BouncingScrollPhysics(),
                        itemCount: storesMain.length,
                        itemBuilder: (context, index) => KeepAlive(
                          keepAlive: true,
                          child: IndexedSemantics(
                            index: index,
                            child: GestureDetector(
                              onTap: () {},
                              child: MyCard(
                                  onChanged: (index) => selectedStores(index),
                                  canceled: ref.watch(cardProvider),
                                  index: index,
                                  resp: toStore(storesMain[index])),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                storesSelected.isNotEmpty
                    ? FadeIn(
                        duration: const Duration(milliseconds: 100),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.7),
                          child: Center(
                            child: isLoading
                                ? ButonLoading(
                                    background: c.primary,
                                    onFinish: null,
                                    width: width,
                                    height: height)
                                : ButonDimentions(
                                    background: c.primary,
                                    title:
                                        'Agregar Ruta${storesSelected.length <= 1 ? '' : 's'}',
                                    style: t.mediumLight,
                                    onTap: () => start(),
                                    width: width,
                                    height: height),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      case States.error:
        return Scaffold(
          appBar: const GradientTitle(title: 'Fuera de Ruta'),
          body: ListView(
            children: [
              Center(
                  child: Text(
                      state.homeData?.idError.toString() ??
                          'Hubo un problema con la descarga de tiendas. Inténtalo de nuevo.',
                      style: t.mediumDark))
            ],
          ),
        );
      case States.loading:
        return const Scaffold(
          appBar: GradientTitle(title: 'Fuera de Ruta'),
          body: GeneralLoading(loadingCards: 4),
        );
    }
  }

  Store toStore(StoreGeneral storeGeneral) {
    return Store(
      checkGPS: storeGeneral.checkGPS,
      clasificacion: storeGeneral.clasificacion,
      definirNombre: storeGeneral.definirNombre,
      id: storeGeneral.id,
      idCadena: storeGeneral.idCadena,
      idGrupo: storeGeneral.idGrupo,
      latitud: storeGeneral.latitud,
      longitud: storeGeneral.longitud,
      rangoGPS: storeGeneral.rangoGPS,
      tienda: storeGeneral.tienda,
    );
  }

  void selectedStores(int? index) {
    if (index != null) {
      storesSelected.add(storesMain[index]);
      setState(() {});
      return;
    }
    storesSelected.removeAt(index ?? 0);
    setState(() {});
  }

  Future<void> getStoresDB() async {
    storesMain =
        await ref.read(outORControllerProvider.notifier).getAllStoresIsar(ref);
    setState(() {});
  }

  Future<void> start() async {
    final networkResult = await (Connectivity().checkConnectivity());

    if (networkResult == ConnectivityResult.none) {
      showYesNoMsj(
          context: context,
          yesOnly: true,
          title: 'Sin Conexión',
          content:
              'Conéctate a internet para poder descargar los sondeos de la/s tiendas seleccionadas.');
    } else {
      await setStores();
    }
  }

  Future<void> setStores() async {
    setState(() {
      isLoading = true;
    });
    final navigator = Navigator.of(context);
    ref
        .read(outORControllerProvider.notifier)
        .saveStoresToIsar(storesSelected, ref)
        .whenComplete(() async {
      setState(() {});
      final sondeos = await ref
          .read(outORControllerProvider.notifier)
          .getSondeosFromApi(storesSelected, ref);
      ref.read(outORControllerProvider.notifier).setSondeosToDB(sondeos);

      ref.read(cardProvider.notifier).update((state) => !state);
      // stores.clear();
      storesSelected.clear();

      setState(() {
        isLoading = false;
      });

      MesagessService.showSuccess(
          context: context, message: 'Agregados a Ruta del Dia!');
      await vibrate();
      // navigator.pop();
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
        return const MainPage();
      }), (route) => false);
    });
  }
}
