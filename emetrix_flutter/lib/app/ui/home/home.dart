import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/drawer/drawer.dart';
import 'package:emetrix_flutter/app/ui/home/controller.dart';
import 'package:emetrix_flutter/app/ui/home/state.dart';
import 'package:emetrix_flutter/app/ui/home/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/home/widgets/shimmer_cards.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/button_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<int> indexes = [];
  @override
  void initState() {
    super.initState();
    ref.read(homeControllerProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);
    final size = MediaQuery.of(context).size;

    switch (state.state) {
      case States.succes:
        return Scaffold(
          appBar: AppBar(
              title: Text('Visita fuera de ruta', style: t.mediumBlue2),
              elevation: 0,
              backgroundColor: ThemeData().scaffoldBackgroundColor,
              centerTitle: true),
          body: Stack(
            children: [
              RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: size.height * 0.02),
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
                              debugPrint(index.toString());
                              if (index != null) {
                                indexes.add(index);
                              } else {
                                indexes.removeAt(index ?? 0);
                              }
                              setState(() {});
                            },
                            index: index,
                            resp: state.homeData?.resp?[index] ??
                                Store(
                                    id: '',
                                    tienda: '',
                                    latitud: 0,
                                    longitud: 0,
                                    idGrupo: '',
                                    idCadena: '',
                                    definirNombre: 0,
                                    clasificacion: '',
                                    checkGPS: '',
                                    rangoGPS: 0)),
                      ),
                    ),
                  )),
              indexes.isNotEmpty
                  ? FadeIn(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.7),
                        child: Center(
                          child: ButonDimentions(
                              background: c.primary,
                              title: 'Continuar',
                              style: t.mediumLight,
                              onTap: () {},
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
        return RefreshIndicator(
          onRefresh: ref.read(homeControllerProvider.notifier).init,
          child: ListView(
            children: [
              Center(child: Text(state.homeData?.idError.toString() ?? 'error'))
            ],
          ),
        );
      case States.loading:
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(''),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const LoadingCard();
              }),
        );
    }
  }

  Future refresh() {
    setState(() {});
    return ref.read(homeControllerProvider.notifier).init();
  }
}
