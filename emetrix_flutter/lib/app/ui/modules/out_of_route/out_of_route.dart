// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/ui.dart';

import 'controller.dart';
import 'loading_view.dart';
import 'state.dart';
import 'widgets/my_card.dart';

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
    final size = MediaQuery.of(context).size;
    // final isDark = ref.watch(themeProvider);

    switch (state.state) {
      case States.succes:
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: c.surface,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  GradientTitle(
                      height: size.height * 0.2,
                      width: size.width,
                      title1: '',
                      title2: 'Fuera de Ruta'),
                ],
              ),
              //
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(35)),
                child: Material(
                  child: Container(
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
                                    resp: storesMain[index]),
                              ),
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
                                  style: t.mediumLight,
                                  // isDark == ThemeMode.dark
                                  //     ? t.mediumDark
                                  //     : t.mediumLight,
                                  onTap: () => start(),
                                  width: size.width * 0.85,
                                  height: size.height * 0.065),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
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
    final navigator = Navigator.of(context);
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

      MesagessService.showSuccess(
          context: context, message: 'Agregados a Ruta del Dia!');
      await vibrate();
      // navigator.pop();
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
        return const MainPage();
      }), (route) => false);
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
