import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final HistoryClass historyClass = HistoryClass();

  double _getPaddingBottom(bool _isComment) {
    return _isComment && currentUser.value.isNotEmpty ? UiSize.input : 0;
  }

  @override
  Widget build(BuildContext context) {
    final _idHistory = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: FirebaseDatabaseListView(
        query: db.histories.orderByChild('id').equalTo(_idHistory),
        reverse: true,
        pageSize: 10,
        physics: const NeverScrollableScrollPhysics(),
        loadingBuilder: (context) => const SkeletonHistoryItemComponent(),
        errorBuilder: (context, error, stackTrace) => _noResult(),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> data = HistoryModel.toMap(snapshot.value);
          historyClass.selectHistory(data);
          return _history(context, data);
        },
      ),
    );
  }

  Widget _history(BuildContext context, Map<String, dynamic> _data) {
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
                      const DividerComponent(
                        top: 0,
                        bottom: 20,
                        left: 16,
                        right: 16,
                      ),
                      CommentItemComponent(
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

  Widget _noResult() {
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
