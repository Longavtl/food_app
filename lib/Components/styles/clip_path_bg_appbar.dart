import 'package:flutter/material.dart';

class ClipAppBar extends CustomClipper<Path> {
  ClipAppBar({this.curvesPercent = 0.75});

  final double curvesPercent;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * curvesPercent);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * curvesPercent);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
