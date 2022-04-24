// ignore_for_file: unused_import, unused_field, avoid_print, prefer_final_fields, unnecessary_new, prefer_is_empty, todo, argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/select_categories_component.dart';
import 'package:universe_history_app/components/select_toggle_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class CreateHistory extends StatefulWidget {
  const CreateHistory({Key? key}) : super(key: key);

  @override
  _CreateHistoryState createState() => _CreateHistoryState();
}

class _CreateHistoryState extends State<CreateHistory> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<CategoryModel> allCategories = CategoryModel.allCategories;
  List<CategoryModel> categoriesSelected = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  final ToastComponent toast = new ToastComponent();
  final Api api = new Api();
  final UserClass userClass = UserClass();
  final Uuid uuid = const Uuid();

  bool isEdit = false;
  bool _isSigned = true;
  bool _isComment = true;
  bool _btnPublish = false;

  List<String> _categories = [];

  late Map<String, dynamic> history;
  late Map<String, dynamic> activity;

  @override
  void initState() {
    if (currentHistory.value.isNotEmpty) {
      isEdit = true;
      _btnPublish = true;
      titleController.text = currentHistory.value.first.title;
      textController.text = currentHistory.value.first.text;
      _isSigned = currentHistory.value.first.isSigned;
      _isComment = currentHistory.value.first.isComment;
      _categories = currentHistory.value.first.categories;
    }

    super.initState();
  }

  void _setPrivacy() {
    setState(() {
      _isSigned = !_isSigned;
      _canPublish();
    });
  }

  void _setComment() {
    setState(() {
      _isComment = !_isComment;
      _canPublish();
    });
  }

  void _setCategories(List<String> value) {
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

  void _publishHistory() {
    setState(() {
      history = {
        'id': currentHistory.value.first.id ?? uuid.v4(),
        'title': titleController.text.trim(),
        'text': textController.text.trim(),
        'date': currentHistory.value.first.date ?? DateTime.now().toString(),
        'isComment': _isComment,
        'isSigned': _isSigned,
        'isEdit': currentHistory.value.isNotEmpty ? true : false,
        'isDelete': false,
        'qtyComment': currentHistory.value.first.qtyComment ?? 0,
        'categories': _categories,
        'userId': currentUser.value.first.id,
        'userNickName': currentUser.value.first.nickname,
      };

      api
          .setHistory(history)
          .then((value) => {
                ActivityUtil(
                  isEdit
                      ? ActivitiesEnum.NEW_HISTORY
                      : ActivitiesEnum.UP_HISTORY,
                  titleController.text,
                  history['id'],
                ),
                _setUpQtyHistoryUser()
              })
          .catchError((error) => {
                print('ERROR:' + error),
                toast.toast(context, ToastEnum.WARNING,
                    'Erro ao publicar história, tente novamente mais tarde.')
              });
    });
  }

  void _setUpQtyHistoryUser() async {
    if (!isEdit) {
      currentUser.value.first.qtyHistory++;
    }

    await api
        .setUpQtyHistoryUser()
        .then((value) => {
              Navigator.of(context).pop(),
              toast.toast(
                  context,
                  ToastEnum.SUCCESS,
                  isEdit
                      ? 'Sua história foi alterada.'
                      : 'Sua história foi publicada.'),
              Navigator.of(context).pop(),
            })
        .catchError((error) => {print('ERROR:' + error)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppbarComponent(
        btnBack: true,
        btnPublish: _btnPublish,
        callback: (value) => _publishHistory(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                  hintText: 'Título',
                  hintStyle: uiTextStyle.header2,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                style: uiTextStyle.text1,
                onChanged: (value) => _canPublish(),
                decoration: const InputDecoration(
                  hintText: 'História',
                  hintStyle: uiTextStyle.text1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SelectToggleComponent(
              callback: (value) => _setPrivacy(),
              title: 'Assinatura',
              resume:
                  'Ligado para assinar como ${currentUser.value.first.nickname} ou desligado para anônimo.',
              value: _isSigned,
            ),
            SelectToggleComponent(
              callback: (value) => _setComment(),
              title: 'Comentários',
              resume:
                  'Ligado para habilitar ou desligado para desabilitar os comentários na história. ',
              value: _isComment,
            ),
            SelectCategoriesComponent(
              title: 'Assunto',
              resume: 'Selecione ao menos uma categoria/tema.',
              content: allCategories,
              selected: currentHistory.value.first.categories,
              callback: (value) => _setCategories(value),
            ),
          ],
        ),
      ),
    );
  }
}
