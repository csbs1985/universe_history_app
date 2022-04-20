// ignore_for_file: camel_case_types, prefer_is_empty, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class blockedUsersPage extends StatefulWidget {
  const blockedUsersPage({Key? key}) : super(key: key);

  @override
  _blockedUsersPageState createState() => _blockedUsersPageState();
}

class _blockedUsersPageState extends State<blockedUsersPage> {
  final Api api = Api();

  String numBlocked = 'Pessoas bloqueadas';

  String _getNumBlocked(num num) {
    return num > 0
        ? '${num.toString()} pessoas bloqueadas'
        : 'Pessoas bloqueadas';
  }

  void _unlockUser(String blocked) {
    setState(() {
      showToast(
        '${blocked} desbloqueado(a).',
        context: context,
        position: StyledToastPosition.bottom,
        textStyle: uiTextStyle.text1,
        backgroundColor: uiColor.comp_3,
        animation: StyledToastAnimation.slideToBottomFade,
        reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      );
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
              TitleResumeComponent(
                numBlocked,
                'Quando você bloqueia uma pessoa, este usuário não poderá mais ler suas histórias e comentários e comentar o que você escreve.',
              ),
              StreamBuilder<QuerySnapshot>(
                stream: api.getAllBlock(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _noResult();
                    case ConnectionState.waiting:
                      return const SkeletonActivityComponent();
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
    numBlocked = _getNumBlocked(documents.length);
    return documents.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(documents[index]['blockedNickName'],
                            style: uiTextStyle.text1),
                        Text(documents[index]['date'],
                            style: uiTextStyle.text2),
                      ],
                    ),
                    Button3dComponent(
                      label: 'desbloquear',
                      size: ButtonSizeEnum.MEDIUM,
                      style: ButtonStyleEnum.PRIMARY,
                      callback: (value) =>
                          _unlockUser(documents[index]['blockerId']),
                    )
                  ],
                ),
              );
            },
          )
        : _noResult();
  }

  Widget _noResult() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Nada para mostrar', style: uiTextStyle.header1),
          Text('Você não tem usuário bloqueados ainda.',
              style: uiTextStyle.text7),
        ],
      ),
    );
  }
}
