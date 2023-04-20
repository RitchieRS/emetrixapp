// ignore_for_file: use_build_context_synchronously

import 'package:emetrix_flutter/app/core/services/internet/conection_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/loading_view.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:emetrix_flutter/app/ui/drawer/drawer.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/controller.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/state.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class OutOfRoutePage extends ConsumerStatefulWidget {
  const OutOfRoutePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OutOfRoutePage> {
  List<Store> storesMain = [];
  List<Store> storesSelected = [];
  List<String> stores = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getStoresDB();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(outORControllerProvider);
    final isDark = ref.watch(themeProvider);
    final size = MediaQuery.of(context).size;

    switch (state.state) {
      case States.succes:
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GradientTitle(
                  height: size.height,
                  width: size.width,
                  title1: 'Fuera de',
                  title2: 'RUTA'),

              //
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(35)),
                child: Container(
                  height: size.height * 0.75,
                  width: size.width,
                  color: Theme.of(context).scaffoldBackgroundColor,
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
                                  resp: storesMain[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              stores.isNotEmpty
                  ? FadeIn(
                      duration: const Duration(milliseconds: 100),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.77),
                        child: Center(
                          child: isLoading
                              ? ButonLoading(
                                  background: c.primary,
                                  onFinish: null,
                                  width: size.width * 0.85,
                                  height: size.height * 0.065)
                              : ButonDimentions(
                                  background: c.primary,
                                  title:
                                      'Agregar Ruta${stores.length <= 1 ? '' : 's'}',
                                  style: isDark == ThemeMode.dark
                                      ? t.mediumDark
                                      : t.mediumLight,
                                  onTap: () => start(),
                                  width: size.width * 0.85,
                                  height: size.height * 0.065),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          drawer: const MyDrawer(),
        );
      case States.error:
        return ListView(
          children: [
            Center(child: Text(state.homeData?.idError.toString() ?? 'error'))
          ],
        );
      case States.loading:
        return const LoadingView();
    }
  }

  void selectedStores(int? index) {
    if (index != null) {
      stores.add(jsonEncode(storesMain[index]));
      storesSelected.add(storesMain[index]);
    } else {
      stores.removeAt(index ?? 0);
      storesSelected.removeAt(index ?? 0);
    }
    setState(() {});
  }

  Future getStoresDB() async {
    storesMain = await ref.read(outORControllerProvider.notifier).getStoresDB();
    setState(() {});
  }

  Future start() async {
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

  Future setStores() async {
    setState(() {
      isLoading = true;
    });
    final naivigator = Navigator.of(context);
    ref
        .read(outORControllerProvider.notifier)
        .setRoutesOTD(stores)
        .whenComplete(() async {
      setState(() {});
      final sondeos = await ref
          .read(outORControllerProvider.notifier)
          .getSondeosFromApi(storesSelected, ref);
      ref.read(outORControllerProvider.notifier).setSondeosToDB(sondeos);

      ref.read(cardProvider.notifier).update((state) => !state);
      stores.clear();
      storesSelected.clear();

      setState(() {
        isLoading = false;
      });

      ConetionService.showSuccess(
          context: context, message: 'Agregados a Ruta del Dia!');
      naivigator.pushNamed('routeOTD');
    });
  }

  // void showSnack() {
  //   final snackBar = SnackBar(
  //       duration: const Duration(seconds: 4),
  //       content: const Text('Agregados a Ruta del Dia!'),
  //       backgroundColor: c.ok.withOpacity(0.8));

  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}
