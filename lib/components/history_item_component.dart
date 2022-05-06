// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, prefer_is_empty, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_field

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/owner_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class HistoryItemComponent extends StatefulWidget {
  HistoryItemComponent({
    required BuildContext context,
    required AsyncSnapshot<QuerySnapshot> snapshot,
  })  : _context = context,
        _snapshot = snapshot;

  final AsyncSnapshot<QuerySnapshot> _snapshot;
  final BuildContext _context;

  @override
  State<HistoryItemComponent> createState() => _HistoryItemComponentState();
}

class _HistoryItemComponentState extends State<HistoryItemComponent> {
  final HistoryClass historyClass = HistoryClass();
  final CommentClass commentClass = CommentClass();
  final OwnerClass ownerClass = OwnerClass();

  final Api api = Api();

  void _selectHistory(Map<String, dynamic> _history) {
    ownerClass.selectOwner(
      _history['userId'],
      _history['userNickName'],
      _history['token'],
      _history['statusUser'],
    );
    currentDocHistory.value = _history['id'];
    HistoryClass.selectHistory(_history);
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

  bool _getBookmark(String id) {
    return currentBookmarks.value.contains(id) ? true : false;
  }

  void _toggleBookmark(String id) {
    setState(() {
      currentBookmarks.value.contains(id)
          ? currentBookmarks.value.remove(id)
          : currentBookmarks.value.add(id);
    });

    api.upBookmarks();
  }

  void _showModalOptions(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content['userId'],
      _content['userNickName'],
      _content['token'],
      _content['statusUser'],
    );

    commentClass.selectComment(_content);

    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ModalOptionsComponent(
        _content['id'],
        'história',
        _content['userId'],
        _content['userNickName'],
        _content['text'],
        _content['isDelete'],
      ),
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
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleComponent(
                          title: documents[index]['title'],
                          bottom: 0,
                        ),
                        ResumeComponent(resume: resumeUitl(documents[index])),
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
                                      _selectHistory(documents[index].data());
                                      _showModal(context, 'listCommentary ');
                                    },
                                  ),
                            ValueListenableBuilder(
                              valueListenable: currentUser,
                              builder: (context, value, __) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (documents[index]['isComment'] &&
                                        currentUser.value.isNotEmpty)
                                      IconComponent(
                                          icon: uiSvg.comment,
                                          callback: (value) {
                                            setState(() {
                                              _selectHistory(
                                                  documents[index].data());
                                              _showModal(
                                                  context, 'inputCommentary');
                                            });
                                          }),
                                    if (currentUser.value.isNotEmpty)
                                      ValueListenableBuilder(
                                        valueListenable: currentBookmarks,
                                        builder:
                                            (BuildContext context, value, __) {
                                          return IconComponent(
                                            icon: _getBookmark(
                                                    documents[index]['id'])
                                                ? uiSvg.favorited
                                                : uiSvg.favorite,
                                            callback: (value) {
                                              _toggleBookmark(
                                                documents[index]['id'],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    IconComponent(
                                        icon: uiSvg.open,
                                        callback: (value) {
                                          _selectHistory(
                                              documents[index].data());
                                          Navigator.pushNamed(
                                              context, '/history',
                                              arguments: documents[index]
                                                  .data()['id']);
                                        }),
                                    IconComponent(
                                      icon: uiSvg.options,
                                      callback: (value) => {
                                        _selectHistory(documents[index].data()),
                                        _showModalOptions(
                                            context, documents[index].data()),
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const DividerComponent(bottom: 0),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        : const NoResultComponent(
            text:
                'Não encontramos histórias que atendam sua pesquisa. Mas não desista, temos muitas outras histórias para você interagir.');
  }
}
