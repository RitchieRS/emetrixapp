import 'package:emetrix_flutter/app/core/home/home.dart';
import 'package:emetrix_flutter/app/ui/home/controller.dart';
import 'package:emetrix_flutter/app/ui/home/state.dart';
import 'package:emetrix_flutter/app/ui/home/widgets/my_card.dart';
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
                    index: index, resp: state.homeData?.resp?[index] ?? Resp());
              }),
        );
      case States.error:
        return RefreshIndicator(
          onRefresh: ref.read(homeControllerProvider.notifier).init,
          child: Center(
              child: Text(state.homeData?.idError.toString() ?? 'error')),
        );
      case States.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
    }
  }
}
