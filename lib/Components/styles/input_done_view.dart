import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Components/widgets/text_button.dart';


class ExtendedNumericKeyboard extends StatefulWidget {
  const ExtendedNumericKeyboard({Key? key}) : super(key: key);

  @override
  State<ExtendedNumericKeyboard> createState() =>
      _ExtendedNumericKeyboardState();
}

class _ExtendedNumericKeyboardState extends State<ExtendedNumericKeyboard> {
  bool _isOpen = false;
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.primaryColorDark == Brightness.dark;
    //final isDarkMode = theme.primaryColorBrightness == Brightness.dark;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: bottom),
      duration: Duration(milliseconds: 250),
      curve: Curves.decelerate,
      onEnd: () {
        setState(() {
          _isOpen = true;
        });
      },
      builder: (context, value, child) {
        return Positioned(
          height: 80,
          bottom: value - 44,
          left: 0.0,
          right: 0.0,
          child: Column(
            children: [
              child??Container(),
              AnimatedContainer(
                height: _isOpen ? 0 : 40,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: 40,
                  color: isDarkMode
                      ? CupertinoColors.systemGrey2.darkColor.withOpacity(0.98)
                      : CupertinoColors.systemGrey4.withOpacity(0.98),
                ),
              )
            ],
          ),
        );
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 100),
        child: Container(
          height: 40,
          width: double.infinity,
          alignment: Alignment.topRight,
          color: isDarkMode
              ? CupertinoColors.systemGrey2.darkColor.withOpacity(0.98)
              : CupertinoColors.systemGrey4.withOpacity(0.98),
          child: FTextButton(
            onPressed: () {
              setState(() {
                _opacity = 0;
              });
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Text(
              'Xong',
              style: TextStyle(
                color: isDarkMode
                    ? CupertinoColors.white
                    : CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
