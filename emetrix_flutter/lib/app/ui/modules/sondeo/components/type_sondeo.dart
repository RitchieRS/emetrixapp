import 'package:animate_do/animate_do.dart';
import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/sondeo/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class TypeSondeo extends ConsumerWidget {
  const TypeSondeo({
    super.key,
    required this.index,
    required this.isLast,
    required this.sondeoItem,
    required this.onTap,
    required this.enebled,
  });
  final int index;
  final bool isLast;
  final RespM sondeoItem;
  final VoidCallback? onTap;
  final bool enebled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const int animationDuration = 1000;
    final currentOption = ref.watch(currentOptionProvider);
    final theme = ref.watch(themeProvider);
    const enebledColor = Color(0xff3C91E6);
    final disabledColor =
        theme == ThemeMode.light ? Colors.grey[400] : c.disabled;
    final finishedColor = c.ok.withOpacity(0.7);
    // final enabledColor = index <= currentOption - 1;
    final finishedSections = ref.watch(finishedSondeos);
    final isFinished = finishedSections.any((element) => element == index);

    return Padding(
      padding: isLast
          ? EdgeInsets.only(bottom: size.height * 0.05)
          : const EdgeInsets.all(0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: size.width,
          height: isLast ? size.height * 0.08 : size.height * 0.148,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.06),
                  AnimatedContainer(
                    duration:
                        const Duration(milliseconds: animationDuration + 300),
                    curve: Curves.bounceIn,
                    height: size.height * 0.08,
                    width: size.height * 0.08,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFinished
                            ? finishedColor
                            : enebled
                                ? enebledColor
                                : disabledColor),
                    child: icons(c.background),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sondeoItem.obligatorio != 0
                          ? Container(
                              color: c.surface,
                              width: size.width * 0.4,
                              child: Text('Requerido',
                                  style: enebled
                                      ? t.textError2
                                      : t.mediumDisabled),
                            )
                          : const SizedBox(),
                      Row(
                        children: [
                          Text('PASO ${index + 1}', style: t.textDisabled2),
                          SizedBox(width: size.width * 0.02),
                          isFinished
                              ? Text('Completado', style: t.textOk)
                              : const SizedBox(),
                          SizedBox(width: size.width * 0.01),
                          isFinished
                              ? FadeIn(child: Icon(Icons.done, color: c.ok))
                              : SizedBox(width: size.width * 0.06),
                        ],
                      ),
                      Container(
                        color: c.surface,
                        width: size.width * 0.4,
                        child: Text(sondeoItem.sondeo ?? 'Error',
                            style: enebled ? t.mediumBold : t.mediumDisabled,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),

              isLast
                  ? const SizedBox()
                  : Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: size.width * 0.14, top: 0),
                        child: SizedBox(
                          height: size.height * 0.06,
                          child: RotatedBox(
                            quarterTurns: 5,
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(
                                  milliseconds: animationDuration),
                              curve: Curves.easeInOut,
                              tween: Tween<double>(
                                begin: 0,
                                end: currentOption > 0 ? 1 : 0, //
                                // end: enebled ? 1 : 0, //
                              ),
                              builder: (context, value, _) =>
                                  LinearProgressIndicator(
                                value: value,
                                color: isFinished
                                    ? finishedColor
                                    : enebled
                                        ? enebledColor
                                        : disabledColor,
                                minHeight: size.height * 0.007,
                                backgroundColor: disabledColor,
                              ),
                            ),
                          ),
                        ),

                        //
                      ),
                    )

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget icons(Color color) {
    final Map<String, Icon> icons = {
      'Asistencia': Icon(Icons.location_on, color: color),
      'Tomar Fotografía': Icon(Icons.camera, color: color),
      'todo': Icon(Icons.task, color: color),
      'FOTOS': Icon(Icons.photo, color: color),
      'VIDEOS': Icon(Icons.video_collection, color: color),
      'preguntas': Icon(Icons.question_answer, color: color),
      'SOS': Icon(Icons.sos, color: color),
      'cronometro 2': Icon(Icons.timer, color: color),
      'cronometro 4': Icon(Icons.timer, color: color),
      'Carga de Videos': Icon(Icons.upload, color: color),
      'NFC': Icon(Icons.nfc, color: color),
      'Nueva Tienda': Icon(Icons.store, color: color),
      // 'Salida': Icon(Icons.exit_to_app, color: color),
    };

    return icons[sondeoItem.sondeo] ??
        Icon(Icons.question_answer, color: color);
  }
}
