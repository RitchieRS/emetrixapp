import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectionMultiple extends ConsumerStatefulWidget {
  const SelectionMultiple({
    super.key,
    required this.question,
    required this.selectedItems,
  });
  final Preguntas question;
  final Function(List<String>?) selectedItems;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<SelectionMultiple>
    with AutomaticKeepAliveClientMixin {
  List<String>? selectedItems = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    //top: size.height * 0.01

    return Column(
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
                return CheckboxListTile(
                  value: selectedItems
                      ?.contains(widget.question.opciones?[index].opcion),
                  onChanged: (newvalue) => onSelectedTile(newvalue, index),
                  title: Text(widget.question.opciones?[index].opcion ?? '',
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  activeColor: c.primary,
                  checkboxShape: const CircleBorder(),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
        ),
      ],
    );
  }

  void onSelectedTile(bool? newvalue, int index) {
    setState(() {
      if (newvalue == true) {
        selectedItems?.add(widget.question.opciones?[index].opcion ?? '');
      } else {
        selectedItems?.remove(widget.question.opciones?[index].opcion ?? '');
      }
      widget.selectedItems(selectedItems);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
