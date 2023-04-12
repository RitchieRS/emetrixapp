// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:emetrix_flutter/app/ui/utils/utils.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/widgets.dart';
import 'package:emetrix_flutter/app/ui/login/controller.dart';

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
  bool obscurePassword = true;
  bool switchButton = false;

  @override
  void initState() {
    super.initState();
    switchButton = false;
  }

  @override
  void dispose() {
    user.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //Imagen
              const BackImage(),

              //Form
              FadeInUp(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.5),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: Container(
                      height: size.height * 0.5,
                      width: size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          //
                          Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.04,
                                //left: size.width * 0.07
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Inicia Sesión'.toUpperCase(),
                                      style: t.mediumBlue))),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.07),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Usuario', style: t.text2))),
                          TxtField(
                              controller: user,
                              isPassword: false,
                              obscurePassword: false),

                          Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.07),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Contraseña', style: t.text2))),
                          TxtField(
                              controller: password,
                              isPassword: true,
                              obscurePassword: obscurePassword),

                          switchButton == false
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.05),
                                  child: ButonDimentions(
                                      background: c.primary,
                                      title: 'Entrar',
                                      style: t.mediumLight,
                                      onTap: () => start(),
                                      width: size.width * 0.9,
                                      height: size.height * 0.06))
                              : Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.05),
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                )

                          //
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }

  Future start() async {
    final networkResult = await (Connectivity().checkConnectivity());
    setState(() => switchButton = !switchButton);

    if (user.text.isEmpty || password.text.isEmpty) {
      showYesNoMsj(
          context: context,
          title: 'Casi...',
          content:
              'El usuario y la contraseña no pueden estar vacios. Ingresa un usuario  y contraseña.',
          yesOnly: true);
      setState(() => switchButton = false);
    } else if (networkResult == ConnectivityResult.none) {
      showYesNoMsj(
          context: context,
          title: 'Sin Conexión',
          content:
              'Conéctate a internet para poder iniciar sesión correctamente.',
          yesOnly: true);

      setState(() => switchButton = false);
    } else {
      await requestAccess().then((value) => getStores());
    }
  }

  Future requestAccess() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final navigator = Navigator.of(context);
      bool userLoggedIn = await ref
          .read(loginControllerProvider.notifier)
          .init(user.text, password.text);
      setState(() {});

      if (userLoggedIn) {
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          navigator.pushReplacementNamed('home');
          user.clear();
          password.clear();
          setState(() => switchButton = false);
        });
      } else {
        Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          setState(() => switchButton = false);
          user.clear();
          password.clear();
          showYesNoMsj(
              context: context,
              title: 'Error',
              content:
                  'El usuario y la contraseña no existen. Intentalo de nuevo.',
              yesOnly: true);
        });
      }
    });
  }

  Future getStores() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<String> storesJson = [];
      final stores =
          await ref.read(loginControllerProvider.notifier).getStores();
      final storesAdditional =
          await ref.read(loginControllerProvider.notifier).getAditionalStores();

      stores.resp?.forEach((store) {
        storesJson.add(jsonEncode(store));
      });
      storesAdditional.resp?.forEach((store) {
        storesJson.add(jsonEncode(store));
      });

      ref.read(loginControllerProvider.notifier).saveStoresData(storesJson);
    });
  }
}
