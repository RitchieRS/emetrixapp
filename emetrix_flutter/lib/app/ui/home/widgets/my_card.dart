import 'package:emetrix_flutter/app/core/stores/stores.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCard extends ConsumerStatefulWidget {
  const MyCard({super.key, required this.index, required this.resp});
  final int index;
  final Store resp;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends ConsumerState<MyCard> {
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
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Ink(
              height: size.height * 0.107,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 10.0,
                        offset: const Offset(1, 1))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(color: Colors.grey, width: size.width * 0.012),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.storefront_sharp, color: Colors.grey),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Container(
                              width: size.width * 0.65,
                              color: Colors.transparent,
                              child: Text('${widget.resp.tienda}',
                                  style: t.medium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis))),
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Text('Cadena: ${widget.resp.idCadena}',
                              style: t.text)),
                      Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02),
                          child: Text('Grupo: ${widget.resp.idGrupo}',
                              style: t.text)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on,
                          color: Colors.grey, size: size.height * 0.03))
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(Icons.arrow_forward_ios,
                  //       color: Colors.grey, size: size.height * 0.025),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
