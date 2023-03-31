import 'dart:convert';

import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/loading_view.dart';
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

class OutOfRoutePage extends ConsumerStatefulWidget {
  const OutOfRoutePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<OutOfRoutePage> {
  List<Store> storesMain = [];
  List<String> stores = [];

  @override
  void initState() {
    super.initState();
    getStoresDB();
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
                      itemCount: storesMain.length,
                      itemBuilder: (context, index) => KeepAlive(
                        keepAlive: true,
                        child: IndexedSemantics(
                          index: index,
                          child: MyCard(
                              onChanged: (index) {
                                if (index != null) {
                                  stores.add(jsonEncode(storesMain[index]));
                                } else {
                                  stores.removeAt(index ?? 0);
                                }
                                setState(() {});
                              },
                              index: index,
                              resp: storesMain[index]),
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
                              title:
                                  'Agregar Ruta${stores.length <= 1 ? '' : 's'}',
                              style: t.mediumLight,
                              onTap: () {
                                ref
                                    .read(outORControllerProvider.notifier)
                                    .setRoutesOTD(stores)
                                    .whenComplete(() {
                                  setState(() {
                                    ref.read(card.notifier).hide();
                                    stores.clear();
                                  });

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
        return const LoadingView();
    }
  }

  Future getStoresDB() async {
    storesMain = await ref.read(outORControllerProvider.notifier).getStoresDB();
    setState(() {});
  }

  void showSnack() {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Agregados a Ruta del Dia!'),
        backgroundColor: c.ok.withOpacity(0.8));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
