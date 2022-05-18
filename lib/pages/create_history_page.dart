// ignore_for_file: unused_import, unused_field, avoid_print, prefer_final_fields, unnecessary_new, prefer_is_empty, todo, argument_type_not_assignable_to_error_handler, invalid_return_type_for_catch_error, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/select_categories_component.dart';
import 'package:universe_history_app/components/select_toggle_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/category_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/select_modal.dart';
import 'package:universe_history_app/models/user_model.dart';
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
  bool _isAuthorized = false;

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
      _isAuthorized = currentHistory.value.first.isAuthorized;
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

  void _setAuthorized() {
    setState(() {
      _isAuthorized = !_isAuthorized;
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
      _btnPublish = (textController.text.isNotEmpty && _categories.isNotEmpty)
          ? true
          : false;
    });
  }

  void _publishHistory(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    currentDialog.value = 'Criando...';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    setState(() {
      if (currentHistory.value.isNotEmpty) {
        history = {
          'id': currentHistory.value.first.id,
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': currentHistory.value.first.date,
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': true,
          'isDelete': false,
          'isAuthorized': _isAuthorized,
          'qtyComment': currentHistory.value.first.qtyComment,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userNickName': currentUser.value.first.nickname
        };
      } else {
        history = {
          'id': uuid.v4(),
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': DateTime.now().toString(),
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': false,
          'isDelete': false,
          'isAuthorized': _isAuthorized,
          'qtyComment': 0,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userNickName': currentUser.value.first.nickname
        };
      }
      api
          .setHistory(history)
          .then((value) => {
                ActivityUtil(
                    isEdit
                        ? ActivitiesEnum.NEW_HISTORY
                        : ActivitiesEnum.UP_HISTORY,
                    titleController.text,
                    history['id']),
                _setUpQtyHistoryUser()
              })
          .catchError((error) => {
                debugPrint('ERROR:' + error.toString()),
                toast.toast(context, ToastEnum.WARNING,
                    'Erro ao publicar história, tente novamente mais tarde.')
              });
    });
  }

  Future<void> _setUpQtyHistoryUser() async {
    if (!isEdit) currentUser.value.first.qtyHistory++;

    await api
        .setUpQtyHistoryUser()
        .then((value) => {
              if (currentHistory.value.isNotEmpty) Navigator.of(context).pop(),
              Navigator.of(context).pop(),
              toast.toast(
                  context,
                  ToastEnum.SUCCESS,
                  isEdit
                      ? 'Sua história foi alterada.'
                      : 'Sua história foi publicada.'),
              Navigator.of(context).pop()
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppbarComponent(
            btnBack: true,
            btnPublish: _btnPublish,
            callback: (value) => _publishHistory(context)),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none)))),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: null,
              style: uiTextStyle.text1,
              onChanged: (value) => _canPublish(),
              decoration: const InputDecoration(
                hintText: 'História',
                hintStyle: uiTextStyle.text1,
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                  callback: (value) => _setPrivacy(),
                  title: 'Assinatura',
                  resume:
                      'Ligado para assinar como ${currentUser.value.first.nickname} ou desligado para anônimo.',
                  value: _isSigned)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                title: 'Comentários',
                resume:
                    'Ligado para habilitar ou desligado para desabilitar os comentários na história. ',
                value: _isComment,
                callback: (value) => _setComment(),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                  title: 'Autorizado',
                  resume:
                      'Ligado para marcar história como de terceiro com autorização para publicar. ',
                  value: _isAuthorized,
                  callback: (value) => _setAuthorized())),
          SelectCategoriesComponent(
              title: 'Assunto',
              resume: 'Selecione ao menos uma categoria/tema.',
              content: allCategories,
              selected: currentHistory.value.isNotEmpty
                  ? currentHistory.value.first.categories
                  : [],
              callback: (value) => _setCategories(value))
        ])));
  }
}
