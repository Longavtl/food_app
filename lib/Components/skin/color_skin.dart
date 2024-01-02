import 'package:flutter/material.dart';

class FColorSkin {
  /// [Primary Color]
  static const Color primaryColor = Color(0xffFF5F52);
  static const Color primaryColorHover = Color(0xffFF7A6F);
  static const Color primaryColorPressed = Color(0xffDF351D);
  static const Color primaryColorActive = Color(0xffDF351D);
  static const Color primaryColorTagBackground = Color(0xffFDF3F0);
  static const Color primaryColorBorderColor = Color(0xffFFA39E);

  /// [Secondary Color 1]
  static const Color secondaryColor1 = Color(0xff0FD2D2);
  static const Color secondaryColor1Hover = Color(0xff5CDBD3);
  static const Color secondaryColor1Pressed = Color(0xff13C2C2);
  static const Color secondaryColor1Active = Color(0xff13C2C2);
  static const Color secondaryColor1TagBackground = Color(0xffE7F9F9);
  static const Color secondaryColor1BorderColor = Color(0xff87E8DE);

  /// [Secondary Color 2]
  static const Color secondaryColor2 = Color(0xff2EB553);
  static const Color secondaryColor2Hover = Color(0xff4DD077);
  static const Color secondaryColor2Pressed = Color(0xff039732);
  static const Color secondaryColor2Active = Color(0xff039732);
  static const Color secondaryColor2TagBackground = Color(0xffEBFAEF);
  static const Color secondaryColor2BorderColor = Color(0xffB3EBC5);

  /// [Secondary Color 3]
  static const Color secondaryColor3 = Color(0xff40A9FF);
  static const Color secondaryColor3Hover = Color(0xff6CBDFF);
  static const Color secondaryColor3Pressed = Color(0xff309CFF);
  static const Color secondaryColor3Active = Color(0xff309CFF);
  static const Color secondaryColor3TagBackground = Color(0xffE6F7FF);
  static const Color secondaryColor3BorderColor = Color(0xff91D5FF);

  /// [Secondary Color 4]
  static const Color secondaryColor4 = Color(0xff597EF7);
  static const Color secondaryColor4Hover = Color(0xff85A5FF);
  static const Color secondaryColor4Pressed = Color(0xff4565E9);
  static const Color secondaryColor4Active = Color(0xff4565E9);
  static const Color secondaryColor4TagBackground = Color(0xffF0F5FF);
  static const Color secondaryColor4BorderColor = Color(0xffADC6FF);

  /// [Background Colors Usage]
  static const Color grey1_background = Color(0xffFFFFFF);
  static const Color grey2_background = Color(0xffFAFAFA);
  static const Color grey3_background = Color(0xffF5F5F5);
  static const Color grey4_background = Color(0xffE8E8E8);
  static const Color grey6_background = Color(0xffBFBFBF);
  static const Color disableBackground = Color(0xffD9D9D9);
  static const Color grey9_background = Color(0xff262626);

  /// [Typography Colors Usage]
  static const Color onColorBackground = Color(0xffFFFFFF);
  static const Color disable = Color(0xffD9D9D9);
  static const Color subtitle = Color(0xffBFBFBF);
  static const Color secondaryText = Color(0xff8C8C8C);
  static const Color primaryText = Color(0xff595959);
  static const Color title = Color(0xff262626);

  /// [Alert Info Color]
  static const Color infoPrimary = Color(0xff40A9FF);
  static const Color infoPrimaryHover = Color(0xff6CBDFF);
  static const Color infoPrimaryPressed = Color(0xff309CFF);
  static const Color infoPrimaryActive = Color(0xff309CFF);
  static const Color infoPrimaryTagBackground = Color(0xffE6F7FF);
  static const Color infoPrimaryBorderColor = Color(0xff91D5FF);

  /// [Alert Success Color]
  static const Color successPrimary = Color(0xff2EB553);
  static const Color successPrimaryHover = Color(0xff4DD077);
  static const Color successPrimaryPressed = Color(0xff039732);
  static const Color successPrimaryActive = Color(0xff039732);
  static const Color successPrimaryTagBackground = Color(0xffEBFAEF);
  static const Color successPrimaryBorderColor = Color(0xffB3EBC5);

