import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:flutter/material.dart';

Future showYesNoMsj(
    {required BuildContext context,
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
          content: Center(child: Text(content, style: t.text2)),
          actions: [
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
