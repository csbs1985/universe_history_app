import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_history_item_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/category_model.dart';

class HistoryListComponent extends StatefulWidget {
  const HistoryListComponent();

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryListComponent> {
  final Api api = Api();

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
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return _noResult();
              case ConnectionState.waiting:
                return const SkeletonHistoryItemComponent();
              case ConnectionState.done:
              default:
                try {
                  return HistoryItemComponent(
                    snapshot: snapshot,
                  );
                } catch (error) {
                  return _noResult();
                }
            }
          },
        );
      },
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text:
            'Não encontramos histórias que atendam sua pesquisa. Mas não desista, temos muitas outras histórias para você interagir.');
  }
}
