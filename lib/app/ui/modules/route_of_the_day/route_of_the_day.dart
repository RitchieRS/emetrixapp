import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/general_loading.dart';
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

class _RouteOfTheDayPageState extends ConsumerState<RouteOfTheDayPage>
    with AutomaticKeepAliveClientMixin {
  List<SondeosFromStore> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(routeOTD);

    switch (state.state) {
      case States.succes:
        return SafeArea(
          child: Scaffold(
            appBar: MyTitle(sondeos: list),
            body: RefreshIndicator(
              onRefresh: () => getList(),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return MyCard2(
                      index: index,
                      store: list[index],
                      onDeleted: () => onDeleted(index),
                    );
                  }),
            ),
          ),
        );
      case States.error:
        return Scaffold(
          appBar: MyTitle(sondeos: list),
          // drawer: const MyDrawer(),
          body: RefreshIndicator(
            onRefresh: () => getList(),
            child: const EmptyList(),
          ),
        );

      case States.loading:
        return Scaffold(
          appBar: MyTitle(sondeos: list),
          // drawer: MyDrawer(),
          body: const GeneralLoading(loadingCards: 3),
        );
    }
  }

  void onDeleted(int index) async {
    await ref.read(routeOTD.notifier).deleteItem(list[index].id, ref);
    list.removeAt(index);
    setState(() {});
  }

  Future<void> getList() async {
    list = await ref.read(routeOTD.notifier).getStoresFromIsar(ref);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
