// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ItemNewHistory extends StatefulWidget {
  const ItemNewHistory({required QueryDocumentSnapshot<dynamic> history})
      : _history = history;

  final QueryDocumentSnapshot<dynamic> _history;

  @override
  State<ItemNewHistory> createState() => _ItemNewHistoryState();
}

class _ItemNewHistoryState extends State<ItemNewHistory> {
  void _setHistory(item) {
    currentHistory.value.first.id = item['elementId'];
    Navigator.of(context).pushNamed("/history");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: IconCicleComponent(
                  icon: uiSvg.write,
                  color: uiColor.new_history,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        },
                        text:
                            'Você criou uma história com o título <bold>${widget._history['content']}</bold>. Pode acessa-lá clicando aqui.',
                      ),
                      ResumeComponent(
                        resume: editDateUtil(
                            DateTime.parse(widget._history['date'])
                                .millisecondsSinceEpoch),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => _setHistory(widget._history));
  }
}
