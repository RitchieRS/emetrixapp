// ignore_for_file: avoid_print

import 'package:emetrix_flutter/app/core/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/question.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/select_multiple.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/select_photo.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/selection.dart';
import 'package:emetrix_flutter/app/ui/sondeo/components/signature.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'date_time.dart';

class QuestionBuilder extends ConsumerStatefulWidget {
  const QuestionBuilder({super.key, required this.pregunta});
  final Preguntas pregunta;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuestionBuilderState();
}

class _QuestionBuilderState extends ConsumerState<QuestionBuilder> {
  // List<String> lenght = [];

  @override
  Widget build(BuildContext context) {
    switch (widget.pregunta.pregunta) {
      case 'Pregunta demo abierta':
        return Question(
          getAnswer: (String answer) {
            //Get the value of the textfield and save it to validate and send to endpoint;
          },
        );
      case 'Pregunta demo numérica':
        return Question(
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true);

      case 'Pregunta demo decimal (con limite minimo 5 y maximo 10)':
        return Question(
            getAnswer: (String answer) {
              //Get the value of the textfield and save it to validate and send to endpoint;
            },
            isNumeric: true,
            min: 5,
            max: 10);

      case 'Pregunta demo si o no':
        return Selection(question: widget.pregunta, yesNo: true);

      case 'Pregunta demo de opción multiple con 1 selección':
        return Selection(question: widget.pregunta);

      case 'Pregunta demo de opción multiple con N selecciones':
        return SelectionMultiple(question: widget.pregunta);

      case '--Pregunta informativa--':
        return Container();

      case 'Pregunta demo fotográfica':
        return const SelectPicture();

      case 'Pregunta demo GPS':
        return Container(
          color: c.surface,
          child: Text('Pregunta demo GPS', style: t.medium),
        );

      case 'Pregunta demo de 3 tiempos con el cronómetro.':
        return Container(
          color: c.surface,
          child: Text('3 tiempos con el cronómetro.', style: t.medium),
        );

      case 'Pregunta demo imágen':
        return const SelectPicture();

      case 'Pregunta demo de firma':
        return const Signature();

      case 'Pregunta demo fecha':
        return const PickerDT(onlyDate: true);

      case 'Pregunta demo fecha y hora':
        return const PickerDT();

      case 'Pregunta demo hora':
        return const PickerDT(onlyTime: true);

      case 'ESCANEA EL CÓDIGO':
        return Container(
          color: c.surface,
          child: Text('ESCANEA EL CÓDIGO', style: t.medium),
        );

      default:
        Container(
            width: 150,
            color: c.surface,
            child: Text('TextField default switch', style: t.medium));
    }

    return Question(
      getAnswer: (String answer) {
        //Get the value of the textfield and save it to validate and send to endpoint;
      },
    );
  }
}
