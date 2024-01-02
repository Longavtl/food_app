import 'package:flutter/material.dart';

class FText extends StatelessWidget {
  FText(this.data, {Key? key, this.style}) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: style?.fontSize != null && style?.height != null
          ? style!.fontSize! * style!.height!
          : null,
      child: Text(
        data,
        style: style?.copyWith(height: style?.height),
      ),
    );
  }
}