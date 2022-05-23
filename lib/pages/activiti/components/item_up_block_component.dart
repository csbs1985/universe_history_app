import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';

class ItemUpBlockComponent extends StatefulWidget {
  const ItemUpBlockComponent({required ActivitiesModel history})
      : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemUpBlockComponent> createState() => _ItemUpBlockComponentState();
}

class _ItemUpBlockComponentState extends State<ItemUpBlockComponent> {
  String _getText(String type) {
    return type == ActivitiesEnum.BLOCK_USER.toString().split('.').last
        ? 'Agora você pode ver e comentar tudo de <bold>${widget._history.content}</bold> e virse-versa.'
        : 'Usuário <bold>${widget._history.content}</bold> bloqueado. Vocês não poderam mais ver e comentar as histórias entre vocês.';
  }

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
                    icon: UiSvg.block, color: UiColor.block_user)),
            SizedBox(
              width: MediaQuery.of(context).size.width -
                  UiSize.widthItemActiviries,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: StyledText(
                  style: UiTextStyle.text4,
                  tags: {
                    'bold': StyledTextTag(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  },
                  text: _getText(widget._history.type),
                ),
              ),
            )
          ],
        ),
        onTap: () => Navigator.of(context).pushNamed("/blocked"));
  }
}
