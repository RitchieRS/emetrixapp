import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

showProgress({
  required BuildContext context,
  required String title,
}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(title,
              style: t.subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          content: const SizedBox(
              height: 70,
              width: 70,
              child: Center(child: CircularProgressIndicator())),
          actionsAlignment: MainAxisAlignment.center,
        );
      });
}
