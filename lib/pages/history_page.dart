// ignore_for_file: unnecessary_new, avoid_print, prefer_const_constructors, prefer_final_fields, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Api api = new Api();

  @override
  Widget build(BuildContext context) {
    final _idHistory = ModalRoute.of(context)!.settings.arguments.toString();

    return StreamBuilder<QuerySnapshot>(
      stream: api.getHistory(_idHistory),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SkeletonHistoryItemComponent();
          case ConnectionState.done:
          default:
            try {
              return _history(context, snapshot);
            } catch (error) {
              return SkeletonHistoryItemComponent();
            }
        }
      },
    );
  }

  Widget _history(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    QueryDocumentSnapshot<dynamic> documents = snapshot.data!.docs.first;
    return Scaffold(
      backgroundColor: uiColor.comp_1,
      appBar: const AppbarBackComponent(),
      body: Material(
        color: uiColor.comp_1,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleComponent(title: documents['title'], bottom: 0),
                        ResumeHistoryComponent(resume: documents),
                        Text(documents['text'], style: uiTextStyle.text1),
                        Wrap(children: [
                          for (var item in documents['categories'])
                            Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child:
                                    Text('#' + item, style: uiTextStyle.text2)),
                        ]),
                        DividerComponent(top: 20, bottom: 4)
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CommentItemComponent()),
                ],
              ),
            ),
            if (currentUser.value.isNotEmpty) const BtnCommentComponent(),
          ],
        ),
      ),
    );
  }
}
