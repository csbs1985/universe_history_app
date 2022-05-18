// ignore_for_file: use_key_in_widget_constructors, todo, prefer_const_constructors, unused_field, iterable_contains_unrelated_type, list_remove_unrelated_type, no_logic_in_create_state, unnecessary_new, prefer_final_fields, await_only_futures, avoid_print, empty_constructor_bodies, unused_local_variable, unused_element, prefer_is_empty, unnecessary_null_comparison, unnecessary_cast, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/category_model.dart';

class HistoryListComponent extends StatefulWidget {
  const HistoryListComponent({
    Function? callback,
    required String itemSelectedMenu,
  })  : _itemSelectedMenu = itemSelectedMenu,
        _callback = callback;

  final String _itemSelectedMenu;
  final Function? _callback;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryListComponent> {
  final Api api = new Api();

  _getContent() {
    final value = menuItemSelected.value.id!;
    if (value == 'todas' || value.isEmpty) return api.getAllHistory();
    if (value == 'minhas') return api.getHistoryUser();
    if (value == 'salvas') return api.getAllBookmarks();
    return api.getAllHistoryFiltered(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CategoryModel>(
        valueListenable: menuItemSelected,
        builder: (context, value, __) {
          return StreamBuilder<QuerySnapshot>(
              stream: _getContent(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _noResult();
                  case ConnectionState.waiting:
                    return SkeletonHistoryItemComponent();
                  case ConnectionState.done:
                  default:
                    try {
                      return HistoryItemComponent(
                        context: context,
                        snapshot: snapshot,
                      );
                    } catch (error) {
                      return _noResult();
                    }
                }
              });
        });
  }

  Widget _noResult() {
    return NoResultComponent(
        text:
            'Não encontramos histórias que atendam sua pesquisa. Mas não desista, temos muitas outras histórias para você interagir.');
  }
}
