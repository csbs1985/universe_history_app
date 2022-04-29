// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new, use_key_in_widget_constructors, curly_braces_in_flow_control_structures, import_of_legacy_library_into_null_safe, unused_element, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ModalMentionedComponent extends StatefulWidget {
  const ModalMentionedComponent({required Function callback})
      : _callback = callback;

  final Function _callback;

  @override
  _ModalMentionedComponentState createState() =>
      _ModalMentionedComponentState();
}

class _ModalMentionedComponentState extends State<ModalMentionedComponent> {
  final TextEditingController _commentController = TextEditingController();

  final Api api = Api();

  List<DocumentSnapshot>? _snapshot;

  void keyUp(String text) {
    if (text.length > 2) {
      api
          .fecthUser(text)
          .then((result) => {
                _snapshot = result!.docs,
                print(_snapshot),
              })
          .catchError((error) => print('ERROR: ' + error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: _snapshot == null
                      ? _noResult()
                      : ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: _snapshot!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Container(
                                      height: 38,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 10),
                                      child: TextButton(
                                        onPressed: () => {},
                                        child: Text(
                                          _snapshot![index]['nickname'],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: uiColor.buttonLabel),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  uiColor.button),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const DividerComponent(bottom: 0),
                Container(
                  height: uiSize.input,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Center(
                    child: TextField(
                      controller: _commentController,
                      onChanged: (value) => keyUp(value),
                      autofocus: true,
                      maxLines: null,
                      style: uiTextStyle.text1,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Mencionar usuário...",
                          hintStyle: uiTextStyle.text7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noResult() {
    return const NoResultComponent(text: 'Nenhum usuáro encontrado.');
  }
}
