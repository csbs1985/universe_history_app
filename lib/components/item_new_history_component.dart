// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemNewHistory extends StatefulWidget {
  const ItemNewHistory({required ActivitiesModel history}) : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemNewHistory> createState() => _ItemNewHistoryState();
}

class _ItemNewHistoryState extends State<ItemNewHistory> {
  final HistoryClass historyClass = HistoryClass();

  void _setHistory(_item) =>
      Navigator.pushNamed(context, '/history', arguments: _item.elementId);

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
                          icon: uiSvg.write, color: uiColor.new_history)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width -
                          uiSize.widthItemActiviries,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: StyledText(
                              style: uiTextStyle.text4,
                              tags: {
                                'bold': StyledTextTag(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              },
                              text: widget._history.content.isNotEmpty
                                  ? 'Você criou uma história com o título <bold>${widget._history.content}</bold>. Pode acessa-lá clicando aqui.'
                                  : 'Você criou uma história <bold>sem título</bold>. Pode acessa-lá clicando aqui.')))
                ])),
        onTap: () => _setHistory(widget._history));
  }
}
