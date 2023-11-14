import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/core/services/services.dart';
import 'package:emetrix_flutter/app/ui/modules/login/login.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  // String? session;
  bool? session;
  bool? theme;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkData().whenComplete(() => _checkRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.1, 0.5],
          colors: [c.secondary, c.primary500.withOpacity(0.55)],
        )),
        child: BounceInDown(
            delay: const Duration(seconds: 1),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.27, right: size.width * 0.27),
              child: Image.asset(AppAssets.logo),
            )),
      ),
    );
  }

  Future<void> _checkData() async {
    final prefs = await SharedPreferences.getInstance();
    // session = prefs.getString('loginInfo');
    session = prefs.getBool('sesionStarted');
    setState(() {});
  }

  Future<void> _checkRoute() async {
    await Future.delayed(const Duration(milliseconds: 2000))
        .whenComplete(() async {
      if (session == true) {
        await Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, animation, __) => FadeTransition(
                      opacity: animation,
                      child: const MainPage(),
                    )));
      } else {
        await Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, animation, __) => FadeTransition(
                      opacity: animation,
                      child: const LoginPage(),
                    )));
      }
    });
  }
}
