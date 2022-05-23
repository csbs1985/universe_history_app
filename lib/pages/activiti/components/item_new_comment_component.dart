import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemNewComment extends StatefulWidget {
  const ItemNewComment({required ActivitiesModel history}) : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemNewComment> createState() => _ItemNewCommentState();
}

class _ItemNewCommentState extends State<ItemNewComment> {
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
                icon: uiSvg.comment,
                color: uiColor.new_comment,
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  },
                  text:
                      'Você deixou um comentário na história <bold>${widget._history.content}</bold>. Pode ver a repercussão dele clicando aqui.',
                ),
              ),
            )
          ],
        ),
        onTap: () => _setHistory(widget._history));
  }
}
