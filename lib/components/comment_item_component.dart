import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_comment_component.dart';
import 'package:universe_history_app/modal/options_modal.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/owner_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class CommentItemComponent extends StatefulWidget {
  const CommentItemComponent({
    required String type,
  }) : _type = type;

  final String _type;

  @override
  State<CommentItemComponent> createState() => _CommentItemComponentState();
}

class _CommentItemComponentState extends State<CommentItemComponent> {
  final CommentClass commentClass = CommentClass();
  final OwnerClass ownerClass = OwnerClass();
  final RealtimeDatabaseService db = RealtimeDatabaseService();

  Color _getBackColor(_index) {
    if (_index['text'].contains('@' + currentUser.value.first.name)) {
      return UiColor.first;
    }
    if (_index['userId'] == currentUser.value.first.id) return UiColor.second;
    return UiColor.comp_3;
  }

  void _showModal(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content['userId'],
      _content['userName'],
      _content['userStatus'],
      _content['token'],
    );

    commentClass.selectComment(_content);

    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => OptionsModal(
              _content.id,
              'comentário',
              _content.userId,
              _content.userName,
              _content.text,
              _content.isDelete,
            ));
  }

  bool _canShowOption(dynamic _content) {
    if (currentUser.value.first.id == _content['userId']) {
      if (!_content['isDelete']) return true;
    } else {
      if (!_content['isDelete']) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget._type == HistoryOptionsType.HOMEPAGE.name)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    if (currentHistory.value.first.qtyComment > 0)
                      AnimatedFlipCounter(
                        duration: const Duration(milliseconds: 500),
                        value: currentHistory.value.first.qtyComment,
                        textStyle: UiTextStyle.text1,
                      ),
                    ValueListenableBuilder(
                      valueListenable: currentHistory,
                      builder: (BuildContext context, value, __) {
                        return Text(
                          currentHistory.value.first.qtyComment > 1
                              ? ' comentários'
                              : ' comentário',
                          style: UiTextStyle.text1,
                        );
                      },
                    )
                  ],
                ),
              ),
            FirebaseDatabaseListView(
              query: db.comments
                  .orderByChild('historyId')
                  .equalTo(currentHistory.value.first.id),
              pageSize: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              loadingBuilder: (context) => const SkeletonCommentComponent(),
              errorBuilder: (context, error, stackTrace) => _noResult(),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> data = CommentModel.toMap(snapshot.value);
                return _list(data);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Card(
                color: _getBackColor(item),
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    UiBorder.rounded,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                  child: item['isDelete']
                      ? Text(
                          'Comentário apagado!'.toUpperCase(),
                          style: UiTextStyle.text8,
                        )
                      : Text(
                          item['text'],
                          style: UiTextStyle.text1,
                        ),
                ),
              ),
              onLongPress:
                  _canShowOption(item) ? () => _showModal(context, item) : null,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 4, 0, 16),
              child: Text(
                resumeUitl(
                  item,
                  type: ContentType.COMMENT.name,
                ),
                style: UiTextStyle.text2,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Nenhum comentário ainda, ou os comentários foram desativados.');
  }
}
