import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/home/controller.dart';
import 'package:emetrix_flutter/app/ui/home/state.dart';
import 'package:emetrix_flutter/app/ui/home/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/home/widgets/shimmer_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeControllerProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    switch (state.state) {
      case States.succes:
        return RefreshIndicator(
          onRefresh: ref.read(homeControllerProvider.notifier).init,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.homeData?.resp?.length ?? 1,
              itemBuilder: (context, index) {
                return MyCard(
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
                            rangoGPS: 0));
              }),
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
        return ListView.builder(
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return const LoadingCard();
            });
    }
  }
}
