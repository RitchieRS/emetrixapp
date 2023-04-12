import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

Future showYesNoMsj(
    {required BuildContext context,
    required bool yesOnly,
    required String title,
    required String content}) async {
  // var result =
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(title, style: t.subtitle, textAlign: TextAlign.center),
          content: Text(content, style: t.text2, textAlign: TextAlign.center),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            if (yesOnly = false)
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: c.disabled),
                  child: Text('Cancelar', style: t.textDisabledBold)),
            OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                    foregroundColor: c.primary,
                    side: BorderSide(color: c.primary)),
                child: Text('Aceptar', style: t.textBlue))
          ],
        );
      });
}
