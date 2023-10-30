import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Selection extends ConsumerStatefulWidget {
  const Selection({
    super.key,
    this.yesNo,
    this.oneSelection,
    this.mandatory = false,
    required this.question,
    required this.pregunta,
    required this.answer,
  });
  final bool? yesNo;
  final bool? oneSelection;
  final Preguntas question;
  final Preguntas pregunta;
  final Function(String?) answer;
  final bool mandatory;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<Selection>
    with AutomaticKeepAliveClientMixin {
  final List<String> _yesnoOptions = ['Si', 'No'];
  late String multi = widget.question.opciones?[0].opcion ?? '';
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child:
                Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
          ),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              // physics: const BouncingScrollPhysics(),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _yesnoOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.yesNo == true
                    ? RadioListTile(
                        title: Text(_yesnoOptions[index]),
                        value: index,
                        activeColor: c.primary500,
                        groupValue: selectedOption,
                        onChanged: (value) => yesNoOnChanged(value))
                    : widget.oneSelection != true &&
                            widget.question.opciones != null
                        ? RadioListTile(
                            title: Text(
                                widget.question.opciones![index].opcion ??
                                    'option'),
                            value: index,
                            activeColor: c.primary500,
                            groupValue: selectedOption,
                            onChanged: (value) => onChanged(value))
                        : const SizedBox();
              },
            ),
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }

  void yesNoOnChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedOption = value;
      });
      widget.answer(_yesnoOptions[selectedOption ?? 0]);
      return;
    }
    widget.answer(null);
    return;
  }

  void onChanged(int? value) {
    if (value != null) {
      setState(() => selectedOption = value);
      widget.answer(widget.question.opciones![selectedOption ?? 0].opcion);
      return;
    }
    widget.answer(null);
    return;
  }

  @override
  bool get wantKeepAlive => true;

  //
}
