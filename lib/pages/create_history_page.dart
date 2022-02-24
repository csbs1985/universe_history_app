// ignore_for_file: unused_import, unused_field, avoid_print, prefer_final_fields, unnecessary_new, prefer_is_empty, todo, argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/components/select_categories_component.dart';
import 'package:universe_history_app/components/select_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
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

  final ToastComponent toast = new ToastComponent();
  final Api api = new Api();
  final CurrentUser currentUser = CurrentUser([]);

  bool _isAnonymous = true;
  bool _isComment = true;
  bool _btnPublish = false;
  List<String> _categories = [];

  late Map<String, dynamic> history;

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
    history = {
      'title': titleController.text.trim(),
      'text': textController.text.trim(),
      'date': DateTime.now(),
      'isComment': _isComment,
      'isAnonymous': _isAnonymous,
      'isEdit': false,
      'qtyComment': 0,
      'categories': _categories,
      'userId': currentUser.value.first.id,
      'userNickName': currentUser.value.first.nickname,
    };

    api
        .setHistory(history)
        .then((value) => {
              Navigator.of(context).pop(),
              toast.toast(
                  context, ToastEnum.SUCCESS, 'Sua história foi publicada.'),
            })
        .catchError((error) => {
              print('ERROR:' + error),
              toast.toast(context, ToastEnum.WARNING,
                  'Erro ao publicar história, tente novamente mais tarde.')
            });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: uiColor.create_1,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                maxLength: 60,
                autofocus: true,
                style: uiTextStyle.header1,
                onChanged: (value) => _canPublish(),
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: 'Título com até 60 caracteres',
                  hintStyle: uiTextStyle.header1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.create_1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.create_1),
                  ),
                ),
              ),
            ),
            Container(
              color: uiColor.create_2,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                style: uiTextStyle.text1,
                onChanged: (value) => _canPublish(),
                decoration: const InputDecoration(
                  hintText: 'Sua história',
                  hintStyle: uiTextStyle.text1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.create_2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.create_2),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: uiColor.create_3,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SelectComponent(
                title: 'Privacidade',
                type: 'privacy',
                content: allPrivacy,
                callback: (value) => _setPrivacy(value),
              ),
            ),
            Container(
              width: double.infinity,
              color: uiColor.create_4,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SelectComponent(
                title: 'Habilitar comentários',
                type: 'comment',
                content: allComment,
                callback: (value) => _setComment(value),
              ),
            ),
            Container(
              width: double.infinity,
              color: uiColor.create_5,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: SelectCategoriesComponent(
                title: 'Categorizar história',
                resume: 'Selecione ao menos uma categoria/tema.',
                content: allCategories,
                callback: (value) => _setCategories(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
