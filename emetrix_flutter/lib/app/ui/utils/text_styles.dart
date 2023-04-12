import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

final IText t = _TextStylesMain();

abstract class IText {
  TextStyle get title;
  TextStyle get titleBlue;
  TextStyle get titleLight;
  TextStyle get subtitle;
  TextStyle get medium;
  TextStyle get mediumBold;
  TextStyle get mediumBlue0;
  TextStyle get mediumBlue;
  TextStyle get mediumBlue2;
  TextStyle get mediumLight;
  TextStyle get mediumDisabled;
  TextStyle get text;
  TextStyle get text2;
  TextStyle get textLight;
  TextStyle get textBlue;
  TextStyle get textError;
  TextStyle get textDisabled;
  TextStyle get textDisabled2;
  TextStyle get textDisabledBold;
}

class _TextStylesMain implements IText {
  @override
  TextStyle title = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: c.black);

  @override
  TextStyle titleBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: c.primary);

  @override
  TextStyle titleLight = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: c.background);

  @override
  TextStyle subtitle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: c.black);

  @override
  TextStyle medium =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black);

  @override
  TextStyle mediumBold = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  @override
  TextStyle mediumDisabled = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c.disabled.withOpacity(0.4));

  @override
  TextStyle mediumBlue0 = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c.secondary);

  @override
  TextStyle mediumBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: c.primary);

  @override
  TextStyle mediumBlue2 = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
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
  TextStyle textError = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.red,
      fontWeight: FontWeight.bold);

  @override
  TextStyle textDisabled =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey);

  @override
  TextStyle textDisabled2 =
      const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.grey);

  @override
  TextStyle textDisabledBold = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.bold);
}
