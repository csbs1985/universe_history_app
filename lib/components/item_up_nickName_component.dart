// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ItemUpNickName extends StatefulWidget {
  const ItemUpNickName({required ActivitiesModel history}) : _history = history;

  final ActivitiesModel _history;

  @override
  State<ItemUpNickName> createState() => _ItemUpNickNameState();
}

class _ItemUpNickNameState extends State<ItemUpNickName> {
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
                    icon: uiSvg.up_nickname, color: uiColor.up_nickname)),
            SizedBox(
                width: MediaQuery.of(context).size.width -
                    uiSize.widthItemActiviries,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: StyledText(
                        style: uiTextStyle.text4,
                        tags: {
                          'bold': StyledTextTag(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        },
                        text:
                            'Alterou seu usuário de <bold>${widget._history.elementId}</bold> para <bold>${widget._history.content}</bold>. Espero que goste desta vez, pode ser que <bold>${widget._history.elementId}</bold> não esteja mais disponível. Clique e descubra.')))
          ]),
      onTap: () => Navigator.of(context).pushNamed("/nickname"),
    );
  }
}
