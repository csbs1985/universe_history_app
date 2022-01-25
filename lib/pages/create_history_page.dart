// ignore_for_file: unused_import, unused_field, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/components/radio_component.dart';
import 'package:universe_history_app/components/select_component.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CreateHistory extends StatefulWidget {
  const CreateHistory({Key? key}) : super(key: key);

  @override
  _CreateHistoryState createState() => _CreateHistoryState();
}

class _CreateHistoryState extends State<CreateHistory> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<CategoryModel> allCategories = CategoryModel.allCategories;
  List<CategoryModel> categoriesSelected = [];
  List<SelectModel> allPrivacy = SelectModel.allPrivacy;
  List<SelectModel> allComment = SelectModel.allComment;

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  final String buttonText = 'publicar';

  Map _form = {
    "privacy": 0,
    "comment": 0,
    "categories": [],
    "title": '',
    "text": ''
  };

  bool _btnPublish = false;

  void _setContent() {
    setState(() {
      print(titleController.text);
      print(textController.text);
      _btnPublish =
          (titleController.text.isNotEmpty && textController.text.isNotEmpty)
              ? true
              : false;
    });
  }

  void _setPrivacy(value) {
    setState(() {
      // _form = value;
      print(value);
    });
  }

  void _setComment(value) {
    setState(() {
      print(value);
    });
  }

  void _setCategories(value) {
    setState(() {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppbarComponent(
        btnBack: true,
        btnPublish: _btnPublish,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                maxLength: 60,
                autofocus: true,
                style: uiTextStyle.header1,
                onChanged: (value) => _setContent(),
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: 'Título com até 60 caracteres',
                  hintStyle: uiTextStyle.header1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.comp_1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.comp_1),
                  ),
                ),
              ),
              TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 20,
                style: uiTextStyle.text1,
                onChanged: (value) => _setContent(),
                decoration: const InputDecoration(
                  hintText: 'Sua história',
                  hintStyle: uiTextStyle.text1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.comp_1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.comp_1),
                  ),
                ),
              ),
              SelectComponent(
                title: 'Privacidade',
                type: 'privacy',
                content: allPrivacy,
                callback: (value) => _setPrivacy(value),
              ),
              SelectComponent(
                title: 'Habilitar comentários',
                type: 'comment',
                content: allComment,
                callback: (value) => _setComment(value),
              ),
              RadioComponent(
                title: 'Categorias',
                content: allCategories,
                callback: (value) => _setCategories(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
