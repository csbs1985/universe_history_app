// ignore_for_file: camel_case_types, prefer_is_empty, unnecessary_brace_in_string_interps, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_blocked_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class blockedUsersPage extends StatefulWidget {
  const blockedUsersPage({Key? key}) : super(key: key);

  @override
  _blockedUsersPageState createState() => _blockedUsersPageState();
}

class _blockedUsersPageState extends State<blockedUsersPage> {
  final Api api = Api();
  final ToastComponent toast = ToastComponent();

  int qtyBlocked = 0;
  String labelBlocked = 'Desbloquear usuário';

  void _numBlocked(int snapshot) {
    setState(() {
      qtyBlocked = snapshot;
      if (qtyBlocked == 1) labelBlocked = '1 usuário bloqueado';
      if (qtyBlocked > 1) labelBlocked = '${qtyBlocked} usuários bloqueados';
    });
  }

  void _unlockUser(QueryDocumentSnapshot<dynamic> blocked) {
    api
        .deleteBlock(blocked['id'])
        .then((result) => {
              _numBlocked(qtyBlocked--),
              toast.toast(context, ToastEnum.SUCCESS,
                  '${blocked['blockedNickName']} desbloqueado!'),
            })
        .catchError((error) => print('ERROR:' + error.toString()));
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
                labelBlocked,
                'Quando você bloqueia uma pessoa, este usuário não poderá mais ler suas histórias e comentários e comentar o que você escreve.',
              ),
              StreamBuilder<QuerySnapshot>(
                stream: api.getAllBlock(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) _numBlocked(snapshot.data!.size);
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _noResult();
                    case ConnectionState.waiting:
                      return const SkeletonBlockedComponent();
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

  Widget _noResult() {
    return const NoResultComponent(text: 'Você não tem usuários bloqueados.');
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: (MediaQuery.of(context).size.width - 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          documents[index]['blockedNickName'],
                          style: uiTextStyle.text1,
                        ),
                        Text(
                          editDateUtil(DateTime.parse(documents[index]['date'])
                              .millisecondsSinceEpoch),
                          style: uiTextStyle.text2,
                        ),
                      ],
                    ),
                    Button3dComponent(
                      label: 'desbloquear',
                      size: ButtonSizeEnum.MEDIUM,
                      style: ButtonStyleEnum.PRIMARY,
                      callback: (value) => _unlockUser(documents[index]),
                    )
                  ],
                ),
              );
            },
          )
        : _noResult();
  }
}
