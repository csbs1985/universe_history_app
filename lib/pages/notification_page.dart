// ignore_for_file: iterable_contains_unrelated_type, avoid_print, non_constant_identifier_names, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_notification_componen.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Api api = Api();
  @override
  void initState() {
    setState(() => currentNotification.value = false);
    super.initState();
  }

  void _readNotification(history) {
    api
        .upNotification(history['id'])
        .then((result) => {
              Navigator.pushNamed(context, '/history',
                  arguments: history['idContent']),
            })
        .catchError((error) => print('ERROR: ' + error));
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
                child: TitleComponent(title: 'Notificações')),
            StreamBuilder(
              stream: api.getAllNotification(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _noResult();
                  case ConnectionState.waiting:
                    return const SkeletonNotificationComponent();
                  case ConnectionState.done:
                  default:
                    try {
                      return _list(context, snapshot);
                    } catch (e) {
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

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      color: documents[index]['view']
                          ? uiColor.comp_1
                          : uiColor.comp_3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (documents[index]['status'] ==
                                NotificationEnum.COMMENT_ANONYMOUS.toString())
                              _commentAnonymous(documents[index]),
                            if (documents[index]['status'] ==
                                NotificationEnum.COMMENT_SIGNED.toString())
                              _commentSigned(documents[index]),
                            if (documents[index]['status'] ==
                                NotificationEnum.COMMENT_MENTIONED.toString())
                              _commentMentioned(documents[index]),
                            ResumeComponent(
                              resume: editDateUtil(
                                  DateTime.parse(documents[index]['date'])
                                      .millisecondsSinceEpoch),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () => _readNotification(documents[index]),
                  ),
                ],
              ),
            ),
          )
        : _noResult();
  }

  Widget _commentAnonymous(index) {
    return Wrap(children: [
      const Text('Sua história "', style: uiTextStyle.text1),
      Text(index['content'], style: uiTextStyle.text9),
      const Text('" recebeu um comentário ', style: uiTextStyle.text1),
      const Text('anônimo.', style: uiTextStyle.text9),
    ]);
  }

  Widget _commentSigned(index) {
    return Wrap(children: [
      Text(index['nickName'], style: uiTextStyle.text9),
      const Text(' fez um comentou na história "', style: uiTextStyle.text1),
      Text(index['content'], style: uiTextStyle.text9),
      const Text('".', style: uiTextStyle.text1),
    ]);
  }

  Widget _commentMentioned(index) {
    return Wrap(children: [
      Text(index['nickName'], style: uiTextStyle.text9),
      const Text(' mencionou você em um comentário da história "',
          style: uiTextStyle.text1),
      Text(index['content'], style: uiTextStyle.text9),
      const Text('".', style: uiTextStyle.text1),
    ]);
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não encontramos notificações no momento.');
  }
}

enum NotificationEnum { COMMENT_SIGNED, COMMENT_ANONYMOUS, COMMENT_MENTIONED }
