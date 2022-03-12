// ignore_for_file: unnecessary_new, avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Api api = new Api();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: api.getHistory(),
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
        });
  }

  Widget _history(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    QueryDocumentSnapshot<dynamic> documents = snapshot.data!.docs.first;
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TitleComponent(
                    title: documents['title'],
                    bottom: 0,
                  ),
                  ResumeComponent(
                    resume: resumeUitl(documents),
                  ),
                  Text(
                    documents['text'],
                    style: uiTextStyle.text1,
                  ),
                  Wrap(
                    children: [
                      for (var item in documents['categories'])
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '#' + item,
                            style: uiTextStyle.text2,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // CommentComponent(),
          ],
        ),
      ),
    );
  }
}
