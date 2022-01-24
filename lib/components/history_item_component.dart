// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/shared/models/favorite_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent(this.allHistory);
  final List<HistoryModel> allHistory;

  @override
  _HistoryItemState createState() => _HistoryItemState(allHistory);
}

class _HistoryItemState extends State<HistoryItemComponent> {
  _HistoryItemState(this.allHistory);
  final List<HistoryModel> allHistory;
  List<FavoriteModel> allFavorite = FavoriteModel.allFavorite;

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
    return allHistory.contains(id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.allHistory.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.allHistory[index].title,
                style: uiTextStyle.header1,
              ),
              Text(
                widget.allHistory[index].date + ' - anônimo',
                style: uiTextStyle.text2,
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableText(
                widget.allHistory[index].text,
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
                  !widget.allHistory[index].isComment
                      ? SizedBox()
                      : TextButton(
                          child: Text(
                            widget.allHistory[index].qtdComment.toString() +
                                (widget.allHistory[index].qtdComment > 1
                                    ? ' comentários'
                                    : ' comentário'),
                            style: uiTextStyle.text2,
                          ),
                          onPressed: () => _showModal(
                              context, widget.allHistory[index].id, false),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.allHistory[index].isComment)
                        IconButton(
                            onPressed: () => _showModal(
                                context, widget.allHistory[index].id, true),
                            icon: SvgPicture.asset(uiSvg.comment)),
                      IconButton(
                        onPressed: () =>
                            _setFavorited(widget.allHistory[index].id),
                        icon: _getFavorited(widget.allHistory[index].id)
                            ? SvgPicture.asset(uiSvg.favorited)
                            : SvgPicture.asset(uiSvg.favorite),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(uiSvg.options),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
