import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';

import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/addActivities/controller.dart';
import 'package:emetrix_flutter/app/ui/addActivities/state.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/my_card.dart';

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
    Services.checkConectivity();
    getStoresDB();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addActControllerProvider);
    final size = MediaQuery.of(context).size;

    switch (state.state) {
      case States.succes:
        return Scaffold(
          body: Stack(
            children: [
              GradientTitle(
                  height: size.height * 0.4,
                  width: size.width,
                  title1: 'Actividades',
                  title2: 'EXTRAS'),
              //
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.18),
                child: RefreshIndicator(
                  onRefresh: getStoresDB,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(40)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: c.background,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
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
              ),
              //
            ],
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
