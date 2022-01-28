// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/shared/models/favorite_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

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
  List<HistoryModel> _allHistory = HistoryModel.allHistory;
  List<HistoryModel> _allHistorySelected = HistoryModel.allHistory;

  void refresh() {
    setState(() {
      _allHistorySelected = _allHistory
          .where((i) => i.categories.contains(widget._itemSelectedMenu))
          .toList();
    });
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
    return _allHistorySelected.contains(id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _allHistorySelected.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _allHistorySelected[index].title,
              style: uiTextStyle.header1,
            ),
            Text(
              _allHistorySelected[index].date + ' - anônimo',
              style: uiTextStyle.text2,
            ),
            const SizedBox(
              height: 10,
            ),
            ExpandableText(
              _allHistorySelected[index].text,
              style: uiTextStyle.text1,
              expandText: 'continuar lendo',
              collapseText: 'fechar',
              maxLines: 8,
              linkColor: uiColor.first,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !_allHistorySelected[index].isComment
                    ? SizedBox()
                    : TextButton(
                        child: Text(
                          _allHistorySelected[index].qtyComment.toString() +
                              (_allHistorySelected[index].qtyComment > 1
                                  ? ' comentários'
                                  : ' comentário'),
                          style: uiTextStyle.text2,
                        ),
                        onPressed: () => _showModal(
                            context, _allHistorySelected[index].id, false),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_allHistorySelected[index].isComment)
                      IconComponent(
                        svg: uiSvg.comment,
                        action: 'modal',
                        callback: (value) => _showModal(
                            context, _allHistorySelected[index].id, true),
                      ),
                    IconComponent(
                      svg: _getFavorited(_allHistorySelected[index].id)
                          ? uiSvg.favorited
                          : uiSvg.favorite,
                      // TODO: criar função para adicionar aos favoritos.
                      callback: () =>
                          _setFavorited(_allHistorySelected[index].id),
                    ),
                    IconComponent(
                      svg: uiSvg.options,
                      route: 'settings',
                      // TODO: criar função para o botão opções da historia.
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
