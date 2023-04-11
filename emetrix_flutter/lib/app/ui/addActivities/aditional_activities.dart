import 'package:emetrix_flutter/app/core/services/main.dart';
import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/addActivities/controller.dart';
import 'package:emetrix_flutter/app/ui/addActivities/state.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/widgets/my_card.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/gradient_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            // alignment: Alignment.bottomCenter,
            children: [
              GradientTitle(
                height: size.height * 0.4,
                width: size.width,
                title1: 'Actividades',
                title2: 'ADICIONALES',
              ),
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
              // stores.isNotEmpty
              //     ? FadeIn(
              //         duration: const Duration(milliseconds: 100),
              //         child: Padding(
              //           padding: EdgeInsets.only(top: size.height * 0.8),
              //           child: Center(
              //             child: isLoading
              //                 ? ButonLoading(
              //                     background: c.primary,
              //                     onFinish: null,
              //                     width: size.width * 0.85,
              //                     height: size.height * 0.065)
              //                 : ButonDimentions(
              //                     background: c.primary,
              //                     title:
              //                         'Agregar Ruta${stores.length <= 1 ? '' : 's'}',
              //                     style: t.mediumLight,
              //                     onTap: () => start(),
              //                     width: size.width * 0.85,
              //                     height: size.height * 0.065),
              //           ),
              //         ),
              //       )
              //     : Container()
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

    // debugPrint(storesMain.length.toString());
    setState(() {});
  }
}
