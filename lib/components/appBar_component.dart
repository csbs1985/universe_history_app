import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/button_publish_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class AppbarComponent extends StatefulWidget with PreferredSizeWidget {
  const AppbarComponent({
    Function? callback,
    bool btnBack = false,
    bool btnPublish = false,
  })  : _btnBack = btnBack,
        _btnPublish = btnPublish,
        _callback = callback;

  final bool _btnBack;
  final bool _btnPublish;
  final Function? _callback;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarComponentState createState() => _AppbarComponentState();
}

class _AppbarComponentState extends State<AppbarComponent> {
  void _onPressed(BuildContext context) {
    setState(() {
      if (widget._callback != null) widget._callback!(true);
    });
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: SvgPicture.asset(widget._btnBack ? UiSvg.closed : UiSvg.closed),
          onPressed: () => widget._btnBack ? _back(context) : null),
      actions: [
        if (widget._btnPublish)
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: ButtonPublishComponent(
                callback: (value) => _onPressed(context),
              ),
            ),
          ),
      ],
    );
  }
}
