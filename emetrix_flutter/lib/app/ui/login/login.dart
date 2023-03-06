import 'package:emetrix_flutter/app/ui/utils/colors.dart';
import 'package:emetrix_flutter/app/ui/utils/text_styles.dart';
import 'package:emetrix_flutter/app/ui/utils/widgets/button_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/back_image.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final user = TextEditingController();
  final password = TextEditingController();

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
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: Container(
                    height: size.height * 0.5,
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        //

                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          child: Text('Inicia Sesión', style: t.titleBlue),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              bottom: size.height * 0.01),
                          child: TextField(
                              controller: user,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 12,
                                      bottom: 0, // HERE THE IMPORTANT PART
                                      top: size.height * 0.055 / 2),
                                  prefixIcon: const Icon(Icons.alternate_email),
                                  constraints: BoxConstraints(
                                      maxHeight: size.height * 0.055,
                                      maxWidth: size.width * 0.9),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.black54.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.black54.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Ingresa tu Nombre de usuario')),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              bottom: size.height * 0.01),
                          child: TextField(
                              controller: password,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 12,
                                      bottom: 0, // HERE THE IMPORTANT PART
                                      top: size.height * 0.055 / 2),
                                  prefixIcon: const Icon(Icons.lock),
                                  constraints: BoxConstraints(
                                      maxHeight: size.height * 0.055,
                                      maxWidth: size.width * 0.9),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.black54.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Colors.black54.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Ingresa tu contraseña')),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.02),
                          child: ButonDimentions(
                              background: c.primary,
                              title: 'Entrar',
                              style: t.mediumLight,
                              onTap: () {
                                //Service to access
                              },
                              width: size.width * 0.9,
                              height: size.height * 0.06),
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
