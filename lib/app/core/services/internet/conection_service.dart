import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:flutter/material.dart';

class MesagessService {
  static const int _duration = 3;

  static void showError(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: _duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showWarning(
      {required BuildContext context, required String message}) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.yellow,
      duration: const Duration(seconds: _duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showSuccess(
      {required BuildContext context,
      required String message,
      EdgeInsetsGeometry? marginBottom}) {
    final snackbar = SnackBar(
      behavior: marginBottom != null
          ? SnackBarBehavior.floating
          : SnackBarBehavior.fixed,
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: _duration),
      margin: marginBottom,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      required IconData icon,
      Duration duration = const Duration(seconds: 2)}) {
    final snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(icon),
          ),
          Text(message, style: t.text2),
        ],
      ),
      // backgroundColor: Theme.of(context).highlightColor,
      backgroundColor: c.primary.withOpacity(0.8),
      // backgroundColor: const Color(0xFF363636),

      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.8,
          right: 10,
          left: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar).close;
  }
}
