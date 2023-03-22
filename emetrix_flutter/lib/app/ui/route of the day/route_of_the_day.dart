import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/controller.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/empty.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/state.dart';
import 'package:emetrix_flutter/app/ui/route%20of%20the%20day/widgets/my_card2.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
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
      final provider = ref.read(routeOTD.notifier);
      provider.getStores();
      stores = ref.watch(routeOTD).data;
    });
  }

  @override
  Widget build(BuildContext context) {
    RouteOTDState state = ref.watch(routeOTD);
    stores = state.data;

    switch (state.state) {
      case States.succes:
        return Scaffold(
            appBar: AppBar(
              title: Text('Ruta', style: t.titleBlue),
              backgroundColor: ThemeData().scaffoldBackgroundColor,
              elevation: 0,
            ),
            body: FutureBuilder(
              future: ref.read(routeOTD.notifier).getStores(),
              builder: (context, snapshot) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      return MyCard2(index: index, resp: state.data[index]);
                    });
              },
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
