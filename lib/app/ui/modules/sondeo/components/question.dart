import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';

class Question extends ConsumerStatefulWidget {
  const Question({
    super.key,
    this.charactersMin,
    this.charactersMax,
    this.valueMax,
    this.valueMin,
    this.mandatory = false,
    required this.answer,
    required this.pregunta,
    required this.index,
    required this.type,
  });
  final int index;
  final num? charactersMin;
  final num? charactersMax;
  final num? valueMin;
  final num? valueMax;
  final String textfieldValue = '';
  final Preguntas pregunta;
  final String type;
  final bool mandatory;
  final Function(String?) answer;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<Question>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  static final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: c.error, width: 1.5),
      borderRadius: BorderRadius.circular(10));
  static final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: c.primary500, width: 1.5),
      borderRadius: BorderRadius.circular(10));
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    Color color2 = Theme.of(context).hintColor.withOpacity(0.3);
    final defaultBorder = OutlineInputBorder(
        borderSide: BorderSide(color: color2, width: 1.5),
        borderRadius: BorderRadius.circular(10));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: widget.mandatory ? c.errorLight : c.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child:
                Text(widget.pregunta.pregunta ?? 'NoData', style: t.subtitle),
          ),
          SizedBox(height: size.height * 0.01),
          Center(
            child: Form(
              key: formKey,
              child: TextFormField(
                validator: (value) => selectValidation(value),
                onChanged: (value) async {
                  await Future.delayed(const Duration(milliseconds: 500))
                      .whenComplete(() => validateAndSave(value));
                  // validateAndSave(value);
                  // setState(() {
                  //   textValue = value;
                  // });
                },
                // onEditingComplete: () {
                //   validateAndSave(textValue);
                // },
                // onFieldSubmitted: (value) {
                //   validateAndSave(textValue);
                // },
                maxLines: 1,
                keyboardType:
                    widget.type == 'numerico' || widget.type == 'decimal'
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 12, bottom: 0, top: size.height * 0.06 / 2),
                  labelStyle: t.text,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                        widget.type == 'numerico' || widget.type == 'decimal'
                            ? Icons.numbers
                            : Icons.question_answer),
                  ),
                  prefixIconColor: Colors.grey,
                  focusColor: c.primary500,
                  constraints: BoxConstraints(
                      minHeight: widget.valueMax != null
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
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }

  void validateAndSave(String value) {
    final form = formKey.currentState;
    final isValid = form!.validate();
    setState(() {});

    if (isValid && value.isNotEmpty) {
      widget.answer(value);
      return;
    }
    widget.answer(null);
    return;
  }

  String? selectValidation(String? value) {
    if (widget.type == 'numerico') {
      return validateNumer(value);
    }
    if (widget.type == 'decimal') {
      return validateNumerDecimal(value);
    }
    if (widget.type == 'abierta') {
      return validateString(value);
    }
    if (widget.type == 'email') {
      return validateEmail(value);
    }
    return null;

    // final validations = {
    //   'numerico': validateNumer(value),
    //   'decimal': validateNumerDecimal(value),
    //   'abierta': validateString(value),
    //   // 'email': validateEmail(value),
    // };

    // return validations[widget.type];
  }

  String? validateString(String? value) {
    final min = widget.charactersMin ?? 1;
    final max = widget.charactersMax;

    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    if (value.length < min) {
      return '${value.length}: Completa $min caracteres como mínimo';
    }
    if (max != null && max > 0) {
      if (value.length > max) {
        return '${value.length}: Completa $max caracteres como máximo';
      }
    }
    widget.answer(value);
    return null;
  }

  String? validateNumer(String? value) {
    final min = widget.valueMin ?? 1;
    final max = widget.valueMax ?? 1;
    bool isNumber = double.tryParse(value ?? '') != null;
    double number = double.parse(value ?? '');

    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    if (!isNumber) {
      return 'Debe ser un número';
    }

    if (number < min) {
      return 'Ingresa un valor de $min como mínimo';
    }
    if (number > max) {
      return 'Ingresa un valor menor de $max';
    }

    widget.answer(value);
    return null;
  }

  String? validateNumerDecimal(String? value) {
    final min = widget.valueMin ?? 1;
    final max = widget.valueMax ?? 1;
    bool isNumber = double.tryParse(value ?? '') != null;
    double valueNumber = 0;

    if (value == null || value.isEmpty || value == '') {
      return 'Completa el campo';
    }
    if (!isNumber) {
      return 'Debe ser un número';
    }
    valueNumber = double.parse(value);

    if (valueNumber < min || valueNumber > max || valueNumber % 1 == 0) {
      return 'Debe ser un DECIMAL entre $min - $max';
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

  @override
  bool get wantKeepAlive => true;
}
