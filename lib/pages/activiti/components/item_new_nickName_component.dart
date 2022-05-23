import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemNewNickName extends StatefulWidget {
  const ItemNewNickName({required ActivitiesModel history})
      : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemNewNickName> createState() => _ItemNewNickNameState();
}

class _ItemNewNickNameState extends State<ItemNewNickName> {
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
                icon: uiSvg.new_nickname,
                color: uiColor.new_nickname,
              )),
          SizedBox(
            width:
                MediaQuery.of(context).size.width - uiSize.widthItemActiviries,
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
                    'Acabou de definir seu usuário <bold>${widget._history.content}</bold> no Histoty. Pode altera-ló sempre que necessitar clicando aqui ou no item <bold>Nome de usuário</bold> no menu de configurações.',
              ),
            ),
          )
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed("/nickname"),
    );
  }
}
