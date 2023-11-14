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
    const int animationDuration = 1400;
    final currentOption = ref.watch(currentOptionProvider);
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final enebledColor = c.primary500;
    final disabledColor =
        isDark ? Colors.grey[400] : c.disabled.withOpacity(0.3);
    final finishedColor = c.ok;
    final finishedSections = ref.watch(finishedSondeos);
    final isFinished = finishedSections.any((element) => element == index);
    final side = size.height * 0.07;
    final leftPadding = size.width * 0.06;
    final lineTickness = size.height * 0.007;
    final containerHeight = isLast ? size.height * 0.08 : size.height * 0.137;

    return Padding(
      padding: isLast
          ? EdgeInsets.only(
              bottom: size.height * 0.05, left: size.height * 0.01)
          : EdgeInsets.only(left: size.height * 0.01),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: size.width,
          height: containerHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: leftPadding),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: animationDuration),
                    curve: Curves.bounceIn,
                    height: side,
                    width: side,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFinished
                            ? finishedColor.withOpacity(0.35)
                            : enebled
                                ? enebledColor.withOpacity(0.35)
                                : disabledColor?.withOpacity(0.3)),
                    child: icons(isFinished
                        ? finishedColor
                        : enebled
                            ? enebledColor
                            : c.background),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sondeoItem.obligatorio == 1
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
                          isFinished
                              ? Text('Completado', style: t.textOk)
                              : const SizedBox(),
                          SizedBox(width: size.width * 0.01),
                          isFinished
                              ? FadeIn(
                                  child:
                                      Icon(Icons.done, color: c.ok, size: 15))
                              : SizedBox(width: size.width * 0.06),
                        ],
                      ),
                      Container(
                        color: c.surface,
                        width: size.width * 0.4,
                        child: Text(sondeoItem.sondeo ?? 'Error',
                            style: enebled
                                ? (isDark ? t.mediumLight : t.mediumBold)
                                : t.mediumDisabled,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),

              // isLast
              //     ? const SizedBox()
              if (!isLast)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: leftPadding + (side / 2 - lineTickness / 2),
                        top: 0),
                    child: TweenAnimationBuilder<double>(
                        duration:
                            const Duration(milliseconds: animationDuration),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: currentOption > 0 ? 1 : 0, //
                          // end: enebled ? 1 : 0, //
                        ),
                        builder: (context, value, _) => Container(
                              color: isFinished
                                  ? finishedColor.withOpacity(0.4)
                                  : enebled
                                      ? enebledColor.withOpacity(0.4)
                                      : disabledColor,
                              width: lineTickness,
                            )),

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
    return sondeoItem.sondeo == 'Asistencia'
        ? Icon(Icons.location_on, color: color)
        : Icon(Icons.task, color: color);
  }
}
