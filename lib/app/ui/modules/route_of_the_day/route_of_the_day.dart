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
  // List<SondeosFromStore> list = [];

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
            appBar: MyTitle(sondeos: state.data),
            body: RefreshIndicator(
              onRefresh: () => getList(),
              child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return MyCard2(
                      index: index,
                      store: state.data[index],
                      onDeleted: () => onDeleted(index, state.data),
                    );
                  }),
            ),
          ),
        );
      case States.error:
        return Scaffold(
          appBar: MyTitle(sondeos: state.data),
          // drawer: const MyDrawer(),
          body: RefreshIndicator(
            onRefresh: () => getList(),
            child: const EmptyList(),
          ),
        );

      case States.loading:
        return Scaffold(
          appBar: MyTitle(sondeos: state.data),
          // drawer: MyDrawer(),
          body: const GeneralLoading(loadingCards: 3),
        );
    }
  }

  void onDeleted(int index, List<SondeosFromStore> state) async {
    await ref.read(routeOTD.notifier).deleteItem(state[index].id, ref);
    state.removeAt(index);
    setState(() {});
  }

  Future<void> getList() async {
    await ref.read(routeOTD.notifier).getStoresFromIsar(ref);
  }

  @override
  bool get wantKeepAlive => true;
}
