import 'package:emetrix_flutter/app/ui/login/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,

      //Theme of the app
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.blue,
              onPrimary: Colors.blue,
              secondary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.transparent,
              onBackground: Colors.transparent,
              surface: Colors.transparent,
              onSurface: Colors.transparent)),
    );
  }
}
