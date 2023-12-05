import 'package:emetrix_flutter/app/ui/modules/sondeo/components/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SelectionMultiple extends ConsumerStatefulWidget {
  const SelectionMultiple({
    super.key,
    required this.question,
    this.mandatory = false,
    required this.selectedItems,
  });
  final Preguntas question;
  final bool mandatory;
  final Function(List<String>?) selectedItems;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<SelectionMultiple>
    with AutomaticKeepAliveClientMixin {
  // List<String>? selectedItems = [];
  var selectRadios;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    selectRadios =
        ref.watch(radiosMultipleProvider(int.parse(widget.question.id ?? '0')));
    //top: size.height * 0.01

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child:
                Text(widget.question.pregunta ?? 'NoData', style: t.subtitle),
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
                    value: selectRadios
                        ?.contains(widget.question.opciones?[index].opcion),
                    onChanged: (newvalue) => onSelectedTile(newvalue, index),
                    title: Text(widget.question.opciones?[index].opcion ?? '',
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    activeColor: c.primary500,
                    checkboxShape: const CircleBorder(),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
          ),
        ],
      ),
    );
  }

  void onSelectedTile(bool? newvalue, int index) {
    setState(() {
      if (newvalue == true) {
        selectRadios?.add(widget.question.opciones?[index].opcion ?? '');
      } else {
        selectRadios?.remove(widget.question.opciones?[index].opcion ?? '');
        if (selectRadios?.isEmpty == true) {
          setState(() {});
          widget.selectedItems(null);
          return;
        }
      }
      widget.selectedItems(selectRadios);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
