import 'package:flutter/material.dart';

final IColors c = _ColorsMain();

abstract class IColors {
  Color get primary;
  Color get secondary;
  Color get onSecondary;
  Color get onSecondaryDark;
  Color get background;
  Color get backgroundDark;
  Color get disabled;
  Color get error;
  Color get errorLight;
  Color get ok;
  Color get black;
  Color get surface;
  Color get tertiary;
  Color get onTertiary;

  Color get backgroundTres;
  Color get backgroundSeis;
  Color get textBlanco;
  Color get textUno;
  Color get textDos;
  Color get textCuatro;
  Color get textCinco;
  Color get textSeis;
  Color get textSiete;
  Color get textNueve;

  Color get primary100;
  Color get primary200;
  Color get primary300;
  Color get primary400;
  Color get primary500;
  Color get primary600;
  Color get primary700;
  Color get primary800;
  Color get primary900;
  Color get primary950;
}

class _ColorsMain extends IColors {
  @override
  Color primary = const Color(0xff0099ff);

  @override
  Color secondary = const Color(0xFF005C9D);

  @override
  Color onSecondary = const Color(0xffeaeaea);

  @override
  Color onSecondaryDark = const Color(0xff161925);

  @override
  Color tertiary = const Color(0xff5A81FA);

  @override
  Color onTertiary = const Color(0xff3C91E6);

  @override
  Color background = const Color(0xffffffff);

  @override
  Color backgroundDark = const Color(0xff454E73);

  @override
  Color disabled = const Color(0xff404040);

  @override
  Color error = const Color(0xffd42929);

  @override
  Color errorLight = const Color(0xffea4949);

  @override
  Color ok = const Color(0xff6bbf59);

  @override
  Color black = const Color(0xff404040);

  @override
  Color surface = Colors.transparent;

  //
  @override
  Color backgroundSeis = const Color(0xffc10000);

  @override
  Color backgroundTres = const Color(0xff29d429);

  @override
  Color textBlanco = const Color(0xffffffff);

  @override
  Color textCinco = const Color(0xff005998);

  @override
  Color textCuatro = const Color(0xffffffff);

  @override
  Color textDos = const Color(0xff44535f);

  @override
  Color textNueve = const Color(0xffffffff);

  @override
  Color textSeis = const Color(0xff0099ff);

  @override
  Color textSiete = const Color(0xff0070bf);

  @override
  Color textUno = const Color(0xffd42929);

// -------

  @override
  Color primary100 = const Color(0xffdeedfb); //#deedfb

  @override
  Color primary200 = const Color(0xffc4e2f9); //#c4e2f9

  @override
  Color primary300 = const Color(0xff9bd0f5); // #9bd0f5

  @override
  Color primary400 = const Color(0xff6cb6ee); // #6cb6ee

  @override
  Color primary500 = const Color(0xff3c91e6); // * #3c91e6

  @override
  Color primary600 = const Color(0xff347ddc); // #347ddc

  @override
  Color primary700 = const Color(0xff2b68ca); // #2b68ca

  @override
  Color primary800 = const Color(0xff2955a4); //#2955a4

  @override
  Color primary900 = const Color(0xff264982); //#264982

  @override
  Color primary950 = const Color(0xff1c2e4f); //#1c2e4f

  // @override
  // Color secondary = const Color(0xfffafafa);
}

// struct StructAdvisorColors {

//     var azul            = UIColor.init(red: 0, green: 119.0/255.0, blue: 197.0/255.0, alpha: 1)
//     var azulOscuro      = UIColor.init(red: 43.0/255.0, green: 54.0/255.0, blue: 90.0/255.0, alpha: 1)
//     var azulClaro       = UIColor.init(red: 204.0/255.0, green: 228.0/255.0, blue: 243.0/255.0, alpha: 1)
//     var azulBrilloso    = UIColor.init(red: 72.0/255.0, green: 181.0/255.0, blue: 227.0/255.0, alpha: 1)
//     var rojo            = UIColor.init(red: 222.0/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
//     var rojoOscuro      = UIColor.init(red: 149.0/255.0, green: 37.0/255.0, blue: 41.0/255.0, alpha: 1)
//     var rojoClaro       = UIColor.init(red: 240.0/255.0, green: 213.0/255.0, blue: 214.0/255.0, alpha: 1)
//     var amarillo        = UIColor.init(red: 215.0/255.0, green: 134.0/255.0, blue: 64.0/255.0, alpha: 1)
//     var amarilloClaro   = UIColor.init(red: 238.0/255.0, green: 210.0/255.0, blue: 163.0/255.0, alpha: 1)
//     var verde           = UIColor.init(red: 58.0/255.0, green: 153.0/255.0, blue: 75.0/255.0, alpha: 1)
//     var verdeOscuro     = UIColor.init(red: 20.0/255.0, green: 100.0/255.0, blue: 30.0/255.0, alpha: 1)
//     var verdeClaro      = UIColor.init(red: 212.0/255.0, green: 231.0/255.0, blue: 218.0/255.0, alpha: 1)
// }
