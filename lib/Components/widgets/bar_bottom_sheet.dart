// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// const Radius _default_bar_top_radius = Radius.circular(15);

// class BarBottomSheet extends StatelessWidget {
//   final Widget child;
//   final Widget control;
//   final Clip clipBehavior;
//   final double elevation;
//   final ShapeBorder shape;
//   final double height;

//   const BarBottomSheet(
//       {Key key, @required this.child, this.control, this.clipBehavior, this.shape, this.elevation, this.height})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final heightDevice = MediaQuery.of(context).size.height;
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light,
//       child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 12),
//             // SafeArea(
//             //   bottom: false,
//             //   child: control ??
//             //       Container(
//             //         height: 6,
//             //         width: 40,
//             //         decoration: BoxDecoration(
//             //           color: Colors.white,
//             //           borderRadius: BorderRadius.circular(6),
//             //         ),
//             //       ),
//             // ),
//             SizedBox(height: 8),
//             Container(
//               height: height > heightDevice - 80
//                   ? heightDevice - 80
//                   : height + MediaQuery.of(context).viewInsets.bottom > heightDevice
//                       ? height
//                       : height + MediaQuery.of(context).viewInsets.bottom,

//               // flex: 1,
//               // fit: FlexFit.loose,
//               child: Material(
//                 shape: shape ??
//                     RoundedRectangleBorder(
//                       side: BorderSide(),
//                       borderRadius:
//                           BorderRadius.only(topLeft: _default_bar_top_radius, topRight: _default_bar_top_radius),
//                     ),
//                 clipBehavior: clipBehavior ?? Clip.antiAlias,
//                 elevation: elevation ?? 2,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: MediaQuery.removePadding(
//                     context: context,
//                     removeTop: true,
//                     child: child,
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//     );
//   }
// }

// Future<T> showBarModalBottomSheet<T>({
//   @required BuildContext context,
//   @required WidgetBuilder builder,
//   Color backgroundColor,
//   double elevation,
//   ShapeBorder shape,
//   double closeProgressThreshold,
//   Clip clipBehavior,
//   Color barrierColor = Colors.black87,
//   bool bounce = true,
//   bool expand = false,
//   AnimationController secondAnimation,
//   Curve animationCurve,
//   bool useRootNavigator = false,
//   bool isDismissible = true,
//   bool enableDrag = true,
//   Widget topControl,
//   Duration duration,
//   double height,
//   bool isScrollControlled = false,
// }) async {
//   assert(context != null, '');
//   assert(builder != null, '');
//   assert(expand != null, '');
//   assert(useRootNavigator != null, '');
//   assert(isDismissible != null, '');
//   assert(enableDrag != null, '');
//   assert(debugCheckHasMediaQuery(context), '');
//   assert(debugCheckHasMaterialLocalizations(context), '');
//   final result = await Navigator.of(context, rootNavigator: useRootNavigator).push(ModalBottomSheetRoute<T>(
//     isScrollControlled: isScrollControlled,
//     builder: builder,
//     // bounce: bounce,
//     // closeProgressThreshold: closeProgressThreshold,
//     // containerBuilder: (_, __, child) => BarBottomSheet(
//     //   height: height ?? 500,
//     //   child: child,
//     //   control: topControl,
//     //   clipBehavior: clipBehavior,
//     //   shape: shape,
//     //   elevation: elevation,
//     // ),
//     // secondAnimationController: secondAnimation,
//     // expanded: expand,
//     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//     isDismissible: isDismissible,
//     modalBarrierColor: barrierColor,
//     enableDrag: enableDrag,
//     // animationCurve: animationCurve,
//     // duration: duration,
//   ));
//   return result;
// }
