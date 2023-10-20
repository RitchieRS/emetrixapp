import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

Future<bool> showMsj({
  required BuildContext context,
  required String title,
  required String content,
  required bool destructive,
  required String buttonLabel,
  bool onlyOk = false,
  bool justifyContent = false,
}) async {
  final bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(title,
              style: t.subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          content: Text(content,
              style: t.text2,
              textAlign: justifyContent ? TextAlign.justify : TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: onlyOk == true
              ? [
                  ButonDimentions(
                    onTap: () => Navigator.pop(context, true),
                    background: destructive ? c.error : c.primary,
                    title: buttonLabel,
                    style: t.textLight,
                    width: Dimentions().getWidth() * 0.4,
                    height: Dimentions().getHeight() * 0.055,
                  ),
                ]
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style:
                              TextButton.styleFrom(foregroundColor: c.disabled),
                          child: Text('Cancelar', style: t.textDisabledBold)),
                      const SizedBox(width: 12),
                      ButonDimentions(
                        background: destructive ? c.error : c.primary,
                        title: buttonLabel,
                        style: t.textLight,
                        onTap: () => Navigator.pop(context, true),
                        width: Dimentions().getWidth() * 0.3,
                        height: Dimentions().getHeight() * 0.052,
                      ),
                    ],
                  )
                ],
        );
      });
  return Future.value(result);
}
