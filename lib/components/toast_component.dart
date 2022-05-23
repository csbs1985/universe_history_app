import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ToastComponent {
  void toast(BuildContext context, ToastEnum? type, String text) {
    Color _style = UiColor.first;

    switch (type) {
      case ToastEnum.SUCCESS:
        _style = UiColor.success;
        break;
      case ToastEnum.WARNING:
        _style = UiColor.warning;
        break;
      case ToastEnum.INFO:
      default:
        _style = UiColor.first;
        break;
    }

    showToast(
      text,
      context: context,
      position: StyledToastPosition.center,
      textStyle: UiTextStyle.toast,
      backgroundColor: _style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(UiBorder.rounded),
    );
  }
}

enum ToastEnum { SUCCESS, WARNING, INFO }
