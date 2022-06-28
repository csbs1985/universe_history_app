import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/models/common_questions_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CommonQuestionsPage extends StatelessWidget {
  CommonQuestionsPage({Key? key}) : super(key: key);

  final List<CommonQuestionsModel> allQuestions =
      CommonQuestionsModel.allQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Perguntas frequentes'),
              for (var item in allQuestions)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.question,
                      style: UiTextStyle.text1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.answer,
                      style: UiTextStyle.text7,
                    ),
                    const SizedBox(height: 20),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
