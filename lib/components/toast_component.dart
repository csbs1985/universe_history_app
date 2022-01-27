// ignore_for_file: unused_element, unused_local_variable, unused_label

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/shared/models/enums/type_toast_enum.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ToastComponent {
  void toast(BuildContext context, ToastEnum? type, String text) {
    Color _style = uiColor.first;

    switch (type) {
      case ToastEnum.SUCCESS:
        _style = uiColor.success;
        break;
      case ToastEnum.WARNING:
        _style = uiColor.warning;
        break;
      case ToastEnum.INFO:
      default:
        _style = uiColor.first;
        break;
    }

    showToast(
      text,
      context: context,
      position: StyledToastPosition.bottom,
      textStyle: uiTextStyle.text1,
      backgroundColor: _style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(0),
    );
  }
}
