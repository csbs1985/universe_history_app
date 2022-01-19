import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/shared/models/common_questions_model.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CommonQuestionsPage extends StatelessWidget {
  CommonQuestionsPage({Key? key}) : super(key: key);

  final List<CommonQuestionsModel> allQuestions =
      CommonQuestionsModel.allQuestions;

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
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Perguntas frequentes',
                style: uiTextStyle.header1,
              ),
              const SizedBox(
                height: 20,
              ),
              for (var item in allQuestions)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.question,
                      style: uiTextStyle.text1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.answer,
                      style: uiTextStyle.text7,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