  /// [Alert Warning Color]
  static const Color warningPrimary = Color(0xffFA8C16);
  static const Color warningPrimaryHover = Color(0xffFFA940);
  static const Color warningPrimaryPressed = Color(0xffD46B08);
  static const Color warningPrimaryActive = Color(0xffD46B08);
  static const Color warningPrimaryTagBackground = Color(0xffFFF7E6);
  static const Color warningPrimaryBorderColor = Color(0xffFFD591);

  /// [Alert Error Color]
  static const Color errorPrimary = Color(0xffFF5F52);
  static const Color errorPrimaryHover = Color(0xffFF7A6F);
  static const Color errorPrimaryPressed = Color(0xffEC5641);
  static const Color errorPrimaryActive = Color(0xffEC5641);
  static const Color errorPrimaryTagBackground = Color(0xffFFF1F0);
  static const Color errorPrimaryBorderColor = Color(0xffFFA39E);

  /// [Colorful Tags Colors Usage]
  static const Color primaryTagBackgroundColor = Color(0xffFDF3F0);
  static const Color primaryTagBorderColor = Color(0xff91D5FF);
  static const Color primaryTagTypographyColor = Color(0xff1890FF);
//color rank
  static const Color gold2 = Color(0xffFFF1B8);

  /// [Colors Transparent]
  static const Color transparent = Colors.transparent;

