import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectionMultiple extends ConsumerStatefulWidget {
  const SelectionMultiple({super.key, required this.question});
  final Preguntas question;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<SelectionMultiple>
    with AutomaticKeepAliveClientMixin {
  List<bool>? boollist = [];

  @override
  void initState() {
    super.initState();
    final boollist2 = widget.question.opciones?.map((e) => false).toList();
    boollist = boollist2;
    setState(() {});
    debugPrint(boollist.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    //top: size.height * 0.01

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(widget.question.pregunta ?? 'NoData', style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.01),
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.question.opciones?.length ?? 0,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                        value: boollist?[index],
                        onChanged: (newvalue) {
                          boollist?[index] = newvalue ?? false;
                          setState(() {});
                        }),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(widget.question.opciones?[index].opcion ?? '',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
