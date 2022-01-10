// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CommentEmpty extends StatelessWidget {
  const CommentEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          SvgPicture.asset(uiSvg.commentEmpty),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Nenhum comentário ainda',
            style: uiTextStyle.text1,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Suas palavras podem ajudar e confortar alguém.',
            style: uiTextStyle.text2,
          ),
        ],
      ),
    );
  }
}
