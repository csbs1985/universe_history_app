// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, prefer_is_empty, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_history_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

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
  final Api api = Api();

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
              return Column(children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (documents[index]['title'] != "")
                            TitleComponent(
                                title: documents[index]['title'], bottom: 0),
                          ResumeHistoryComponent(resume: documents[index]),
                          ExpandableText(documents[index]['text'],
                              style: uiTextStyle.text1,
                              expandText: 'continuar lendo',
                              collapseText: 'fechar',
                              maxLines: 10,
                              linkColor: uiColor.first),
                          Wrap(children: [
                            for (var item in documents[index]['categories'])
                              Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text('#' + item,
                                      style: uiTextStyle.text2))
                          ]),
                          HistoryOptionsComponent(
                              history: documents[index],
                              type: HistoryOptionsType.HOMEPAGE),
                          const SizedBox(height: 10),
                          const DividerComponent(bottom: 0)
                        ]))
              ]);
            })
        : const NoResultComponent(
            text:
                'Não encontramos histórias que atendam sua pesquisa. Mas não desista, temos muitas outras histórias para você interagir.');
  }
}
