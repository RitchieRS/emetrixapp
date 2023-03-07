import 'package:emetrix_flutter/app/ui/home/home.dart';
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
              Padding(
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
                                left: size.width * 0.07),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Inicia Sesión'.toUpperCase(),
                                    style: t.mediumBlue))),
                        Padding(
                            padding: EdgeInsets.only(
                                top: size.height * 0.03,
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
                                    onTap: () {
                                      //Service to access
                                      debugPrint(
                                          'USER ${user.text}\nPASSWORD ${password.text}');
                                      setState(() {
                                        switchButton = !switchButton;
                                      });

                                      Future.delayed(const Duration(seconds: 1))
                                          .whenComplete(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));

                                        setState(() {
                                          switchButton = false;
                                        });
                                      });
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

              //
            ],
          ),
        ),
      ),
    );
  }
}
