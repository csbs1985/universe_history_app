import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemUpHistory extends StatefulWidget {
  const ItemUpHistory({required ActivitiesModel history}) : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemUpHistory> createState() => _ItemUpHistoryState();
}

class _ItemUpHistoryState extends State<ItemUpHistory> {
  final HistoryClass historyClass = HistoryClass();

  void _setHistory(_item) =>
      Navigator.pushNamed(context, '/history', arguments: _item.elementId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              width: MediaQuery.of(context).size.width -
                  uiSize.widthItemActiviries,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: StyledText(
                  style: uiTextStyle.text4,
                  tags: {
                    'bold': StyledTextTag(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  },
                  text: widget._history.content.isNotEmpty
                      ? 'Você atualizou a história com o título <bold>${widget._history.content}</bold>. Pode acessa-lá clicando aqui.'
                      : 'Você atualizou a história <bold>sem título</bold>. Pode acessa-lá clicando aqui.',
                ),
              ),
            )
          ],
        ),
        onTap: () => _setHistory(widget._history));
  }
}
