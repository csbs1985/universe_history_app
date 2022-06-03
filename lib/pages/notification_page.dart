import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_notification_componen.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/notification_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final HistoryClass historyClass = HistoryClass();
  final RealtimeDatabaseService db = RealtimeDatabaseService();

  Future<void> _pathNotificationView(_history) async {
    if (!_history['view']) {
      try {
        await db.pathNotificationView(_history['id']);
        setState(() => _history['view'] = true);
      } on AuthException catch (error) {
        debugPrint('ERROR => pathNotificationView: ' + error.toString());
      }
    }

    Navigator.pushNamed(context, '/history', arguments: _history['contentId']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TitleComponent(title: 'Notificações'),
            ),
            FirebaseDatabaseListView(
              query: db.notifications
                  .orderByChild('userId')
                  .equalTo(currentUser.value.first.id),
              reverse: true,
              pageSize: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) =>
                  const SkeletonNotificationComponent(),
              errorBuilder: (context, error, stackTrace) => _noResult(),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> data =
                    NotificationModel.toMap(snapshot.value);
                return _list(data);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            width: double.infinity,
            color: item['view'] ? UiColor.comp_1 : UiColor.comp_3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _comment(item),
                  ResumeComponent(
                    resume: editDateUtil(item['date']),
                  )
                ],
              ),
            ),
          ),
          onTap: () => _pathNotificationView(item),
        )
      ],
    );
  }

  Widget _comment(_item) {
    var _status = _item['status'];
    var _text = '';

    if (_status == NotificationEnum.COMMENT_ANONYMOUS.name)
      _text =
          'Sua história <em>${_item['content']}</em> recebeu um comentário "<em>anônimo</em>".';

    if (_status == NotificationEnum.COMMENT_SIGNED.name)
      _text =
          '<em>${_item['userName']}</em> fez um comentou na história "<em>${_item['content']}</em>".';

    if (_status == NotificationEnum.COMMENT_MENTIONED.name)
      _text =
          '<em>${_item['userName']}</em> mencionou você em um comentário da história "<em>${_item['content']}</em>".';

    return StyledText(
        style: UiTextStyle.text1,
        tags: {'em': StyledTextTag(style: UiTextStyle.text10)},
        text: _text);
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não há ou encontramos notificações no momento.');
  }
}

enum NotificationEnum { COMMENT_SIGNED, COMMENT_ANONYMOUS, COMMENT_MENTIONED }
