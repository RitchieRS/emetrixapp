import 'package:flutter/material.dart';
import 'package:emetrix_flutter/app/ui/utils/utils.dart';

final IText t = _TextStylesMain();

abstract class IText {
  TextStyle get title;
  TextStyle get titleWhite;
  TextStyle get titleBlack;
  TextStyle get titleBlue;
  TextStyle get titleLight;
  TextStyle get subtitle;
  TextStyle get subtitle2;
  TextStyle get subtitleLight;
  TextStyle get subtitleDark;
  TextStyle get medium;
  TextStyle get mediumBold;
  TextStyle get mediumBlue0;
  TextStyle get mediumBlue;
  TextStyle get mediumBlue2;
  TextStyle get mediumLight;
  TextStyle get mediumDark;
  TextStyle get mediumDisabled;
  TextStyle get mediumOk;
  TextStyle get text;
  TextStyle get text2;
  TextStyle get textOk;
  TextStyle get textUnselected;
  TextStyle get textLight;
  TextStyle get textBlue;
  TextStyle get textError;
  TextStyle get textError2;
  TextStyle get textDisabled;
  TextStyle get textDisabled2;
  TextStyle get textDisabledBold;
}

class _TextStylesMain implements IText {
  @override
  TextStyle title = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    // color: c.black
  );
  @override
  TextStyle titleWhite = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    height: 0.95,
    fontWeight: FontWeight.bold,
    color: c.background,
  );
  @override
  TextStyle titleBlack = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    height: 0.95,
    fontWeight: FontWeight.bold,
    color: c.black,
  );

  @override
  TextStyle titleBlue = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: c.primary);

  @override
  TextStyle titleLight = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    // color: c.background
  );

  @override
  TextStyle subtitle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    // color: c.background
  );

  @override
  TextStyle subtitle2 = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    // color: c.background
  );

  @override
  TextStyle subtitleLight = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      height: 0.95,
      color: c.background);

  @override
  TextStyle subtitleDark = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      height: 0.95,
      color: c.black);

  @override
  TextStyle medium = const TextStyle(
    fontFamily: 'Poppins', fontSize: 14,
    // color: Colors.black
  );

  @override
  TextStyle mediumBold = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    // color: Colors.black
  );

  @override
  TextStyle mediumDisabled = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c.disabled.withOpacity(0.4));

  @override
  TextStyle mediumOk = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c.ok);

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
  TextStyle mediumDark = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: c.disabled);

  @override
  TextStyle text = const TextStyle(
    fontFamily: 'Poppins', fontSize: 12,
    // color: Colors.black
  );

  @override
  TextStyle textUnselected = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      color: c.background.withOpacity(0.4));

  @override
  TextStyle text2 = const TextStyle(
    fontFamily: 'Poppins', fontSize: 14,
    // color: Colors.black
  );

  @override
  TextStyle textOk = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: c.ok,
    fontWeight: FontWeight.bold,
  );

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
  TextStyle textError2 = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      color: Colors.red[800],
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
