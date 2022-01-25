// ignore_for_file: camel_case_types, prefer_is_empty, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/shared/models/blocked_model.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class blockedUsersPage extends StatefulWidget {
  const blockedUsersPage({Key? key}) : super(key: key);

  @override
  _blockedUsersPageState createState() => _blockedUsersPageState();
}

class _blockedUsersPageState extends State<blockedUsersPage> {
  final List<BlockedModel> allBlocked = BlockedModel.allBlocked;
  late String numBlocked;

  @override
  void initState() {
    numBlocked = allBlocked.length > 0
        ? '${allBlocked.length.toString()} pessoas bloqueadas'
        : 'Pessoas bloqueadas';
    super.initState();
  }

  void _unlockUser(String blocked) {
    setState(() {
      showToast(
        '${blocked} desbloqueado(a).',
        context: context,
        position: StyledToastPosition.bottom,
        textStyle: uiTextStyle.text1,
        backgroundColor: uiColor.comp_3,
        animation: StyledToastAnimation.slideToBottomFade,
        reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleComponent(numBlocked),
                const Text(
                  'Quando você bloqueia uma pessoa, este usuário não poderá mais ler suas histórias e comentários e comentar o que você escreve.',
                  style: uiTextStyle.text2,
                ),
                const SizedBox(
                  height: 10,
                ),
                for (var item in allBlocked)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.user, style: uiTextStyle.text1),
                            Text(item.date, style: uiTextStyle.text2),
                          ],
                        ),
                        TextButton(
                          child: const Text('Desbloquear',
                              style: uiTextStyle.text4),
                          style: uiButton.button1,
                          onPressed: () => _unlockUser(item.blocked),
                        ),
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
