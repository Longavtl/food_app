import 'package:flutter/material.dart';

import 'bar_bottom_sheet.dart';

Future<dynamic> showFMBS({
  required BuildContext context,
  required WidgetBuilder builder,
  Color ?backgroundColor,
  double ?elevation,
  ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  ),
  Clip ?clipBehavior,
  Color ?barrierColor,
  bool isScrollControlled = true,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  double ?height,
  RouteSettings ?routeSettings,
}) {
  return showModalBottomSheet(
    elevation: 0,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: isScrollControlled,
    context: context,
    useRootNavigator: useRootNavigator,
    barrierColor: barrierColor,
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (context) => Container(
      height: (height ?? 500) + MediaQuery.of(context).viewInsets.bottom,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Builder(builder: builder)),
    ),
  );
}
