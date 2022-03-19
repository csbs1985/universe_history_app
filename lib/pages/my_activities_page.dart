import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/shared/models/user_model.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({Key? key}) : super(key: key);

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  String _getResume() {
    var qtyHistory = currentUser.value.first.qtyHistory <= 0
        ? 'Nenhuma história'
        : '${currentUser.value.first.qtyHistory} histórias';
    var qtyComment = currentUser.value.first.qtyComment <= 0
        ? 'Nenhum comentário'
        : '${currentUser.value.first.qtyComment} comentários';

    return qtyHistory + ' · ' + qtyComment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Suas atividades'),
              ResumeComponent(resume: _getResume()),
            ],
          ),
        ),
      ),
    );
  }
}
