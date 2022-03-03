// ignore_for_file: avoid_print, prefer_final_fields, unused_field, prefer_is_empty, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_my_history_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({Key? key}) : super(key: key);

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  final Api api = Api();

  int qtyHistory = 0;

  String _setResume(item) {
    var _date =
        editDateUtil(DateTime.parse(item['date']).millisecondsSinceEpoch);
    var author = item['isAnonymous'] ? 'anônimo' : item['userNickName'];
    var temp = _date + ' - ' + author;
    return item['isEdit'] ? temp + ' - editada' : temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleComponent(title: qtyHistory.toString() + ' histórias'),
              const Text(
                'Aqui estão suas histórias criadas.',
                style: uiTextStyle.text2,
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: api.getAllUserHistory(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const SkeletonMyHistoryComponent();
                    case ConnectionState.done:
                    default:
                      try {
                        qtyHistory = snapshot.data!.size;
                        return _list(context, snapshot);
                      } catch (error) {
                        return const SkeletonMyHistoryComponent();
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      itemCount: documents.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleComponent(
                    title: documents[index]['title'],
                    bottom: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ResumeComponent(
                        resume: _setResume(documents[index]),
                      ),
                      ResumeComponent(
                          resume: documents[index]['qtyComment'] != 1
                              ? documents[index]['qtyComment'].toString() +
                                  ' comentários'
                              : documents[index]['qtyComment'].toString() +
                                  ' comentário')
                    ],
                  ),
                  Text(
                    documents[index]['text'],
                    style: uiTextStyle.text1,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
