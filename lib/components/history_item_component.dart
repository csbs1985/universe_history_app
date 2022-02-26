// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, prefer_is_empty, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_field

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class HistoryItemComponent extends StatefulWidget {
  HistoryItemComponent(
      {required BuildContext context,
      required AsyncSnapshot<QuerySnapshot> snapshot})
      : _context = context,
        _snapshot = snapshot;

  final AsyncSnapshot<QuerySnapshot> _snapshot;
  final BuildContext _context;

  @override
  State<HistoryItemComponent> createState() => _HistoryItemComponentState();
}

class _HistoryItemComponentState extends State<HistoryItemComponent> {
  final HistoryClass historyClass = HistoryClass();
  final CommentClass commentClass = CommentClass();

  String _setResume(item) {
    var _date = editDateUtil(item['date'].millisecondsSinceEpoch);
    var author = item['isAnonymous'] ? 'anônimo' : item['userNickName'];
    var temp = _date + ' - ' + author;
    return item['isEdit'] ? temp + ' - editada' : temp;
  }

  void _showModal(BuildContext context, String type) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => type == 'inputCommentary'
          ? const ModalInputCommmentComponent()
          : ModalCommentComponent(),
    );
  }

  bool _getFavorited(String id) {
    return currentBookmarks.value.contains(id) ? true : false;
  }

  void _toggleFavorite(String id) {
    setState(() {
      currentBookmarks.value.contains(id)
          ? currentBookmarks.value.remove(id)
          : currentBookmarks.value.add(id);
    });
  }

  void _showModalOptions(
    BuildContext context,
    String historyTitle,
  ) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ModalOptionsComponent(
          historyTitle, 'história', currentUser.value.first),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<dynamic>> documents =
        widget._snapshot.data!.docs;
    return documents.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleComponent(
                      title: documents[index]['title'],
                      bottom: 0,
                    ),
                    ResumeComponent(
                      resume: _setResume(documents[index]),
                    ),
                    ExpandableText(
                      documents[index]['text'],
                      style: uiTextStyle.text1,
                      expandText: 'continuar lendo',
                      collapseText: 'fechar',
                      maxLines: 10,
                      linkColor: uiColor.first,
                    ),
                    Wrap(
                      children: [
                        for (var item in documents[index]['categories'])
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              '#' + item,
                              style: uiTextStyle.text2,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        documents[index]['qtyComment'] < 1
                            ? const SizedBox()
                            : TextButton(
                                child: Row(
                                  children: [
                                    AnimatedFlipCounter(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      value: documents[index]['qtyComment'],
                                      textStyle: uiTextStyle.text2,
                                    ),
                                    Text(
                                      documents[index]['qtyComment'] > 1
                                          ? ' comentários'
                                          : ' comentário',
                                      style: uiTextStyle.text2,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  historyClass.selectHistory(
                                    documents[index]['id'],
                                    documents[index].id,
                                  );
                                  commentClass.setQtyComment(
                                      documents[index]['qtyComment']);
                                  _showModal(context, 'listCommentary ');
                                }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (documents[index]['isComment'])
                              IconComponent(
                                  icon: uiSvg.comment,
                                  callback: (value) {
                                    setState(() {
                                      historyClass.selectHistory(
                                        documents[index]['id'],
                                        documents[index].id,
                                      );
                                      commentClass.setQtyComment(
                                          documents[index]['qtyComment']);
                                      _showModal(context, 'inputCommentary');
                                    });
                                  }),
                            ValueListenableBuilder(
                              valueListenable: currentBookmarks,
                              builder: (BuildContext context, value, __) {
                                return IconComponent(
                                  icon: _getFavorited(documents[index]['id'])
                                      ? uiSvg.favorited
                                      : uiSvg.favorite,
                                  callback: (value) {
                                    _toggleFavorite(
                                      documents[index]['id'],
                                    ); // TODO: criar bookmarks
                                  },
                                );
                              },
                            ),
                            IconComponent(
                                icon: uiSvg.open,
                                callback: (value) {
                                  historyClass.selectHistory(
                                    documents[index]['id'],
                                    documents[index].id,
                                  );
                                  Navigator.of(context).pushNamed("/history");
                                }),
                            IconComponent(
                              icon: uiSvg.options,
                              callback: (value) => _showModalOptions(
                                context,
                                documents[index]['title'],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        : const NoHistoryComponent();
  }
}
