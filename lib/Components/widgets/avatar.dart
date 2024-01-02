import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Components/skin/color_skin.dart';
import 'package:food_app/Components/styles/icon_data.dart';
import 'package:shimmer/shimmer.dart';


import 'icon.dart';

Widget Favatar(String url, {double size = 24}) {
  return CachedNetworkImage(
    imageUrl: url ?? '',
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(color: FColorSkin.onColorBackground),
    ),
    errorWidget: (context, url, error) => Center(
      child: FIcon(
        icon: FFilled.image,
        size: size,
        color: FColorSkin.grey6_background,
      ),
    ),
  );
}

Widget animatedChangeWidget(
    {Widget ?showWidget, Widget ?seWid, bool ?isChange, int time = 300, Alignment alignment = Alignment.center}) {
  return AnimatedCrossFade(
    duration: Duration(milliseconds: time),
    alignment: alignment,
    firstChild: showWidget??Container(),
    secondChild: seWid ??
        Container(
          height: 0.0,
        ),
    crossFadeState: (showWidget != null && isChange!) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
