// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields, await_only_futures, avoid_print, empty_constructor_bodies, unused_local_variable, unused_element, prefer_is_empty, unnecessary_null_comparison, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
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

    if (value == 'todas' || value.isEmpty || value == '') {
      return api.getAllHistory();
    } else if (value == 'minhas') {
      return api.getAllUserHistory("d31q2laUIRDwLdfK8cCA");
    } else if (value == 'lerMaisTarde') {
      return api.getAllUserBookmarks('d31q2laUIRDwLdfK8cCA');
    }
    return api.getAllHistoryFiltered(value);
  }

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
          ? ModalInputCommmentComponent()
          : ModalCommentComponent(),
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
    return ValueListenableBuilder<CategoryModel>(
      valueListenable: menuItemSelected,
      builder: (context, value, __) => StreamBuilder<QuerySnapshot>(
        stream: _getContent(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _notResult();
            case ConnectionState.waiting:
              return SkeletonHistoryItemComponent();
            case ConnectionState.done:
            default:
              try {
                return _list(context, snapshot);
              } catch (e) {
                return _notResult();
              }
          }
        },
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.length > 0
        ? ListView.builder(
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        documents[index]['qtyComment'] < 1
                            ? SizedBox()
                            : GestureDetector(
                                child: Text(
                                  documents[index]['qtyComment'] > 1
                                      ? documents[index]['qtyComment']
                                              .toString() +
                                          ' comentários'
                                      : '1 comentário',
                                  style: uiTextStyle.text2,
                                ),
                                onTap: () {
                                  setState(() {
                                    currentHistory.value = documents[index].id;
                                    currentQtyComment.value =
                                        documents[index]['qtyComment'];
                                    _showModal(context, 'listCommentary ');
                                  });
                                }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (documents[index]['isComment'])
                              IconComponent(
                                  icon: uiSvg.comment,
                                  callback: (value) {
                                    setState(() {
                                      currentHistory.value =
                                          documents[index].id;
                                      currentQtyComment.value =
                                          documents[index]['qtyComment'];
                                      _showModal(context, 'inputCommentary');
                                    });
                                  }),
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
                  ],
                ),
              );
            },
          )
        : _notResult();
  }

  Widget _notResult() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
        children: const [
          Text(
            'Nada para mostrar',
            style: uiTextStyle.text1,
          ),
          Text(
            'Não encontramos histórias que atendam sua pesquisa.',
            style: uiTextStyle.text2,
          ),
          Text(
            'Mas não desista, temos muitas outras histórias para você interagir.',
            style: uiTextStyle.text2,
          ),
        ],
      ),
    );
  }
}
