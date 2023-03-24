import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/controller.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/widgets/empty.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/state.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/widgets/my_card2.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteOfTheDayPage extends ConsumerStatefulWidget {
  const RouteOfTheDayPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteOfTheDayPageState();
}

class _RouteOfTheDayPageState extends ConsumerState<RouteOfTheDayPage> {
  List<Store> stores = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(card.notifier).refreshState();

      final provider = ref.read(routeOTD.notifier);
      provider.getStores();
      stores = ref.watch(routeOTD).data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RouteOTDState state = ref.watch(routeOTD);
    stores = state.data;

    switch (state.state) {
      case States.succes:
        return Scaffold(
            body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const MyTitle(),

            //
            Container(
              height: size.height * 0.85,
              width: size.width,
              color: ThemeData().scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      // int reverseIndex = stores.length - 1 - index;
                      return MyCard2(index: index, resp: state.data[index]);
                    }),
              ),
            ),
          ],
        ));
      case States.error:
        return Scaffold(
          body: RefreshIndicator(
              onRefresh: ref.read(routeOTD.notifier).getStores,
              child: const EmptyList()),
        );

      case States.loading:
        return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()));
    }
  }
}
