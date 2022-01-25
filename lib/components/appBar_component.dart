// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors, unused_element, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class AppbarComponent extends StatefulWidget with PreferredSizeWidget {
  const AppbarComponent(
      {Function? callback, bool btnBack = false, bool btnPublish = false})
      : _btnBack = btnBack,
        _btnPublish = btnPublish,
        _callback = callback;

  final bool _btnBack;
  final bool _btnPublish;
  final Function? _callback;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _AppbarComponentState createState() => _AppbarComponentState();
}

class _AppbarComponentState extends State<AppbarComponent> {
  void _onPressed(BuildContext context) {
    setState(() {
      if (widget._callback != null) {
        widget._callback!(true);
      }
      _back(context);
    });
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _setForm() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget._btnBack
          ? IconButton(
              icon: SvgPicture.asset(uiSvg.closed),
              onPressed: () => _back(context),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: BtnComponent(
            enabled: widget._btnPublish,
          ),
        ),
        // child: TextButton(
        //     child: Text(
        //       _btnPublishText,
        //       style: uiTextStyle.button2,
        //     ),
        //     onPressed: () {
        //       _onPressed(context);
        //     })),
      ],
    );
  }
}
