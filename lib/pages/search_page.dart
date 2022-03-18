// ignore_for_file: prefer_final_fields, void_checks, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/skeleton_search_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Api api = Api();
  TextEditingController _searchController = TextEditingController();

  _fetchText() {
    setState(() {
      if (_searchController.text.length > 2) {
        var firstLetter = _searchController.text[0];

        if (firstLetter == '@')
          return api.getHistoryNickName(_searchController.text);

        if (firstLetter == '#')
          return api.getHistoryCategory(_searchController.text);

        return api.getHistoryContent(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                style: uiTextStyle.text1,
                onChanged: (value) => _fetchText(),
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: 'Pesquisar',
                  filled: true,
                  fillColor: uiColor.comp_3,
                  hintStyle: uiTextStyle.text1,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "'@' para usuário, '#' para tema/categoria ou digite um trecho do titulo ou do texto da hitsória.'",
                style: uiTextStyle.text2,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: _fetchText(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _noResult();
                    case ConnectionState.waiting:
                      return const SkeletonSearchComponent();
                    case ConnectionState.done:
                    default:
                      try {
                        return HistoryItemComponent(context, snapshot);
                      } catch (error) {
                        return _noResult();
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

  Widget HistoryItemComponent(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return Column(
      children: [
        TitleComponent(
          title:
              '${documents.length} resultados para ${_searchController.text}"',
        ),
      ],
    );
  }

  Widget _noResult() {
    return TitleComponent(
      title: 'nenhum resultado encontrado para "${_searchController.text}"',
    );
  }
}
