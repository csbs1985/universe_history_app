import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/skeleton_search_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Api api = Api();
  final TextEditingController _searchController = TextEditingController();

  bool isFilter = false;

  bool _fetchText() {
    setState(() {
      isFilter = _searchController.text.length > 2 ? true : false;
    });

    return isFilter;
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
                style: UiTextStyle.text1,
                onChanged: (value) => _fetchText(),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Buscar por usuário',
                  filled: true,
                  fillColor: UiColor.comp_3,
                  hintStyle: UiTextStyle.text1,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (isFilter)
                StreamBuilder<QuerySnapshot>(
                  stream: api.getUsersNickName(_searchController.text),
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
                          return _list(context, snapshot);
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

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleComponent(
          title:
              '${documents.length} resultados para "${_searchController.text}"',
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (BuildContext context, index) {
            return Text(documents[index]['name'], style: UiTextStyle.text1);
          },
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
