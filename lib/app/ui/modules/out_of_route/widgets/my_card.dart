import 'package:emetrix_flutter/app/core/modules/stores/stores.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/ui/modules/out_of_route/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/map_page.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MyCard extends ConsumerStatefulWidget {
  const MyCard({
    super.key,
    required this.index,
    required this.resp,
    required this.onChanged,
    required this.canceled,
  });
  final int index;
  final Store? resp;
  final Function(int?) onChanged;
  final bool canceled;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.125;
    final width = size.width * 0.95;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    // cancelColor();

    return FadeIn(
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.005),
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: InkWell(
              onTap: () {
                setState(() => isSelected = !isSelected);
                widget.onChanged(isSelected ? widget.index : null);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: isSelected
                      ? isDark
                          ? c.primary100.withOpacity(0.5)
                          : c.primary100
                      : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: size.width * 0.013,
                    //   height: double.infinity,
                    //   color: c.secondary,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: SizedBox(
                                  width: size.width * 0.58,
                                  child: Text('${widget.resp?.tienda}',
                                      style: t.mediumBold,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis))),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Text('Cadena: ${widget.resp?.idCadena}',
                                  style: t.text)),
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Text('Grupo: ${widget.resp?.idGrupo}',
                                  style: t.text)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                        label: const Text('Maps'),
                        onPressed: isSelected ? () => goMapsPage() : null,
                        icon: Icon(Icons.location_on,
                            color: isSelected
                                ? c.error.withOpacity(0.75)
                                : Colors.grey,
                            size: size.height * 0.03))
                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void cancelColor() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.canceled != true) {
        return;
      } else {
        setState(() {
          isSelected = false;
        });
        ref.read(cardProvider.notifier).update((state) => false);
      }
    });
  }

  Future<void> goMapsPage() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MapsPage(store: widget.resp)));
  }

  @override
  bool get wantKeepAlive => true;

  // Future goMaps() async {
  //   final lat = widget.resp?.latitud;
  //   final lon = widget.resp?.longitud;
  //   final Uri url =
  //       Uri.parse('http://maps.google.com/maps?z=12&t=m&q=loc:$lat+$lon');
  //   debugPrint(url.toString());
  //   await launchUrl(url, mode: LaunchMode.externalApplication);
  // }
}
