import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCard extends ConsumerStatefulWidget {
  const MyCard(
      {super.key,
      required this.index,
      required this.resp,
      required this.onChanged});
  final int index;
  final Store? resp;
  final Function(int?) onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard> {
  bool isBlue = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          child: InkWell(
            onTap: () {
              setState(() {
                isBlue = !isBlue;
              });
              widget.onChanged(isBlue ? widget.index : null);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: size.height * 0.107,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(1, 1))
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2,
                      color: isBlue
                          ? c.primary.withOpacity(0.35)
                          : Colors.transparent)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      color: isBlue ? c.primary : Colors.grey,
                      width: size.width * 0.011),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.storefront_sharp,
                      color: isBlue ? c.primary : Colors.grey,
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
                                  style: t.medium,
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
                          color:
                              isBlue ? c.error.withOpacity(0.75) : Colors.grey,
                          size: size.height * 0.03))
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
