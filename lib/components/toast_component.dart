import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ToastComponent {
  void toast(BuildContext context, String? type, String text) {
    Color _style = UiColor.first;
    if (type == ToastEnum.SUCCESS.name) {
      _style = UiColor.success;
    } else if (type == ToastEnum.WARNING.name) {
      _style = UiColor.warning;
    } else {
      _style = UiColor.first;
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
