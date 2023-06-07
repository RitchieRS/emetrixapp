// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emetrix_flutter/app/ui/global/ui.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'controller.dart';
import 'widgets/back_image.dart';
import 'widgets/my_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final user = TextEditingController();
  final password = TextEditingController();
  final userKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool switchButton = false;

  @override
  void dispose() {
    user.dispose();
    userKey.currentState?.dispose();
    password.dispose();
    passKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: c.surface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: c.surface,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            //Imagen
            const BackImage(),

            //Form
            FadeInUp(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.3),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Inicia Sesión', style: t.title)),
                    ),
                    //
                    Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.07),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Usuario', style: t.text2))),
                    TxtField(
                      hinText: 'Ingresa usuario',
                      controller: user,
                      isPassword: false,
                      formKey: userKey,
                    ),

                    Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.07),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Contraseña', style: t.text2))),
                    TxtField(
                      hinText: 'Ingresa contraseña',
                      controller: password,
                      isPassword: true,
                      formKey: passKey,
                    ),

                    switchButton == false
                        ? Padding(
                            padding: EdgeInsets.only(top: size.height * 0.05),
                            child: ButonDimentions(
                                background: c.primary,
                                title: 'Entrar',
                                style: t.mediumLight,
                                onTap: () => start(),
                                width: size.width * 0.9,
                                height: size.height * 0.06))
                        : Padding(
                            padding: EdgeInsets.only(top: size.height * 0.05),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )

                    //
                  ],
                ),
              ),
            ),

            //
          ],
        ),
      ),
    );
  }

  Future start() async {
    final networkResult = await (Connectivity().checkConnectivity());
    setState(() => switchButton = !switchButton);

    if (!validateForm(userKey.currentState) &&
        !validateForm(passKey.currentState)) {
      setState(() {});
      return;
    }

    if (!validateForm(userKey.currentState) ||
        !validateForm(passKey.currentState)) {
      setState(() {});
      return;
    }

    if (networkResult == ConnectivityResult.none) {
      showYesNoMsj(
          context: context,
          title: 'Sin Conexión',
          content:
              'Conéctate a internet para poder iniciar sesión correctamente.',
          yesOnly: true);
      setState(() => switchButton = false);
      return;
    }

    await requestAccess();
    //
  }

  bool validateForm(FormState? form) {
    if (form != null) {
      if (form.validate()) {
        //Form is valid
        setState(() {});
        return true;
      } else {
        //Form is invalid
        setState(() {});
        setState(() => switchButton = false);
        return false;
      }
    }
    return false;
  }

  Future requestAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.containsKey('isDarkMode');
    final navigator = Navigator.of(context);

    bool userLoggedIn = await ref
        .read(loginControllerProvider.notifier)
        .sendRequest(user.text, password.text);
    setState(() {});

    if (userLoggedIn == true && isDark == false) {
      await getStores();
      navigator.pushReplacementNamed('onboard');
      user.clear();
      password.clear();
      setState(() => switchButton = false);
      await vibrate();
      return;
    }
    if (userLoggedIn == true && isDark == true) {
      await getStores();
      navigator.pushReplacementNamed('home');
      user.clear();
      password.clear();
      setState(() => switchButton = false);
      await vibrate();
      return;
    }
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      setState(() => switchButton = false);
      user.clear();
      password.clear();
      showYesNoMsj(
          context: context,
          title: 'Error',
          content: 'El usuario y la contraseña no existen. Intentalo de nuevo.',
          yesOnly: true);
    });
  }

  Future getStores() async {
    List<String> storesJson = [];
    final stores = await ref.read(loginControllerProvider.notifier).getStores();
    final storesAdditional =
        await ref.read(loginControllerProvider.notifier).getAditionalStores();

    stores.resp?.forEach((store) {
      storesJson.add(jsonEncode(store));
    });
    storesAdditional.resp?.forEach((store) {
      storesJson.add(jsonEncode(store));
    });

    ref.read(loginControllerProvider.notifier).saveStoresData(storesJson);
  }
}