  static Color getColor(String value) {
    switch (value) {

      /// [Primary Color]
      case 'primaryColor':
        return FColorSkin.primaryColor;
      case 'primaryColorHover':
        return FColorSkin.primaryColorHover;
      case 'primaryColorPressed':
        return FColorSkin.primaryColorPressed;
      case 'primaryColorActive':
        return FColorSkin.primaryColorActive;
      case 'primaryColorTagBackground':
        return FColorSkin.primaryColorTagBackground;
      case 'primaryColorBorderColor':
        return FColorSkin.primaryColorBorderColor;

      /// [Secondary Color 1]
      case 'secondaryColor1':
        return FColorSkin.secondaryColor1;
      case 'secondaryColor1Hover':
        return FColorSkin.secondaryColor1Hover;
      case 'secondaryColor1Pressed':
        return FColorSkin.secondaryColor1Pressed;
      case 'secondaryColor1Active':
        return FColorSkin.secondaryColor1Active;
      case 'secondaryColor1TagBackground':
        return FColorSkin.secondaryColor1TagBackground;
      case 'secondaryColor1BorderColor':
        return FColorSkin.secondaryColor1BorderColor;

      /// [Secondary Color 2]
      case 'secondaryColor2':
        return FColorSkin.secondaryColor2;
      case 'secondaryColor2Hover':
        return FColorSkin.secondaryColor2Hover;
      case 'secondaryColor2Pressed':
        return FColorSkin.secondaryColor2Pressed;
      case 'secondaryColor2Active':
        return FColorSkin.secondaryColor2Active;
      case 'secondaryColor2TagBackground':
        return FColorSkin.secondaryColor2TagBackground;
      case 'secondaryColor2BorderColor':
        return FColorSkin.secondaryColor2BorderColor;

      /// [Secondary Color 3]
      case 'secondaryColor3':
        return FColorSkin.secondaryColor3;
      case 'secondaryColor3Hover':
        return FColorSkin.secondaryColor3Hover;
      case 'secondaryColor3Pressed':
        return FColorSkin.secondaryColor3Pressed;
      case 'secondaryColor3Active':
        return FColorSkin.secondaryColor3Active;
      case 'secondaryColor3TagBackground':
        return FColorSkin.secondaryColor3TagBackground;
      case 'secondaryColor3BorderColor':
        return FColorSkin.secondaryColor3BorderColor;

      /// [Secondary Color 4]
      case 'secondaryColor4':
        return FColorSkin.secondaryColor4;
      case 'secondaryColor4Hover':
        return FColorSkin.secondaryColor4Hover;
      case 'secondaryColor4Pressed':
        return FColorSkin.secondaryColor4Pressed;
      case 'secondaryColor4Active':
        return FColorSkin.secondaryColor4Active;
      case 'secondaryColor4TagBackground':
        return FColorSkin.secondaryColor4TagBackground;
      case 'secondaryColor4BorderColor':
        return FColorSkin.secondaryColor4BorderColor;

      /// [Background Colors Usage]
      case 'grey1_background':
        return FColorSkin.grey1_background;
      case 'grey2_background':
        return FColorSkin.grey2_background;
      case 'grey3_background':
        return FColorSkin.grey3_background;
      case 'grey4_background':
        return FColorSkin.grey4_background;
      case 'grey6_background':
        return FColorSkin.grey6_background;
      case 'disableBackground':
        return FColorSkin.disableBackground;
      case 'grey9_background':
        return FColorSkin.grey9_background;

      /// [Typography Colors Usage]
      case 'onColorBackground':
        return FColorSkin.onColorBackground;
      case 'disable':
        return FColorSkin.disable;
      case 'subtitle':
        return FColorSkin.subtitle;
      case 'secondaryText':
        return FColorSkin.secondaryText;
      case 'primaryText':
        return FColorSkin.primaryText;
      case 'title':
        return FColorSkin.title;

      /// [Alert Info Color]
      case 'infoPrimary':
        return FColorSkin.infoPrimary;
      case 'infoPrimaryHover':
        return FColorSkin.infoPrimaryHover;
      case 'infoPrimaryPressed':
        return FColorSkin.infoPrimaryPressed;
      case 'infoPrimaryActive':
        return FColorSkin.infoPrimaryActive;
      case 'infoPrimaryTagBackground':
        return FColorSkin.infoPrimaryTagBackground;
      case 'infoPrimaryBorderColor':
        return FColorSkin.infoPrimaryBorderColor;

      /// [Alert Success Color]
      case 'successPrimary':
        return FColorSkin.successPrimary;
      case 'successPrimaryHover':
        return FColorSkin.successPrimaryHover;
      case 'successPrimaryPressed':
        return FColorSkin.successPrimaryPressed;
      case 'successPrimaryActive':
        return FColorSkin.successPrimaryActive;
      case 'successPrimaryTagBackground':
        return FColorSkin.successPrimaryTagBackground;
      case 'successPrimaryBorderColor':
        return FColorSkin.successPrimaryBorderColor;

      /// [Alert Warning Color]
      case 'warningPrimary':
        return FColorSkin.warningPrimary;
      case 'warningPrimaryHover':
        return FColorSkin.warningPrimaryHover;
      case 'warningPrimaryPressed':
        return FColorSkin.warningPrimaryPressed;
      case 'warningPrimaryActive':
        return FColorSkin.warningPrimaryActive;
      case 'warningPrimaryTagBackground':
        return FColorSkin.warningPrimaryTagBackground;
      case 'warningPrimaryBorderColor':
        return FColorSkin.warningPrimaryBorderColor;

      /// [Alert Error Color]
      case 'errorPrimary':
        return FColorSkin.errorPrimary;
      case 'errorPrimaryHover':
        return FColorSkin.errorPrimaryHover;
      case 'errorPrimaryPressed':
        return FColorSkin.errorPrimaryPressed;
      case 'errorPrimaryActive':
        return FColorSkin.errorPrimaryActive;
      case 'errorPrimaryTagBackground':
        return FColorSkin.errorPrimaryTagBackground;
      case 'errorPrimaryBorderColor':
        return FColorSkin.errorPrimaryBorderColor;

      /// [Colorful Tags Colors Usage]
      case 'primaryTagBackgroundColor':
        return FColorSkin.primaryTagBackgroundColor;
      case 'primaryTagBorderColor':
        return FColorSkin.primaryTagBorderColor;
      case 'primaryTagTypographyColor':
        return FColorSkin.primaryTagTypographyColor;

      /// [Colors Transparent]
      case 'transparent':
        return FColorSkin.transparent;
      default:
        return FColorSkin.grey9_background;
    }
    // return FColorSkin.grey9_background;
  }
}
