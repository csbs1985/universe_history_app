// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields, await_only_futures, avoid_print, empty_constructor_bodies, unused_local_variable, unused_element, prefer_is_empty, unnecessary_null_comparison, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/not_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class HistoryItemComponent extends StatefulWidget {
  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItemComponent> {
  final Api api = new Api();
  late final HistoryModel _history;
  String user = UserModel.user.first.id;

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

  void _showModalOptions(BuildContext context, dynamic history) {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => ModalOptionsComponent(
            history['title'], 'historia', UserModel.user.first));
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoryModel>(
      valueListenable: menuItemSelected,
      builder: (context, value, __) => StreamBuilder<QuerySnapshot>(
        stream: api.getHistory(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return NotHistoryComponent();
            case ConnectionState.waiting:
              return SkeletonHistoryItemComponent();
            case ConnectionState.done:
            default:
              try {
                return _item(context, snapshot);
              } catch (e) {
                return NotHistoryComponent();
              }
          }
        },
      ),
    );
  }

  Widget _item(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            ValueListenableBuilder(
                              valueListenable: currentBookmarks,
                              builder: (_, value, __) => IconComponent(
                                  icon: _getFavorited(documents[index].id)
                                      ? uiSvg.favorited
                                      : uiSvg.favorite,
                                  callback: (value) {
                                    _toggleFavorite(documents[index].id);
                                    print(currentBookmarks.value);
                                    // api.upBookmarks(user);
                                  }),
                            ),
                            IconComponent(
                                icon: uiSvg.open,
                                callback: (value) {
                                  currentHistory.value = documents[index].id;
                                  Navigator.of(context).pushNamed("/history");
                                }),
                            IconComponent(
                              icon: uiSvg.options,
                              callback: (value) => _showModalOptions(
                                  context, documents[index].data()),
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
        : NotHistoryComponent();
  }
}
