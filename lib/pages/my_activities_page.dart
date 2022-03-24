// ignore_for_file: unused_element, empty_statements, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/icon_circle_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/item_new_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({Key? key}) : super(key: key);

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  final Api api = Api();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TitleResumeComponent('Suas atividades', _getResume()),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: api.getAllActivities(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _noResult();
                  case ConnectionState.waiting:
                    return const SkeletonActivityComponent();
                  case ConnectionState.done:
                  default:
                    try {
                      return _list(
                        context,
                        snapshot,
                      );
                    } catch (error) {
                      return _noResult();
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResult() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Nada para mostrar',
            style: uiTextStyle.header1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Você não tem atividades ainda.',
            style: uiTextStyle.text7,
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      itemCount: documents.length,
      itemBuilder: (BuildContext context, index) {
        ActivitiesEnum content = ActivitiesEnum.values
            .firstWhere((e) => e.name.toString() == documents[index]['type']);

        switch (content) {
          case ActivitiesEnum.NEW_HISTORY:
            return ItemNewHistory(history: documents[index]);
          case ActivitiesEnum.BLOCK_USER:
          case ActivitiesEnum.DELETE_ACCOUNT:
          case ActivitiesEnum.LOGIN:
          case ActivitiesEnum.LOGOUT:
          case ActivitiesEnum.NEW_ACCOUNT:
          case ActivitiesEnum.NEW_COMMENT:
          case ActivitiesEnum.NEW_NICKNAME:
          case ActivitiesEnum.TEMPORARILY_DISABLED:
          case ActivitiesEnum.UP_NICKNAME:
          case ActivitiesEnum.UP_NOTIFICATION:
          case ActivitiesEnum.UNBLOCK_USER:
          default:
            return Text(
              documents[index]['content'],
              style: uiTextStyle.text1,
            );
            break;
        }
      },
    );
  }
}
