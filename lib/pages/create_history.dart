// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/checkbox_component.dart';
import 'package:universe_history_app/components/radio_component.dart';
import 'package:universe_history_app/shared/models/category.dart';
import 'package:universe_history_app/shared/models/checkbox.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_svgs.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:flutter/services.dart';

class CreateHistory extends StatefulWidget {
  const CreateHistory({Key? key}) : super(key: key);

  @override
  _CreateHistoryState createState() => _CreateHistoryState();
}

class _CreateHistoryState extends State<CreateHistory> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<Category> allCategories = Category.allCategories;
  List<Category> categoriesSelected = [];
  List<CheckboxModel> allPrivacy = CheckboxModel.allPrivacy;
  List<CheckboxModel> allComment = CheckboxModel.allComment;

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
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'publicar',
                style: uiTextStyle.button2,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                maxLength: 60,
                style: uiTextStyle.header1,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Título com até 60 caracteres',
                  hintStyle: uiTextStyle.header1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.second),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.second),
                  ),
                ),
              ),
              const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 20,
                style: uiTextStyle.text1,
                decoration: InputDecoration(
                  hintText: 'Sua história',
                  hintStyle: uiTextStyle.text1,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.second),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: uiColor.second),
                  ),
                ),
              ),
              CheckboxCuston(
                'Privacidade',
                allPrivacy,
              ),
              CheckboxCuston(
                'Habilitar comentários',
                allComment,
              ),
              RadioCuston('Categorias', allCategories),
            ],
          ),
        ),
      ),
    );
  }
}
