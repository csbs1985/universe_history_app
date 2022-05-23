import 'package:flutter/material.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class ResumeHistoryComponent extends StatelessWidget {
  const ResumeHistoryComponent({
    required resume,
    double? top,
    double? bottom,
    double? width,
  })  : _resume = resume,
        _top = top,
        _bottom = bottom,
        _width = width;

  final _resume;
  final double? _bottom;
  final double? _top;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      padding: EdgeInsets.fromLTRB(0, _top ?? 0, 0, _bottom ?? 10),
      child: Row(
        children: [
          if (_resume['isAuthorized'])
            const IconCicleComponent(
              icon: uiSvg.authorized,
              size: 16,
              margin: 2,
            ),
          if (_resume['isAuthorized'])
            const Text(
              ' · ',
              style: uiTextStyle.text2,
            ),
          Text(
            resumeUitl(_resume),
            style: uiTextStyle.text2,
          ),
        ],
      ),
    );
  }
}
