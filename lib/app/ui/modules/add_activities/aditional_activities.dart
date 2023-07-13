import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/modules/out_of_route/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

import 'controller.dart';
import 'state.dart';

class AditionalActivitiesPage extends ConsumerStatefulWidget {
  const AditionalActivitiesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AditionalActivitiesPageState();
}

class _AditionalActivitiesPageState
    extends ConsumerState<AditionalActivitiesPage> {
  List<Store> storesMain = [];
  List<Store> storesSelected = [];
  List<String> stores = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getStoresDB();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addActControllerProvider);
    final size = MediaQuery.of(context).size;

    switch (state.state) {
      case States.succes:
        return Scaffold(
          appBar: const GradientTitle(title: 'EXTRAS'),
          body: Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: RefreshIndicator(
              onRefresh: getStoresDB,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(40)),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    addSemanticIndexes: false,
                    physics: const BouncingScrollPhysics(),
                    itemCount: storesMain.length,
                    itemBuilder: (context, index) => KeepAlive(
                      keepAlive: true,
                      child: MyCard(
                          // onChanged: (index) => selectedStores(index),
                          onChanged: (index) {},
                          canceled: false,
                          index: index,
                          resp: storesMain[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case States.error:
        return ListView(
          children: [
            Center(child: Text('error', style: t.text)),
          ],
        );
      case States.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  Future getStoresDB() async {
    storesMain = await ref
        .read(addActControllerProvider.notifier)
        .getAdditionalStoresDB();

    setState(() {});
  }
}
