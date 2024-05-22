import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/global/core.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/theme/theme.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/components/area.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AreasMultiples extends ConsumerStatefulWidget {
  const AreasMultiples({
    super.key,
    this.mandatory = false,
    required this.pregunta,
    required this.listPreguntas,
    required this.callback,
    required this.photo,
    required this.selectedAreas,
    required this.orderPreguntaDependiente,
    this.multiple,
  });

  final bool mandatory;
  final Preguntas pregunta;
  final List<Preguntas> listPreguntas;
  final Function(String?, String?) callback;
  final Function(File?) photo;
  final Function(List<Coordinate>?) selectedAreas;
  final bool? multiple;
  final Function(int) orderPreguntaDependiente;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AreasMultiplesState();
}

class _AreasMultiplesState extends ConsumerState<AreasMultiples>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final backColor =
        isDark ? Theme.of(context).hintColor : Theme.of(context).highlightColor;

    List<Preguntas> depen =
        containsQuestion(widget.listPreguntas, widget.pregunta.id);

    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: c.primary300),
              color: c.primary200.withOpacity(0.2),
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => AreaFullPage(
                      pregunta: widget.pregunta,
                      mandatory: widget.mandatory,
                      depen: depen,
                      callback: widget.callback,
                      photo: (photo) {
                        widget.photo(photo);
                      },
                      selectedAreas: (areas) {
                        widget.selectedAreas(areas);
                      },
                      orderPreguntaDependiente: (order) {
                        widget.orderPreguntaDependiente(order);
                      },
                    ),
                  ),
                );
              },
              visualDensity: const VisualDensity(vertical: -3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: Icon(Icons.dashboard_outlined, color: c.primary500),
              trailing: const Text('Medir'),
              title: Text(widget.pregunta.pregunta.toString(),
                  style: t.mediumBold),
            ),
          ),
        ),
      ),
    );
  }

  List<Preguntas> containsQuestion(List<Preguntas> q1, idPregunta) {
    List<Preguntas> preguntasDep = [];
    for (var i = 0; i < q1.length; i++) {
      if (q1[i].dependePregunta == idPregunta) {
        preguntasDep.add(q1[i]);
      }
    }
    return preguntasDep;
  }

  @override
  bool get wantKeepAlive => true;
}
