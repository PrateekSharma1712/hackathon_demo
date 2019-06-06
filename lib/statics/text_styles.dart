import 'package:flutter/material.dart';
import 'color_pallets.dart';

class CustomTextStyles {
  static TextStyle smallTextStyle = TextStyle(
    fontSize: 14,
    color: ColorPallets.textPrimaryColor,
  );
  static TextStyle normalTextStyle = TextStyle(
    fontSize: 16,
    color: ColorPallets.textPrimaryColor,
  );
  static TextStyle normalTextBoldStyle = TextStyle(
      fontSize: 16,
      color: ColorPallets.textPrimaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle normalSecondTextStyle = TextStyle(
    fontSize: 18,
    color: ColorPallets.textPrimaryColor,
  );

  static TextStyle largeTextStyle = TextStyle(
    fontSize: 32,
    color: ColorPallets.textPrimaryColor,
  );
  static TextStyle mediumTextStyle = TextStyle(
    fontSize: 20,
    color: ColorPallets.textPrimaryColor,
  );
  static TextStyle mediumBoldTextStyle = TextStyle(
      fontSize: 20,
      color: ColorPallets.textPrimaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle normalBoldTextStyle = TextStyle(
      fontSize: 16,
      color: ColorPallets.textPrimaryColor,
      fontWeight: FontWeight.bold);

  static TextStyle textStyleSecondary =
      TextStyle(fontSize: 16, color: ColorPallets.textSecondaryColor);
  static TextStyle primaryButtonTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle primaryButtonMediumTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle primaryButtonTextStyleDark = TextStyle(
      fontSize: 16,
      color: ColorPallets.textPrimaryColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0);
  static TextStyle secondaryButtonTextStyle = TextStyle(
      fontSize: 16,
      color: ColorPallets.textSecondaryColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0);

  static TextStyle hintTextStyle =
      TextStyle(fontSize: 16, color: ColorPallets.textSecondaryColor);
  static TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    color: ColorPallets.textPrimaryColor,
  );
  static TextStyle appBarTextStyle = TextStyle(
      fontSize: 20,
      color: ColorPallets.appBarTextPrimaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle appBarTextStyleGreen =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle noDataScreenMainTextStyle = TextStyle(
      fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold);
  static TextStyle noDataScreenSubMainTextStyle = TextStyle(
      fontSize: 16, color: Colors.black45, fontWeight: FontWeight.bold);

  static TextStyle cartProductName =
      TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500);

  static TextStyle currencyTextStyle = TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      textBaseline: TextBaseline.ideographic);
  static TextStyle mainProductNameTextStyle = TextStyle(
    fontSize: 16,
    color: ColorPallets.textPrimaryColor,
    wordSpacing: 2,
  );
}
