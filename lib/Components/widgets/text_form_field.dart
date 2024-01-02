import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base_component.dart';

class FTextFormField extends FFormField<String> {
  FTextFormField({
    Key ?key,
    this.controller,
    FFormFieldValidator<String>? validator,
    String ?helperText,
    Widget ?label,
    String ?requireText,
    bool isRequire = false,
    String ?labelText,
    Widget ?prefixIcon,
    int ?maxLines,
    Widget? clearIcon,
    Widget ?suffixIcon,
    Color backgroundColor = FColors.grey1,
    Color enabledColor = FColors.grey3,
    Color disabledColor = FColors.grey3,
    Color errorColor = FColors.red6,
    Color focusColor = FColors.blue6,
    Color successColor = FColors.green6,
    Color helperTextColor = FColors.grey9,
    FInputSize size = FInputSize.size56,
    bool autoFocus = false,
    bool enabled = true,
    bool readOnly = false,
    bool obscureText = false,
    String counterText = '',
    int ?maxLength,
    TextInputType? keyboardType,
    VoidCallback ?onTap,
    ValueChanged<String> ?onChanged,
    ValueChanged<String> ?onSubmitted,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    FFormFieldSetter<String> ?onSaved,
    TextStyle style = FTextStyle.regular14_22,
    TextAlign textAlign = TextAlign.start,
    List<TextInputFormatter> ?inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    FocusNode ?focusNode,
  }) : super(
          key: key,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          validator: validator,
          onSaved: onSaved,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          builder: (FFormFieldState<String> field) {
            final _FTextFormFieldState state = field as _FTextFormFieldState;
            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return FTextField(
              // key: key,
              textCapitalization: textCapitalization,
              controller: state._effectiveController,
              helperText: field.statusText ?? helperText,
              // helperTextColor: field.status == TFStatus.normal
              //     ? helperTextColor
              //     : field.status == TFStatus.success
              //         ? Colors.green
              //         : errorColor,
              helperTextColor: field.status!.color,
              labelText: labelText,
              label: label,
              requireText: requireText,
              isRequire: isRequire,
              prefixIcon: prefixIcon,
              clearIcon: clearIcon,
              suffixIcon: suffixIcon,
              backgroundColor: backgroundColor,
              size: size,
              maxLines: maxLines,
              autoFocus: autoFocus,
              enabled: enabled,
              readoOnly: readOnly,
              disabledColor: disabledColor,
              // enabledColor: field.status.color,
              enabledColor: field.status == TFStatus.normal
                  ? enabledColor
                  : field.status!.color,
              errorColor: errorColor,
              successColor: successColor,
              focusColor: field.status == TFStatus.normal
                  ? focusColor
                  : field.status!.color,
              keyboardType: keyboardType,
              onChanged: onChangedHandler,
              onSubmitted: onSubmitted,
              onTap: onTap,
              obscureText: obscureText,
              counterText: counterText,
              maxLength: maxLength,
              style: style,
              textAlign: textAlign,
              inputFormatters: inputFormatters,
              focusNode: focusNode,
            );
          },
        );

  final TextEditingController ?controller;

  @override
  FFormFieldState<String> createState() {
    return _FTextFormFieldState();
  }
}

class _FTextFormFieldState extends FFormFieldState<String> {
  TextEditingController ?_controller;

  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  @override
  FTextFormField get widget => super.widget as FTextFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(FTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String value) {
    super.didChange(value);

    if (_effectiveController?.text != value) _effectiveController?.text = value;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController?.text = widget.initialValue!;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != value)
      didChange(_effectiveController!.text);
  }
}

enum statusValidate { error, success }
