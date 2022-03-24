// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ItemLogout extends StatefulWidget {
  const ItemLogout({required QueryDocumentSnapshot<dynamic> history})
      : _history = history;

  final QueryDocumentSnapshot<dynamic> _history;

  @override
  State<ItemLogout> createState() => _ItemLogoutState();
}

class _ItemLogoutState extends State<ItemLogout> {
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
            child: IconCicleComponent(
              icon: uiSvg.logout,
              color: uiColor.logout,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 32 - 20 - 20,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                        'Ainda bem que voltou, porque registramos sua saída pelo aparelho <bold>${widget._history['content']}</bold>.',
                  ),
                  ResumeComponent(
                    resume: editDateUtil(DateTime.parse(widget._history['date'])
                        .millisecondsSinceEpoch),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}