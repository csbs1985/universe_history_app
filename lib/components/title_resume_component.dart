import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class TitleResumeComponent extends StatelessWidget {
  const TitleResumeComponent(this.title, this.resume);

  final String title;
  final String resume;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: uiTextStyle.header2,
        ),
        const SizedBox(height: 4),
        ResumeComponent(resume: resume),
      ],
    );
  }
}
