// ignore_for_file: unused_import, unused_field, avoid_print, prefer_final_fields, unnecessary_new, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/components/select_categories_component.dart';
import 'package:universe_history_app/components/select_component.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
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
  bool _isAnonymous = true;
  bool _isComment = true;
  List<String> _categories = [];
  Map<String, dynamic> _form = {};

  bool _btnPublish = false;

  void _setPrivacy(value) {
    setState(() {
      _isAnonymous = isAnonymous(value);
      _canPublish();
    });
  }

  void _setComment(value) {
    setState(() {
      _isComment = isComment(value);
      _canPublish();
    });
  }

  void _setCategories(value) {
    setState(() {
      _categories = value;
      _canPublish();
    });
  }

  void _canPublish() {
    setState(() {
      _btnPublish = (titleController.text.isNotEmpty &&
              textController.text.isNotEmpty &&
              _categories.isNotEmpty)
          ? true
          : false;
    });
  }

  void _publishHIstory() {
    print('história publicada com sucesso!');
    Map<String, dynamic> _form = {
      'title': titleController.text,
      'text': textController.text,
      'date': new DateTime.now(),
      'isComment': _isComment,
      'isAnonymous': _isAnonymous,
      'isEdit': false,
      'isDelete': false,
      'userId': getCurrentId(),
      'qtyComment': 0,
      'categories': _categories,
    };
    print(_form);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppbarComponent(
        btnBack: true,
        btnPublish: _btnPublish,
        callback: (value) => _publishHIstory(),
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
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                style: uiTextStyle.header1,
                onChanged: (value) => _canPublish(),
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
                onChanged: (value) => _canPublish(),
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
              SelectCategoriesComponent(
                title: 'Categorizar história',
                resume: 'Selecione ao menos uma categoria/tema.',
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
