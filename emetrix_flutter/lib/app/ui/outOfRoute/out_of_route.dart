import 'dart:convert';

import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/title_gradient.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/route_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/ui/drawer/drawer.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/controller.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/state.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/button_dimentions.dart';
import 'widgets/shimmer_cards.dart';

class OutOfRoutePage extends ConsumerStatefulWidget {
  const OutOfRoutePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OutOfRoutePage> {
  List<Store?>? storesMain = [];
  List<String> stores = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = ref.read(outORControllerProvider.notifier);
      provider.init();
      storesMain = ref.watch(outORControllerProvider).homeData?.resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(outORControllerProvider);
    final size = MediaQuery.of(context).size;

    switch (state.state) {
      case States.succes:
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const GradientTitle(),

              //
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(35)),
                child: Container(
                  height: size.height * 0.75,
                  width: size.width,
                  color: ThemeData().scaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      addSemanticIndexes: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.homeData?.resp?.length,
                      itemBuilder: (context, index) => KeepAlive(
                        keepAlive: true,
                        child: IndexedSemantics(
                          index: index,
                          child: MyCard(
                              onChanged: (index) {
                                if (index != null) {
                                  stores.add(
                                      jsonEncode(state.homeData?.resp?[index]));
                                } else {
                                  stores.removeAt(index ?? 0);
                                }
                                setState(() {});
                              },
                              index: index,
                              resp: state.homeData?.resp?[index]),
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
                        padding: EdgeInsets.only(top: size.height * 0.8),
                        child: Center(
                          child: ButonDimentions(
                              background: c.primary,
                              title: stores.length <= 1
                                  ? 'Agregar Ruta'
                                  : 'Agregar Rutas',
                              style: t.mediumLight,
                              onTap: () {
                                ref
                                    .read(outORControllerProvider.notifier)
                                    .setRoutesOTD(stores)
                                    .whenComplete(() {
                                  showSnack();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RouteOfTheDayPage()));
                                });
                              },
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
        return Scaffold(
          body: Stack(
            children: [
              const GradientTitle(),
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(35)),
                child: Container(
                  height: size.height * 0.75,
                  width: size.width,
                  color: ThemeData().scaffoldBackgroundColor,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const LoadingCard();
                      }),
                ),
              ),
            ],
          ),
        );
    }
  }

  void showSnack() {
    final snackBar = SnackBar(
        content: const Text('Agregados a Ruta del Dia!'),
        backgroundColor: c.ok);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
