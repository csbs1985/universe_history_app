import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
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
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final RealtimeDatabaseService db = RealtimeDatabaseService();

  String _qtyHistory = 'nenhuma história';
  String _qtyComment = 'nenhum comentário';

  _getResume() {
    db.getUserEmail(currentUser.value.first.email).then((result) => {
          if (result.docs.first['qtyHistory'] == 1) _qtyHistory = '1 história',
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
            FirebaseDatabaseListView(
              query: db.activities
                  .orderByChild('userId')
                  .equalTo(currentUser.value.first.id),
              pageSize: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const SkeletonActivityComponent(),
              errorBuilder: (context, error, stackTrace) => _noResult(),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> _item =
                    ActivitiesModel.toMap(snapshot.value);

                ActivitiesEnum content = ActivitiesEnum.values
                    .firstWhere((e) => e.name.toString() == _item['type']);

                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (content == ActivitiesEnum.UP_HISTORY)
                        ItemUpHistory(history: _item),
                      if (content == ActivitiesEnum.NEW_HISTORY)
                        ItemNewHistory(history: _item),
                      if (content == ActivitiesEnum.LOGIN ||
                          content == ActivitiesEnum.LOGOUT)
                        ItemLoginLogout(history: _item),
                      if (content == ActivitiesEnum.UP_NICKNAME)
                        ItemUpNickName(history: _item),
                      if (content == ActivitiesEnum.NEW_COMMENT)
                        ItemNewComment(history: _item),
                      if (content == ActivitiesEnum.NEW_NICKNAME)
                        ItemNewNickName(history: _item),
                      if (content == ActivitiesEnum.UP_NOTIFICATION)
                        ItemNotificationComponent(history: _item),
                      if (content == ActivitiesEnum.BLOCK_USER ||
                          content == ActivitiesEnum.UNBLOCK_USER)
                        ItemUpBlockComponent(history: _item),
                      if (content == ActivitiesEnum.TEMPORARILY_DISABLED)
                        const ItemTemporarilyDesabledComponent(),
                      if (content == ActivitiesEnum.NEW_ACCOUNT)
                        const ItemNewAccountComponent(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 2, 0, 0),
                        child: ResumeComponent(
                          resume: editDateUtil(_item['date']),
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

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não há atividades ou não foi possível encontrá-las.');
  }
}
