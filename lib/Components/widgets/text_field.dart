import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Components/styles/keyboard_overlay.dart';


import '../base_component.dart';

class FTextField extends StatefulWidget {
  FTextField({
    super.key,
    this.controller,
    this.label,
    this.requireText,
    this.isRequire = false,
    this.labelText,
    this.helperText,
    this.prefixIcon,
    this.clearIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.counterText,
    this.maxLength,
    this.maxLines = 1,
    this.size = FInputSize.size56,
    this.autoFocus = false,
    this.enabled = true,
    this.readoOnly = false,
    this.backgroundColor = FColors.grey1,
    this.enabledColor = FColors.grey1,
    this.disabledColor = FColors.grey1,
    this.errorColor = FColors.grey1,
    this.focusColor = FColors.grey1,
    this.successColor = FColors.grey1,
    this.helperTextColor = FColors.grey1,
    this.style = const TextStyle(),
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  }) ;

  final TextEditingController ?controller;
  final String ?helperText;
  final Widget ?label;
  final String ?requireText;
  final bool isRequire;
  final String ?labelText;
  final String ?counterText;
  final Widget ?prefixIcon;
  final Widget ?clearIcon;
  final Widget ?suffixIcon;
  final Color backgroundColor;
  final Color ?enabledColor;
  final Color disabledColor;
  final Color errorColor;
  final Color ?focusColor;
  final FocusNode ?focusNode;
  final Color successColor;
  final Color ?helperTextColor;
  final FInputSize size;
  final bool autoFocus;
  final bool enabled;
  final bool readoOnly;
  final bool obscureText;
  final int ?maxLength;
  final int ?maxLines;
  final TextInputType ?keyboardType;
  final VoidCallback ?onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String> ?onSubmitted;
  final TextStyle style;
  final TextAlign textAlign;
  final List<TextInputFormatter> ?inputFormatters;
  final TextCapitalization textCapitalization;
  @override
  _FTextFieldState createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  TextEditingController _controller = TextEditingController();
  bool _isFocus = false;
  bool _isShowClear = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isShowClear = widget.controller!.text.isNotEmpty;
    }
    _controller.addListener(clearIconHandle);
  }

  @override
  void dispose() {
    _controller.removeListener(clearIconHandle);
    super.dispose();
  }

  void clearIconHandle() {
    if (_controller.text.isEmpty && _isShowClear) {
      setState(() {
        _isShowClear = false;
      });
    } else if (_controller.text.isNotEmpty && !_isShowClear) {
      setState(() {
        _isShowClear = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasExtendKeyboard = Platform.isIOS &&
        (widget.keyboardType == TextInputType.phone ||
            widget.keyboardType == TextInputType.number ||
            widget.keyboardType ==
                TextInputType.numberWithOptions(decimal: true));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
          // alignment: Alignment.center,
          height: widget.size.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.all(widget.size.borderRadius),
            border: Border.all(
              width: 1,
              color: _isFocus ? widget.focusColor! : widget.enabledColor!,
            ),
          ),
          child: Focus(
            onFocusChange: (value) {
              setState(() {
                _isFocus = value;
              });

              if (hasExtendKeyboard) {
                if (_isFocus) {
                  KeyboardOverlay.showOverlay(context);
                } else {
                  KeyboardOverlay.removeOverlay();
                }
              }
            },
            child: Row(
              children: [
                _buildPrefixIcon(),
                Expanded(
                  child: TextField(
                    scrollPadding: EdgeInsets.all(20.0) +
                        (hasExtendKeyboard
                            ? EdgeInsets.fromLTRB(0, 0, 0, 40.0)
                            : EdgeInsets.zero),
                    // keyboardAppearance: Brightness.dark,
                    textCapitalization: widget.textCapitalization,
                    inputFormatters: widget.inputFormatters,
                    focusNode: widget.focusNode,
                    maxLength: widget.maxLength,
                    obscureText: widget.obscureText,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    onTap: widget.onTap,
                    maxLines: widget.maxLines ?? 1,
                    keyboardType: widget.keyboardType,
                    controller: _controller,
                    autofocus: widget.autoFocus,
                    enabled: widget.enabled,
                    readOnly: widget.readoOnly,
                    textAlignVertical: TextAlignVertical.center,
                    style: widget.style,
                    cursorColor: FColors.grey10,
                    // cursorHeight: 22,
                    cursorWidth: 1,
                    textAlign: widget.textAlign,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      label: widget.isRequire
                          ? RichText(
                              text: TextSpan(
                                text: widget.requireText,
                                style: FTypoSkin.bodyText2.copyWith(
                                  color: _isFocus
                                      ? FColorSkin.infoPrimary
                                      : FColorSkin.primaryText,
                                ),
                                children: const [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                        color: FColorSkin.primaryColor),
                                  ),
                                ],
                              ),
                            )
                          : widget.label,
                      counterText: widget.counterText,
                      hintText:
                          widget.size.height <= 48 ? widget.labelText : null,
                      hintStyle: FTypoSkin.bodyText1
                          .copyWith(color: FColorSkin.subtitle),
                      labelText:
                          widget.size.height > 48 ? widget.labelText : null,
                      // labelStyle: FTypoSkin.bodyText2
                      // .copyWith(color: FColorSkin.secondaryText),
                      // hintStyle: FTypoSkin.bodyText2
                      // .copyWith(color: FColorSkin.primaryText),
                      border: InputBorder.none,
                      contentPadding: widget.size.contentPadding,
                      isDense: true,
                    ),
                  ),
                ),
                _buildClear(),
                _buildSeparator(),
                _buildSuffix(),
              ],
            ),
          ),
        ),
        if (widget.helperText != null)
          Container(
            margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
            constraints: BoxConstraints(maxHeight: 32, minHeight: 16),
            child: Text(
              widget.helperText??'',
              overflow: TextOverflow.ellipsis,
              style: FTypoSkin.buttonText3.copyWith(
                color: widget.helperTextColor,
              ),
              maxLines: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildPrefixIcon() => widget.prefixIcon != null
      ? Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: widget.prefixIcon,
        )
      : Container(width: 16);

  Widget _buildClear() => widget.clearIcon != null
      ? Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: _isShowClear ? widget.clearIcon : null,
        )
      : Container(width: 0);

  Widget _buildSeparator() =>
      widget.clearIcon != null && widget.suffixIcon != null
          ? Container(
              height: 12,
              width: 1,
              color: FColors.grey4,
            )
          : Container(width: 0);

  Widget _buildSuffix() => widget.suffixIcon != null
      ? Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          child: widget.suffixIcon,
        )
      : Container(width: widget.clearIcon != null ? 0 : 8);
}
