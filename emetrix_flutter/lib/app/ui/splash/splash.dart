import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/ui/login/login.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkRoute();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.1, 0.5],
          colors: [c.secondary, c.primary.withOpacity(0.55)],
        )),
        child: BounceInDown(
            child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.27, right: size.width * 0.27),
          child: Image.asset('assets/images/logo_blancoE.png'),
        )),
      ),
    );
  }

  _checkRoute() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final String? session = prefs.getString('loginInfo');
      final bool? theme = prefs.getBool('isDarkMode');
      if (kDebugMode) {
        print(session);
      }

      Future.delayed(const Duration(milliseconds: 900)).whenComplete(() async {
        if (session != null && theme == null) {
          //Pantalla de seleccion de tema
          await Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, animation, __) => FadeTransition(
                        opacity: animation,
                        child: const MainPage(),
                      )));
        } else if (session != null) {
          //Home
          await Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, animation, __) => FadeTransition(
                        opacity: animation,
                        child: const MainPage(),
                      )));
        } else {
          //LogIn
          await Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, animation, __) => FadeTransition(
                        opacity: animation,
                        child: const LoginPage(),
                      )));
        }
        //
      });
    });
  }
}
