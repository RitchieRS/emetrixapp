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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                  OutlinedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: OutlinedButton.styleFrom(
                          foregroundColor: destructive ? c.error : c.primary,
                          side: BorderSide(
                              color: destructive ? c.error : c.primary)),
                      child: Text(buttonLabel,
                          style: destructive ? t.textError : t.textBlue))
                ]
              : [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: TextButton.styleFrom(foregroundColor: c.disabled),
                      child: Text('Cancelar', style: t.textDisabledBold)),
                  OutlinedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: OutlinedButton.styleFrom(
                          foregroundColor: destructive ? c.error : c.primary,
                          side: BorderSide(
                              color: destructive ? c.error : c.primary)),
                      child: Text(buttonLabel,
                          style: destructive ? t.textError : t.textBlue))
                ],
        );
      });
  return Future.value(result);
}
