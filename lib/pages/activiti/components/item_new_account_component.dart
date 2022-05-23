import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemNewAccountComponent extends StatefulWidget {
  const ItemNewAccountComponent();

  @override
  State<ItemNewAccountComponent> createState() =>
      _ItemNewAccountComponentState();
}

class _ItemNewAccountComponentState extends State<ItemNewAccountComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 4),
            child: IconCicleComponent(
                icon: uiSvg.new_account, color: uiColor.new_account)),
        SizedBox(
          width: MediaQuery.of(context).size.width - 32 - 20 - 20,
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
              text:
                  'Esperam que encontrei o que veio buscar. Suas histórias e comentários podem mudar a vida de alguém...',
            ),
          ),
        )
      ],
    );
  }
}
