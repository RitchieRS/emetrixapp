import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/route_of_the_day/controller.dart';

import 'state.dart';
import 'widgets/empty.dart';
import 'widgets/my_card2.dart';
import 'widgets/title.dart';

class RouteOfTheDayPage extends ConsumerStatefulWidget {
  const RouteOfTheDayPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteOfTheDayPageState();
}

class _RouteOfTheDayPageState extends ConsumerState<RouteOfTheDayPage> {
  List<Store> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      list = await ref.read(routeOTD.notifier).getStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(routeOTD);

    switch (state.state) {
      case States.succes:
        return Scaffold(
          appBar: const MyTitle(),
          body: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0),
              physics: const BouncingScrollPhysics(),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                // int reverseIndex = stores.length - 1 - index;
                return MyCard2(
                  index: index,
                  resp: state.data[index],
                  onDeleted: onDeleted,
                );
              }),
        );
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

  void onDeleted(int index) {
    setState(() {
      list.removeAt(index);
    });
    ref.read(routeOTD.notifier).deleteItem(index);
  }
}
