// ignore_for_file: unnecessary_new, unnecessary_import, override_on_non_overriding_member, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AppbarComponent extends StatelessWidget with PreferredSizeWidget {
  AppbarComponent(
      {Function? callback, bool btnBack = false, bool btnPublish = false})
      : _btnBack = btnBack,
        _btnPublish = btnPublish,
        _callback = callback;

  final bool _btnBack;
  final bool _btnPublish;
  final String _btnPublishText = 'publicar';
  final Function? _callback;

  void _onPressed(BuildContext context) {
    if (_callback != null) {
      _callback!(true);
    }
    _back(context);
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _btnBack
          ? IconButton(
              icon: SvgPicture.asset(uiSvg.closed),
              onPressed: () => _back(context),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: _btnPublish
              ? TextButton(
                  child: Text(
                    _btnPublishText,
                    style: uiTextStyle.button2,
                  ),
                  onPressed: () {
                    _onPressed(context);
                  })
              : ButtonDisabledComponent(_btnPublishText),
        ),
      ],
    );
  }
}
