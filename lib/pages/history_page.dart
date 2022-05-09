// ignore_for_file: unnecessary_new, avoid_print, prefer_const_constructors, prefer_final_fields, unused_local_variable, prefer_generic_function_type_aliases, unused_field, unused_element, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Api api = new Api();

  double _getPaddingBottom() {
    return currentHistory.value.first.isComment && currentUser.value.isNotEmpty
        ? 0
        : uiSize.input;
  }

  @override
  Widget build(BuildContext context) {
    final _idHistory = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: StreamBuilder<QuerySnapshot>(
        stream: api.getHistory(_idHistory),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _notResult();
            case ConnectionState.waiting:
              return SkeletonHistoryItemComponent();
            case ConnectionState.done:
            default:
              try {
                return _history(context, snapshot);
              } catch (error) {
                return _notResult();
              }
          }
        },
      ),
    );
  }

  Widget _history(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    QueryDocumentSnapshot<dynamic> documents = snapshot.data!.docs.first;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: _getPaddingBottom()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (documents['title'] != "")
                              TitleComponent(
                                  title: documents['title'], bottom: 0),
                            ResumeHistoryComponent(resume: documents),
                            Text(documents['text'], style: uiTextStyle.text1),
                            Wrap(children: [
                              for (var item in documents['categories'])
                                Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Text('#' + item,
                                        style: uiTextStyle.text2))
                            ]),
                            HistoryOptionsComponent(
                                history: documents,
                                type: HistoryOptionsType.HISTORYPAGE)
                          ],
                        ),
                      ),
                      DividerComponent(top: 0, bottom: 20, left: 16, right: 16),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: CommentItemComponent(
                              type: HistoryOptionsType.HISTORYPAGE)),
                    ],
                  ),
                ),
              );
            },
          ),
          const BtnCommentComponent(),
        ],
      ),
    );
  }

  Widget _notResult() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: NoResultComponent(
              text: 'História deletada ou não foi possível encontrar')),
    );
  }
}
