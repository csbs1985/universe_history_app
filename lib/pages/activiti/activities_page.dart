import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/firestore/activities_firestore.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/pages/activiti/components/item_login_logout_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_account_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_comment_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_history_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_nickName_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_notification_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_temporarily_desabled_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_block_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_history_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_nickName_component.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final ActivitiesFirestore activitiesFirestore = ActivitiesFirestore();
  final UsersFirestore usersFirestore = UsersFirestore();

  String _qtyHistory = 'nenhuma história';
  String _qtyComment = 'nenhum comentário';

  _getResume() {
    usersFirestore
        .getUserEmail(currentUser.value.first.email)
        .then((result) => {
              if (result.docs.first['qtyHistory'] == 1)
                _qtyHistory = '1 história',
              if (result.docs.first['qtyHistory'] > 1)
                _qtyHistory = '${result.docs.first['qtyHistory']} histórias',
              if (result.docs.first['qtyComment'] == 1)
                _qtyComment = '1 comentário',
              if (result.docs.first['qtyComment'] > 1)
                _qtyComment = '${result.docs.first['qtyComment']} comentários',
            });

    return _qtyHistory + ' · ' + _qtyComment;
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
              child: TitleResumeComponent(
                'Suas atividades',
                _getResume(),
              ),
            ),
            FirestoreListView(
              query: activitiesFirestore.activities
                  .orderBy('date', descending: true)
                  .where('userId', isEqualTo: currentUser.value.first.id),
              pageSize: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const SkeletonActivityComponent(),
              errorBuilder: (context, error, stackTrace) => _noResults(),
              itemBuilder: (BuildContext context,
                  QueryDocumentSnapshot<dynamic> snapshot) {
                String content = snapshot.data()['type'];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (content == ActivitiesEnum.UP_HISTORY.name)
                        ItemUpHistory(history: snapshot.data()),
                      if (content == ActivitiesEnum.NEW_HISTORY.name)
                        ItemNewHistory(history: snapshot.data()),
                      if (content == ActivitiesEnum.LOGIN.name ||
                          content == ActivitiesEnum.LOGOUT.name)
                        ItemLoginLogout(history: snapshot.data()),
                      if (content == ActivitiesEnum.UP_NICKNAME.name)
                        ItemUpNickName(history: snapshot.data()),
                      if (content == ActivitiesEnum.NEW_COMMENT.name)
                        ItemNewComment(history: snapshot.data()),
                      if (content == ActivitiesEnum.NEW_NICKNAME.name)
                        ItemNewName(history: snapshot.data()),
                      if (content == ActivitiesEnum.UP_NOTIFICATION.name)
                        ItemNotificationComponent(history: snapshot.data()),
                      if (content == ActivitiesEnum.BLOCK_USER.name ||
                          content == ActivitiesEnum.UNBLOCK_USER.name)
                        ItemUpBlockComponent(history: snapshot.data()),
                      if (content == ActivitiesEnum.TEMPORARILY_DISABLED.name)
                        const ItemTemporarilyDesabledComponent(),
                      if (content == ActivitiesEnum.NEW_ACCOUNT.name)
                        const ItemNewAccountComponent(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 2, 0, 0),
                        child: ResumeComponent(
                          resume: editDateUtil(snapshot.data()['date']),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResults() {
    return const NoResultComponent(
        text: 'Não há atividades ou não foi possível encontrá-las.');
  }
}
