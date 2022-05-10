// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ItemLogin extends StatefulWidget {
  const ItemLogin({required ActivitiesModel history}) : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemLogin> createState() => _ItemLoginState();
}

class _ItemLoginState extends State<ItemLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 4),
              child:
                  IconCicleComponent(icon: uiSvg.login, color: uiColor.login)),
          SizedBox(
            width: MediaQuery.of(context).size.width - 72,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText(
                      style: uiTextStyle.text4,
                      tags: {
                        'bold': StyledTextTag(
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      },
                      text:
                          'Alguém, espero que seja você, entrou na sua conta History pelo aparelho <bold>${widget._history.content}</bold>.'),
                  ResumeComponent(
                      resume: editDateUtil(DateTime.parse(widget._history.date)
                          .millisecondsSinceEpoch)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
