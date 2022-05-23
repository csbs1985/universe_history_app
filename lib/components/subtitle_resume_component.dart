import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SubtitleResumeComponent extends StatelessWidget {
  const SubtitleResumeComponent(
      {required String title, required String resume, double? width})
      : _title = title,
        _resume = resume,
        _width = width;

  final String _title;
  final String _resume;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: uiTextStyle.text1,
        ),
        ResumeComponent(
          resume: _resume,
          bottom: 0,
          width: _width,
        ),
      ],
    );
  }
}
