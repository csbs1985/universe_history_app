// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: IconCicleComponent(
                icon: uiSvg.new_nickname,
                color: uiColor.new_nickname,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32 - 20 - 20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledText(
                      style: uiTextStyle.text4,
                      tags: {
                        'bold': StyledTextTag(
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      },
                      text:
                          'Acabou de definir seu usuário <bold>${widget._history.content}</bold> no Histoty. Pode altera-ló sempre que necessitar clicando aqui ou no item <bold>Nome de usuário</bold> no menu de configurações.',
                    ),
                    ResumeComponent(
                      resume: editDateUtil(DateTime.parse(widget._history.date)
                          .millisecondsSinceEpoch),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed("/nickname"),
    );
  }
}
