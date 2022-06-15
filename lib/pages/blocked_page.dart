import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_blocked_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/firestore/blockeds_firestore.dart';
import 'package:universe_history_app/models/blocked_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

class BlockedPage extends StatefulWidget {
  const BlockedPage({Key? key}) : super(key: key);

  @override
  _BlockedPageState createState() => _BlockedPageState();
}

class _BlockedPageState extends State<BlockedPage> {
  final BlockedClass blockedClass = BlockedClass();
  final BlockedsFirestore blockedsFirestore = BlockedsFirestore();
  final ToastComponent toast = ToastComponent();

  Future<void> _unlockUser(QueryDocumentSnapshot<dynamic> blocked) async {
    try {
      await blockedsFirestore.deleteBlock(blocked['id']);

      currentBlockeds.value;

      toast.toast(
        context,
        ToastEnum.SUCCESS.name,
        '${blocked['userName']} desbloqueado!',
      );
    } on AuthException catch (error) {
      debugPrint('ERROR => deleteBlock: ' + error.toString());
    }
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
              const TitleResumeComponent(
                'Usuários bloqueados',
                'Quando você bloqueia uma pessoa, este usuário não poderá mais ler suas histórias e comentários e comentar o que você escreve.',
              ),
              StreamBuilder<QuerySnapshot>(
                stream: blockedsFirestore.getAllBlockeds(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _noResults();
                    case ConnectionState.waiting:
                      return const SkeletonBlockedComponent();
                    case ConnectionState.done:
                    default:
                      try {
                        return _list(context, snapshot);
                      } catch (error) {
                        return _noResults();
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

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    // Map<String, dynamic> blockeds = snapshot.data!.docs as Map<String, dynamic>;

    // blockedClass.add(blockeds);
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
                          Text(documents[index]['userName'],
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
        : _noResults();
  }

  Widget _noResults() {
    return const NoResultComponent(text: 'Você não tem usuários bloqueados.');
  }
}
