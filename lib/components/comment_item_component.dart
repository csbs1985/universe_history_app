import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_comment_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/owner_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class CommentItemComponent extends StatefulWidget {
  const CommentItemComponent({required HistoryOptionsType type}) : _type = type;

  final HistoryOptionsType _type;

  @override
  State<CommentItemComponent> createState() => _CommentItemComponentState();
}

class _CommentItemComponentState extends State<CommentItemComponent> {
  final Api api = Api();
  final OwnerClass ownerClass = OwnerClass();
  final CommentClass commentClass = CommentClass();
  final ScrollController _scrollController = ScrollController();

  final List<CommentModel> _data = [];

  static const PAGE_SIZE = 11;

  bool _allFetched = false;
  bool _isLoading = false;

  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();

    _getContent();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_allFetched) {
        _getContent();
      }
    });
  }

  Future<void> _getContent() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final _idHistory = currentHistory.value.first.id;

    Query _query = FirebaseFirestore.instance
        .collection('comments')
        .where('historyId', isEqualTo: _idHistory)
        .orderBy('date', descending: true);

    _query = _lastDocument != null
        ? _query.startAfterDocument(_lastDocument!).limit(PAGE_SIZE)
        : _query.limit(PAGE_SIZE);

    final List<CommentModel> pagedData = await _query.get().then((value) {
      _lastDocument = value.docs.isNotEmpty ? value.docs.last : null;

      return value.docs
          .map((e) => CommentModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });

    setState(() {
      _data.addAll(pagedData);
      if (pagedData.length < PAGE_SIZE) _allFetched = true;
      _isLoading = false;
    });
  }

  void _showModal(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content.userId,
      _content.userNickName,
      _content.userStatus,
      _content.token,
    );

    commentClass.selectComment(_content);

    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => ModalOptionsComponent(
              _content.id,
              'comentário',
              _content.userId,
              _content.userNickName,
              _content.text,
              _content.isDelete,
            ));
  }

  bool _canShowOption(dynamic _content) {
    if (currentUser.value.first.id == _content.userId) {
      if (!_content.isDelete) return true;
    } else {
      if (!_content.isDelete) return true;
    }
    return false;
  }

  Color _getBackColor(_index) {
    if (_index.text.contains('@' + currentUser.value.first.nickname)) {
      return UiColor.first;
    }
    if (_index.userId == currentUser.value.first.id) return UiColor.second;
    return UiColor.comp_3;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: !_data.isNotEmpty
          ? _noResult()
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget._type == HistoryOptionsType.HOMEPAGE)
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _data.length + (_allFetched ? 0 : 1),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _data.length) {
                        return const SkeletonCommentComponent();
                      } else {
                        final item = _data[index];
                        return Column(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 6, 10, 8),
                                  child: item.isDelete
                                      ? Text(
                                          'Comentário apagado!'.toUpperCase(),
                                          style: UiTextStyle.text8,
                                        )
                                      : Text(
                                          item.text,
                                          style: UiTextStyle.text1,
                                        ),
                                ),
                              ),
                              onLongPress: _canShowOption(item)
                                  ? () => _showModal(context, item)
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 4, 0, 16),
                              child: Text(
                                resumeUitl(item,
                                    type: ContentType.COMMENT
                                        .toString()
                                        .split('.')
                                        .last),
                                style: UiTextStyle.text2,
                              ),
                            )
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Nenhum comentário ainda, ou os comentários foram desativados.');
  }
}
