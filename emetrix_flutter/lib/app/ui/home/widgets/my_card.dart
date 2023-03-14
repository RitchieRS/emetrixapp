import 'package:emetrix_flutter/app/core/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCard extends ConsumerStatefulWidget {
  const MyCard({super.key, required this.index, required this.resp});
  final int index;
  final Resp resp;

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
          borderRadius: BorderRadius.circular(14),
          child: Container(
            color: Colors.white,
            height: size.height * 0.11,
            width: size.width * 0.95,
            child: Row(
              children: [
                Container(
                    color: Colors.primaries[widget.index],
                    width: size.width * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: size.width / 3),
                  child: Text('${widget.resp.sondeo} '),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
