import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/outOfRoute/controller.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class MyCard extends ConsumerStatefulWidget {
  MyCard({
    super.key,
    required this.index,
    required this.resp,
    required this.onChanged,
    required this.canceled,
  });
  final int index;
  final Store? resp;
  final Function(int?) onChanged;
  bool canceled;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard> {
  bool isBlue = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    cancelColor();

    return FadeIn(
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.005),
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: InkWell(
              onTap: () {
                setState(() => isBlue = !isBlue);
                widget.onChanged(isBlue ? widget.index : null);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: size.height * 0.107,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  color: isBlue ? c.primary.withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.store,
                        color:
                            isBlue ? c.secondary.withOpacity(0.7) : Colors.grey,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: size.width * 0.02),
                            child: SizedBox(
                                width: size.width * 0.65,
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
                    const Spacer(),
                    IconButton(
                        onPressed: () => goMaps(),
                        icon: Icon(Icons.location_on,
                            color: isBlue
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

  cancelColor() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.canceled != true) {
        return;
      } else {
        setState(() {
          isBlue = false;
        });
        ref.read(cardProvider.notifier).update((state) => false);
      }
    });
  }

  Future goMaps() async {
    final lat = widget.resp?.latitud;
    final lon = widget.resp?.longitud;
    final Uri url =
        Uri.parse('http://maps.google.com/maps?z=12&t=m&q=loc:$lat+$lon');
    debugPrint(url.toString());
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
