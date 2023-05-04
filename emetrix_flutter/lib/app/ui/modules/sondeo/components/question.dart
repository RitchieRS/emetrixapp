import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Question extends ConsumerStatefulWidget {
  const Question({
    super.key,
    this.isNumeric,
    this.max,
    this.min,
    required this.getAnswer,
    required this.pregunta,
  });
  final bool? isNumeric;
  final int? min;
  final int? max;
  final String textfieldValue = '';
  final Preguntas pregunta;

  final Function(String) getAnswer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<Question>
    with AutomaticKeepAliveClientMixin {
  TextEditingController question = TextEditingController();

  @override
  void dispose() {
    question.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    Color color = c.primary;
    Color color2 = c.disabled.withOpacity(0.4);
    //String textfieldValue = '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.01),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.01),
            child: TextField(
              onChanged: (value) async {
                if (value.isEmpty) {
                  //Validation
                } else {
                  setState(() {
                    widget.getAnswer(value);
                  });
                }
              },
              controller: question,
              maxLength: widget.max,
              maxLines: 1,
              keyboardType: widget.isNumeric != true
                  ? TextInputType.emailAddress
                  : TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: 12, bottom: 0, top: size.height * 0.06 / 2),
                labelStyle: t.text,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.question_answer),
                ),
                focusColor: c.primary,
                constraints: BoxConstraints(
                    minHeight: widget.max != null
                        ? size.height * 0.08
                        : size.height * 0.07,
                    maxWidth: size.width * 0.9),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color2),
                    borderRadius: BorderRadius.circular(10)),
                hintText: 'Respuesta',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
