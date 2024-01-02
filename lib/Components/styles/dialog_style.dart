import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:food_app/Components/skin/color_skin.dart';
class FDialogStatus {
  const FDialogStatus({
    required this.primaryColor,
    required this.secondaryColor,
    required this.assetPath,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final String assetPath;

  static const error = FDialogStatus(
    primaryColor: FColorSkin.primaryColor,
    secondaryColor: FColorSkin.secondaryText,
    assetPath: 'assets/Fail.svg',
  );

  static const success = FDialogStatus(
    primaryColor: FColorSkin.secondaryColor2,
    secondaryColor: FColorSkin.secondaryText,
    assetPath: 'assets/Success.svg',
  );

  static const infor = FDialogStatus(
    primaryColor: FColorSkin.secondaryColor3,
    secondaryColor: FColorSkin.secondaryText,
    assetPath: 'assets/Success.svg',
  );
}
