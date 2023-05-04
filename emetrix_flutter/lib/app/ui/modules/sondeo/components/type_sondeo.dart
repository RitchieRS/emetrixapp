import 'package:emetrix_flutter/app/core/modules/sondeo/sondeo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
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
    // final currentOption = ref.watch(currentOptionProvider);
    // final enabledColor = index <= currentOption - 1;

    return FadeIn(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: size.width,
          height: size.height * 0.15,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.08),
                  AnimatedContainer(
                    duration:
                        const Duration(milliseconds: animationDuration + 300),
                    curve: Curves.easeIn,
                    height: size.height * 0.08,
                    width: size.height * 0.08,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            enebled ? c.primary : c.disabled.withOpacity(0.4)),
                    child: icons(c.background),
                  ),
                  SizedBox(width: size.width * 0.08),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PASO ${index + 1}', style: t.textDisabled2),
                      SizedBox(
                        width: size.width * 0.6,
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
                  : Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.16, top: size.width * 0.01),
                      child: SizedBox(
                        height: size.height * 0.06,
                        child: RotatedBox(
                          quarterTurns: 5,
                          child: TweenAnimationBuilder<double>(
                            duration:
                                const Duration(milliseconds: animationDuration),
                            curve: Curves.easeInOut,
                            tween: Tween<double>(
                              begin: 0,
                              end: enebled ? 1 : 0, //
                            ),
                            builder: (context, value, _) =>
                                LinearProgressIndicator(
                              value: value,
                              minHeight: size.height * 0.007,
                              backgroundColor: c.disabled.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),

                      //
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
      'todo': Icon(Icons.task, color: color),
      'FOTOS': Icon(Icons.photo, color: color),
      'preguntas': Icon(Icons.question_answer, color: color),
      'SOS': Icon(Icons.sos, color: color),
      'cronometro 2': Icon(Icons.timer, color: color),
      'cronometro 4': Icon(Icons.timer, color: color),
      'Carga de Videos': Icon(Icons.upload, color: color),
      'NFC': Icon(Icons.nfc, color: color),
      'Asistencia': Icon(Icons.location_on, color: color),
      'Tomar Fotografía': Icon(Icons.camera, color: color),
      'Nueva Tienda': Icon(Icons.store, color: color),
      // 'Salida': Icon(Icons.exit_to_app, color: color),
    };

    return icons[sondeoItem.sondeo] ??
        Icon(Icons.question_answer, color: color);
  }
}
