import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class Question extends ConsumerStatefulWidget {
  const Question({
    super.key,
    this.max,
    this.min,
    required this.answer,
    required this.pregunta,
    required this.index,
    required this.type,
  });
  final int index;
  final int? min;
  final int? max;
  final String textfieldValue = '';
  final Preguntas pregunta;
  final String type;
  final Function(String?) answer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<Question> {
  // TextEditingController questionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  static final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: c.error, width: 2),
      borderRadius: BorderRadius.circular(10));
  static final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: c.primary, width: 2),
      borderRadius: BorderRadius.circular(10));

  @override
  void dispose() {
    // questionController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color color2 = Theme.of(context).hintColor.withOpacity(0.3);
    final defaultBorder = OutlineInputBorder(
        borderSide: BorderSide(color: color2, width: 2),
        borderRadius: BorderRadius.circular(10));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
        ),
        SizedBox(height: size.height * 0.02),
        Center(
          child: Form(
            key: formKey,
            child: TextFormField(
              // controller: questionController,
              validator: (value) => selectValidation(value),
              onChanged: (value) {
                debugPrint('New Value: $value');
                validateAndSave(value);
              },
              maxLines: 1,
              keyboardType:
                  widget.type == 'numerico' || widget.type == 'decimal'
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    left: 12, bottom: 0, top: size.height * 0.06 / 2),
                labelStyle: t.text,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.question_answer),
                ),
                prefixIconColor: Colors.grey,
                focusColor: c.primary,
                constraints: BoxConstraints(
                    minHeight: widget.max != null
                        ? size.height * 0.08
                        : size.height * 0.07,
                    maxWidth: size.width * 0.9),
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                focusedBorder: focusedBorder,
                enabledBorder: defaultBorder,
                hintText: 'Respuesta',
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validateAndSave(String value) {
    final form = formKey.currentState;
    final isValid = form!.validate();

    if (isValid && value.isNotEmpty) {
      widget.answer(value);
      return;
    }
    widget.answer(null);
    return;
  }

  String? selectValidation(String? value) {
    final validations = {
      'numerico': validateNumer(value),
      'decimal': validateNumerDecimal(value),
      'email': validateEmail(value),
      'abierta': validate(value),
    };

    return validations[widget.type];
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    widget.answer(value);
    return null;
  }

  String? validateNumer(String? value) {
    bool isNumber = double.tryParse(value ?? '') != null;

    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    if (!isNumber) {
      return 'Debe ser un número';
    }
    widget.answer(value);
    return null;
  }

  String? validateNumerDecimal(String? value) {
    bool isNumber = double.tryParse(value ?? '') != null;
    double valueNumber = 0;

    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    if (!isNumber) {
      return 'Debe ser un número';
    }
    valueNumber = double.parse(value);

    if (valueNumber < 5 || valueNumber > 10 || valueNumber % 1 == 0) {
      return 'Debe ser un DECIMAL entre 5 - 10';
    }
    widget.answer(value);
    return null;
  }

  String? validateEmail(String? email) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (email != null) {
      if (emailRegExp.hasMatch(email)) {
        widget.answer(email);
        return null;
      }
      return 'E-mail incorrecto';
    }

    return 'Completa el campo';
  }
}
