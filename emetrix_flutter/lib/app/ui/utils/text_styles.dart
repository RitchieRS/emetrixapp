import 'package:flutter/material.dart';

import 'colors.dart';

final IText t = _TextStylesMain();

abstract class IText {
  TextStyle get titleBlue;
  TextStyle get mediumBlue;
  TextStyle get mediumLight;
  TextStyle get text;
  TextStyle get text2;
  TextStyle get textLight;
  TextStyle get textBlue;
  TextStyle get textError;
  TextStyle get textDisabled;
}

class _TextStylesMain implements IText {
  @override
  TextStyle titleBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: c.primary);

  @override
  TextStyle mediumBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: c.primary);

  @override
  TextStyle mediumLight = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: c.background);

  @override
  TextStyle text =
      const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.black);
  @override
  TextStyle text2 =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black);
  @override
  TextStyle textLight =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.white);
  @override
  TextStyle textBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c.primary);
  @override
  TextStyle textError =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.red);

  @override
  TextStyle textDisabled =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey);
}
