// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields, await_only_futures, avoid_print, empty_constructor_bodies, unused_local_variable, unused_element

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
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent({
    Function? callback,
    required String itemSelectedMenu,
  })  : _itemSelectedMenu = itemSelectedMenu,
        _callback = callback;

  final String _itemSelectedMenu;
  final Function? _callback;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItemComponent> {
  final Api api = new Api();
  List<String> _allFavorite = [];

  _getContent() {
    final value = menuItemSelected.value.id!;

    if (value == 'todas') {
      return api.getAllHistory;
    } else if (value == 'minhas') {
      return api.getAllUserHistory('charles.sbs');
    } else if (value == 'lerMaisTarde') {
      return api.getAllUserBookmarks('G9OfntwowPyKsTqHUADH');
    }
    return api.getAllHistoryFiltered(value);
  }

  String _setResume(item) {
    var _date = editDateUtil(item['date'].millisecondsSinceEpoch);
    var author = item['isAnonymous'] ? 'anônimo' : item['user']['nickName'];
    var temp = _date + ' - ' + author;
    return item['isEdit'] ? temp + ' - editada' : temp;
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
    return _allFavorite.contains(id) ? true : false;
  }

  void _toggleFavorite(String id) {
    _allFavorite.contains(id) ? _allFavorite.remove(id) : _allFavorite.add(id);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: menuItemSelected,
      builder: (context, value, __) => StreamBuilder<QuerySnapshot>(
        stream: _getContent(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SkeletonHistoryItemComponent();
            case ConnectionState.done:
            default:
              return _list(context, snapshot);
          }
        },
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<Object?>>? documents = snapshot.data?.docs;
    try {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        itemCount: documents!.length,
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
                    documents[index]['qtyComment'] < 1
                        ? SizedBox()
                        : Text(
                            documents[index]['qtyComment'].toString() +
                                ' comentários',
                            style: uiTextStyle.text2,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (documents[index]['isComment'])
                          IconComponent(
                            icon: uiSvg.comment,
                            callback: (value) =>
                                _showModal(context, documents[index].id, true),
                          ),
                        IconComponent(
                          icon: _getFavorited(documents[index].id)
                              ? uiSvg.favorited
                              : uiSvg.favorite,
                          // TODO: criar função para adicionar aos favoritos.
                          callback: (value) =>
                              _toggleFavorite(documents[index].id),
                        ),
                        IconComponent(
                          icon: uiSvg.open,
                          route: 'history',
                          // TODO: criar função para o botão abrir história.
                        ),
                        IconComponent(
                          icon: uiSvg.options,
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
    } catch (e) {
      return SizedBox();
    }
  }

  Widget _notResult() {
    return Center(
      widthFactor: double.infinity,
      child: Text(
        'Nada para mostrar',
        style: uiTextStyle.text1,
      ),
    );
  }
}
