import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emetrix_flutter/app/ui/login/controller.dart';
import 'package:emetrix_flutter/app/ui/main/main_screen.dart';
import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/button_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                                      onTap: () async {
                                        final networkResult =
                                            await (Connectivity()
                                                .checkConnectivity());
                                        setState(
                                            () => switchButton = !switchButton);

                                        if (user.text.isEmpty ||
                                            password.text.isEmpty) {
                                          showMsj('Casi...',
                                              'El usuario y la contraseña no pueden estar vacios. Ingresa un usuario  y contraseña.');
                                          setState(() => switchButton = false);
                                        } else if (networkResult ==
                                            ConnectivityResult.none) {
                                          showMsj('Sin Conexión',
                                              'Conéctate a internet para poder iniciar sesión correctamente.');
                                          setState(() => switchButton = false);
                                        } else {
                                          await requestAccess()
                                              .then((value) => getStores());
                                        }
                                      },
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

  Future requestAccess() async {
    bool userLoggedIn = await ref
        .read(loginControllerProvider.notifier)
        .init(user.text, password.text);
    setState(() {});

    if (userLoggedIn) {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
        user.clear();
        password.clear();
        setState(() => switchButton = false);
      });
    } else {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        setState(() => switchButton = false);
        user.clear();
        password.clear();
        showMsj('Error',
            'El usuario y la contraseña no existen. Intentalo de nuevo');
      });
    }
  }

  Future getStores() async {
    List<String> storesJson = [];
    final stores = await ref.read(loginControllerProvider.notifier).getStores();
    stores.resp?.forEach((store) {
      storesJson.add(jsonEncode(store));
    });
    ref.read(loginControllerProvider.notifier).saveStoresData(storesJson);
  }

  showMsj(String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(title, style: t.mediumBlue),
          content: Text(content, style: t.text2, textAlign: TextAlign.justify),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido')),
          ],
        );
      },
    );
  }
}
