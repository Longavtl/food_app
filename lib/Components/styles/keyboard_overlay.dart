import 'package:flutter/cupertino.dart';

import 'input_done_view.dart';

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;
  static bool hasKeyboard = false;
  static bool _fromOtherField = false;

  static Future<void> showOverlay(BuildContext context) async {
    if (_overlayEntry != null) {
      _fromOtherField = true;
      return;
    }

    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        hasKeyboard = bottom > 0;

        return ExtendedNumericKeyboard();
      },
    );

    overlayState.insert(_overlayEntry!);
  }

  static void removeOverlay() {
    if (_overlayEntry != null) {
      if (_fromOtherField && hasKeyboard) {
        _fromOtherField = false;
        return;
      } else {
        _overlayEntry?.remove();
        _overlayEntry = null;
        hasKeyboard = false;
      }
    }
  }
}
