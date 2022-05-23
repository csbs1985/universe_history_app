import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemLoginLogout extends StatefulWidget {
  const ItemLoginLogout({required ActivitiesModel history})
      : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemLoginLogout> createState() => _ItemLoginLogoutState();
}

class _ItemLoginLogoutState extends State<ItemLoginLogout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: IconCicleComponent(
            icon: widget._history.type == 'LOGIN' ? UiSvg.login : UiSvg.logout,
            color: widget._history.type == 'LOGIN'
                ? UiColor.login
                : UiColor.logout,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - UiSize.widthItemActiviries,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: StyledText(
              style: UiTextStyle.text4,
              tags: {
                'bold': StyledTextTag(
                    style: const TextStyle(fontWeight: FontWeight.bold))
              },
              text: widget._history.type == 'LOGIN'
                  ? 'Alguém, espero que seja você, entrou na sua conta History pelo aparelho <bold>${widget._history.content}</bold>.'
                  : 'Ainda bem que voltou, porque registramos sua saída pelo aparelho <bold>${widget._history.content}</bold>.',
            ),
          ),
        )
      ],
    );
  }
}
