import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemTemporarilyDesabledComponent extends StatefulWidget {
  const ItemTemporarilyDesabledComponent();

  @override
  State<ItemTemporarilyDesabledComponent> createState() =>
      _ItemTemporarilyDesabledComponentState();
}

class _ItemTemporarilyDesabledComponentState
    extends State<ItemTemporarilyDesabledComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4),
          child: IconCicleComponent(
            icon: UiSvg.temporarily_disabled,
            color: UiColor.temporarily_disabled,
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
                  'Se você esta lendo este bilhete é porque voltou, sabia que não ia aguentar por muito tempo. Bem vindo de volta! 😍',
            ),
          ),
        )
      ],
    );
  }
}
