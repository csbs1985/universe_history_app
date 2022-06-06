import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent({
    required Map<String, dynamic> snapshot,
  }) : _snapshot = snapshot;

  final Map<String, dynamic> _snapshot;

  @override
  State<HistoryItemComponent> createState() => _HistoryItemComponentState();
}

class _HistoryItemComponentState extends State<HistoryItemComponent> {
  final Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget._snapshot['title'] != "")
                TitleComponent(
                  title: widget._snapshot['title'],
                  bottom: 0,
                ),
              ResumeHistoryComponent(resume: widget._snapshot),
              ExpandableText(
                widget._snapshot['text'],
                style: UiTextStyle.text1,
                expandText: 'continuar lendo',
                collapseText: 'fechar',
                maxLines: 10,
                linkColor: UiColor.first,
              ),
              Wrap(
                children: [
                  for (var item in widget._snapshot['categories'])
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        '#' + item,
                        style: UiTextStyle.text2,
                      ),
                    ),
                ],
              ),
              HistoryOptionsComponent(
                history: widget._snapshot,
                type: HistoryOptionsType.HOMEPAGE.name,
              )
            ],
          ),
        ),
      ],
    );
  }
}
