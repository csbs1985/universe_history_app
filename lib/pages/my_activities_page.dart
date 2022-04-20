// ignore_for_file: unused_element, empty_statements, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/item_login_component.dart';
import 'package:universe_history_app/components/item_logout_component.dart';
import 'package:universe_history_app/components/item_new_account_component.dart';
import 'package:universe_history_app/components/item_new_comment_component.dart';
import 'package:universe_history_app/components/item_new_history_component.dart';
import 'package:universe_history_app/components/item_new_nickName_component.dart';
import 'package:universe_history_app/components/item_notification_component.dart';
import 'package:universe_history_app/components/item_temporarily_desabled_component.dart';
import 'package:universe_history_app/components/item_up_block_component.dart';
import 'package:universe_history_app/components/item_up_nickName_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
          case ActivitiesEnum.LOGIN:
            return ItemLogin(history: documents[index]);
          case ActivitiesEnum.LOGOUT:
            return ItemLogout(history: documents[index]);
          case ActivitiesEnum.UP_NICKNAME:
            return ItemUpNickName(history: documents[index]);
          case ActivitiesEnum.NEW_COMMENT:
            return ItemNewComment(history: documents[index]);
          case ActivitiesEnum.NEW_NICKNAME:
            return ItemNewNickName(history: documents[index]);
          case ActivitiesEnum.UP_NOTIFICATION:
            return ItemNotificationComponent(history: documents[index]);
          case ActivitiesEnum.BLOCK_USER:
          case ActivitiesEnum.UNBLOCK_USER:
            return ItemUpBlockComponent(history: documents[index]);
          case ActivitiesEnum.TEMPORARILY_DISABLED:
            return ItemTemporarilyDesabledComponent(history: documents[index]);
          case ActivitiesEnum.NEW_ACCOUNT:
          default:
            return ItemNewAccountComponent(history: documents[index]);
        }
      },
    );
  }
}
