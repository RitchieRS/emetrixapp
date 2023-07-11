import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Selection extends ConsumerStatefulWidget {
  const Selection({
    super.key,
    this.yesNo,
    this.oneSelection,
    this.yn = const ['Si', 'No'],
    required this.question,
    required this.pregunta,
    required this.answer,
  });
  final bool? yesNo;
  final bool? oneSelection;
  final Preguntas question;
  final List<String> yn;
  final Preguntas pregunta;
  final Function(String) answer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectionState();
}

class _SelectionState extends ConsumerState<Selection> {
  late String typeService = widget.yn[0];
  late String multi = widget.question.opciones?[0].opcion ?? '';
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.01),
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: Center(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.yn.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.yesNo == true
                  ? RadioListTile(
                      title: Text(widget.yn[index]),
                      activeColor: c.primary,
                      value: index,
                      groupValue: selectedOption,
                      onChanged: (value) => yesNoOnChanged(value))
                  : widget.oneSelection != true &&
                          widget.question.opciones != null
                      ? RadioListTile(
                          title: Text(widget.question.opciones![index].opcion ??
                              'option'),
                          value: index,
                          activeColor: c.primary,
                          groupValue: selectedOption,
                          onChanged: (value) => onChanged(value))
                      : const SizedBox();
            },
          )),
        ),
      ],
    );
  }

  void yesNoOnChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedOption = value;
        widget.answer(widget.yn[selectedOption ?? 0]);
      });
    }
  }

  void onChanged(int? value) {
    if (value != null) {
      setState(() {
        selectedOption = value;
        widget.answer(
            widget.question.opciones![selectedOption ?? 0].opcion ?? '');
      });
    }
  }
}
