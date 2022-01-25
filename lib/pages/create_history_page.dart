// ignore_for_file: unused_import, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  // late HistoryModel _newHistory;
  final String buttonText = 'publicar';
  bool _isHistory = false;

  void _setHistory() {
    // _newHistory = {
    //   id: "",
    //   title: titleController.text,
    //   text: textController.text,
    //   date: "",
    //   isComment: "",
    //   isAnonymous: "",
    //   edit: "",
    //   delete: "",
    //   id: "",
    //   categories: [],
    // };
    print(titleController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: !_isHistory
                ? ButtonDisabledComponent(buttonText)
                : TextButton(
                    child: Text(
                      buttonText,
                      style: uiTextStyle.button2,
                    ),
                    onPressed: () {
                      _setHistory;
                      Navigator.of(context).pop();
                    }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                'Privacidade',
                allPrivacy,
              ),
              SelectComponent(
                'Habilitar comentários',
                allComment,
              ),
              RadioComponent('Categorias', allCategories),
            ],
          ),
        ),
      ),
    );
  }
}
