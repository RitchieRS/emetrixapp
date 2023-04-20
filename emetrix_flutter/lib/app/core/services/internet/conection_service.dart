import 'package:flutter/material.dart';

class ConetionService {
  static void showError(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showWarning(
      {required BuildContext context, required String message}) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.yellow,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showSuccess(
      {required BuildContext context, required String message}) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showMessage(
      {required BuildContext context,
      required String message,
      required IconData icon}) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(icon),
          ),
          Text(message),
        ],
      ),
      backgroundColor: const Color(0xff3B3D3F),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.8,
          right: 20,
          left: 20),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar).close;
  }
}
