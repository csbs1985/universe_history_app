import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_list_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final HistoryClass historyClass = HistoryClass();

  double _getPaddingBottom(bool _isComment) {
    return _isComment && currentUser.value.isNotEmpty ? UiSize.input : 0;
  }

  @override
  Widget build(BuildContext context) {
    final _idHistory = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: StreamBuilder<QuerySnapshot>(
        stream: historiesFirestore.getHistory(_idHistory),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _noResults();
            case ConnectionState.waiting:
              return const SkeletonHistoryItemComponent();
            case ConnectionState.done:
            default:
              try {
                return _history(context, snapshot);
              } catch (error) {
                return _noResults();
              }
          }
        },
      ),
    );
  }

  Widget _history(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    Map<String, dynamic> _data = HistoryModel.toMap(snapshot.data!.docs[0]);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: _getPaddingBottom(_data['isComment']),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_data['title'] != "")
                              TitleComponent(
                                title: _data['title'],
                                bottom: 0,
                              ),
                            ResumeHistoryComponent(resume: _data),
                            Text(
                              _data['text'],
                              style: UiTextStyle.text1,
                            ),
                            Wrap(
                              children: [
                                for (var item in _data['categories'])
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Text(
                                      '#' + item,
                                      style: UiTextStyle.text2,
                                    ),
                                  )
                              ],
                            ),
                            HistoryOptionsComponent(
                              history: _data,
                              type: HistoryOptionsType.HISTORYPAGE.name,
                            )
                          ],
                        ),
                      ),
                      if (_data['qtyComment'] > 0)
                        const DividerComponent(
                          top: 0,
                          bottom: 20,
                          left: 16,
                          right: 16,
                        ),
                      CommentListComponent(
                        type: HistoryOptionsType.HISTORYPAGE.name,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          const BtnCommentComponent()
        ],
      ),
    );
  }

  Widget _noResults() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: NoResultComponent(
          text: 'História deletada ou não foi possível encontrar',
        ),
      ),
    );
  }
}
