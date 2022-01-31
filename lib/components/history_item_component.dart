// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields, await_only_futures, avoid_print, empty_constructor_bodies

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/shared/models/favorite_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent(
      {Function? callback, required String itemSelectedMenu})
      : _itemSelectedMenu = itemSelectedMenu,
        _callback = callback;

  final String _itemSelectedMenu;
  final Function? _callback;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItemComponent> {
  List<FavoriteModel> allFavorite = FavoriteModel.allFavorite;
  List<DocumentSnapshot> _allHistory = [];

  // void refresh() {
  //   setState(() {
  //     _allHistory = _allHistory
  //         .where((i) => i.categories.contains(widget._itemSelectedMenu))
  //         .toList();
  //   });
  // }

  _getContent() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection('historys')
        .orderBy('date')
        .snapshots();

    return snapshot;
  }

  void _setFavorited(String id) {
    const user = 'charlesSantos';
    FavoriteModel favorite =
        new FavoriteModel(id: '4', history: id, user: user);

    allFavorite.contains(id)
        ? allFavorite.remove(id)
        : allFavorite.add(favorite);
  }

  void _showModal(BuildContext context, String historyId, bool openKeyboard) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ModalCommentComponent(historyId, openKeyboard),
    );
  }

  bool _getFavorited(String id) {
    return _allHistory.contains(id) ? true : false;
  }

  String _setResume(item) {
    var _date = editDateUtil(item['date'].millisecondsSinceEpoch);
    var author = item['isAnonymous'] ? 'anônimo' : item['user']['nickName'];
    var temp = _date + ' - ' + author;
    return item['isEdit'] ? temp + ' - editada' : temp;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getContent(),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SkeletonHistoryItemComponent();
          default:
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
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
                        maxLines: 8,
                        linkColor: uiColor.first,
                      ),
                      DividerComponent(top: 10, bottom: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !documents[index]['isComment']
                              ? SizedBox()
                              : GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      documents[index]['qtyComment']
                                              .toString() +
                                          (documents[index]['qtyComment'] > 1
                                              ? ' comentários'
                                              : ' comentário'),
                                      style: uiTextStyle.text2,
                                    ),
                                  ),
                                  onTap: () => _showModal(
                                    context,
                                    documents[index].id,
                                    false,
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (documents[index]['isComment'])
                                IconComponent(
                                  svg: uiSvg.comment,
                                  callback: (value) => _showModal(
                                      context, documents[index].id, true),
                                ),
                              IconComponent(
                                svg: _getFavorited(documents[index].id)
                                    ? uiSvg.favorited
                                    : uiSvg.favorite,
                                // TODO: criar função para adicionar aos favoritos.
                                callback: () =>
                                    _setFavorited(documents[index].id),
                              ),
                              IconComponent(
                                svg: uiSvg.open,
                                route: 'history',
                                // TODO: criar função para o botão abrir história.
                              ),
                              IconComponent(
                                svg: uiSvg.options,
                                route: 'options',
                                // TODO: criar função para o botão opções da história.
                              ),
                            ],
                          )
                        ],
                      ),
                      DividerComponent(top: 10, bottom: 10),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
