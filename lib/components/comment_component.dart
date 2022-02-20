// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_new, unused_local_variable

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/skeleton_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class CommentComponent extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentComponent> {
  final Api api = new Api();
  List<CommentModel> documents = [];

  String _setResume(item) {
    var _date = editDateUtil(item['date'].millisecondsSinceEpoch);
    var author = item['isAnonymous'] ? 'anônimo' : item['userNickName'];
    var temp = _date + ' - ' + author;
    return item['isEdit'] ? temp + ' - editada' : temp;
  }

  void _showModal(BuildContext context, dynamic history) {
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => ModalOptionsComponent(
            history['text'], 'comentário', currentUser.value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 16),
          child: Row(
            children: [
              if (currentQtyComment.value > 0)
                AnimatedFlipCounter(
                  duration: Duration(milliseconds: 500),
                  value: currentQtyComment.value,
                  textStyle: uiTextStyle.text1,
                ),
              Text(
                currentQtyComment.value > 1 ? ' comentários' : ' comentário',
                style: uiTextStyle.text1,
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: api.getAllComment(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return _notResult();
                case ConnectionState.waiting:
                  return SkeletonComponent();
                case ConnectionState.done:
                default:
                  try {
                    currentQtyComment.value = snapshot.data!.docs.length;
                    return _list(context, snapshot);
                  } catch (e) {
                    return _notResult();
                  }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Card(
                      color: uiColor.comp_3,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                        child: Text(
                          documents[index]['text'],
                          style: uiTextStyle.text1,
                        ),
                      ),
                    ),
                    onLongPress: () =>
                        _showModal(context, documents[index].data()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      _setResume(documents[index]),
                      style: uiTextStyle.text2,
                    ),
                  )
                ],
              ),
            ),
          )
        : SkeletonComponent();
  }

  Widget _notResult() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Nada para mostrar',
            style: uiTextStyle.text1,
          ),
          Text(
            'Seja o primeiro a comentar esta história',
            style: uiTextStyle.text2,
          ),
        ],
      ),
    );
  }
}
