import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_blocked_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/blocked_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({Key? key}) : super(key: key);

  @override
  _BlockedUsersPageState createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final Api api = Api();
  final ToastComponent toast = ToastComponent();

  String _numBlocked() {
    if (currentBlockedQty.value == 1) return '1 usuário bloqueado';
    if (currentBlockedQty.value > 1) {
      return '${currentBlockedQty.value} usuários bloqueados';
    }
    return 'Desbloquear usuário';
  }

  void _unlockUser(QueryDocumentSnapshot<dynamic> blocked) {
    api
        .deleteBlock(blocked['id'])
        .then((result) => {
              currentBlockedQty.value--,
              toast.toast(context, ToastEnum.SUCCESS.name,
                  '${blocked['blockedNickName']} desbloqueado!')
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
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
              ValueListenableBuilder(
                  valueListenable: currentBlockedQty,
                  builder: (context, value, __) {
                    return TitleResumeComponent(_numBlocked(),
                        'Quando você bloqueia uma pessoa, este usuário não poderá mais ler suas histórias e comentários e comentar o que você escreve.');
                  }),
              StreamBuilder<QuerySnapshot>(
                stream: api.getAllBlock(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      currentBlockedQty.value = snapshot.data!.size;
                    });
                  }
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
              )
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
    return documents.isNotEmpty
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
                          Text(documents[index]['blockedNickName'],
                              style: UiTextStyle.text1),
                          Text(editDateUtil(documents[index]['date']),
                              style: UiTextStyle.text2)
                        ]),
                    Button3dComponent(
                      label: 'desbloquear',
                      size: ButtonSizeEnum.MEDIUM,
                      style: ButtonStyleEnum.PRIMARY,
                      callback: (value) => _unlockUser(
                        documents[index],
                      ),
                    )
                  ],
                ),
              );
            },
          )
        : _noResult();
  }
}
