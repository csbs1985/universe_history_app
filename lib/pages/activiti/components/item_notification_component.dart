import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemNotificationComponent extends StatefulWidget {
  const ItemNotificationComponent({
    required Map<String, dynamic> history,
  }) : _history = history;

  final Map<String, dynamic> _history;

  @override
  State<ItemNotificationComponent> createState() =>
      _ItemNotificationComponentState();
}

class _ItemNotificationComponentState extends State<ItemNotificationComponent> {
  String _getText(String text) {
    return text == 'false' ? 'não receber' : 'rebecer';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: IconCicleComponent(
            icon: UiSvg.notification,
            color: UiColor.up_notification,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - UiSize.widthItemActivities,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: StyledText(
              style: UiTextStyle.text4,
              tags: {
                'bold': StyledTextTag(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              },
              text:
                  'Alteração de configurações para <bold>${_getText(widget._history['content'])}</bold> todas as notificações de comentários em suas histórias.',
            ),
          ),
        )
      ],
    );
  }
}
