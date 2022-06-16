import 'package:flutter/material.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/firestore/comments_firestore.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/firestore/justifications_Firestore.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DeleteAccountUtil {
  final CommentsFirestore commentsFirestore = CommentsFirestore();
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final JustificationsFirestore justificationsFirestore =
      JustificationsFirestore();
  final UserClass userClass = UserClass();
  Uuid uuid = const Uuid();

  late Map<String, dynamic> _form;

  Future<void> deleteAccount(BuildContext context, _justifySelected) async {
    Navigator.of(context).pop();

    currentDialog.value = 'Iniciando...';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    if (_justifySelected == null) {
      _deletetAllHistory(context);
    } else {
      _form = {
        'id': uuid.v4(),
        'date': DateTime.now().toString(),
        'userId': currentUser.value.first.id,
        'userName': currentUser.value.first.name,
        'idJustify': _justifySelected!.id,
        'titleJustify': _justifySelected!.title
      };

      await justificationsFirestore
          .postJustify(_form)
          .then(
            (result) => {
              currentDialog.value = 'Justificando...',
              _deletetAllHistory(context)
            },
          )
          .catchError((error) => debugPrint('ERROR:' + error));
    }
  }

  Future<void> _deletetAllHistory(BuildContext context) async {
    await historiesFirestore
        .getAllHistoryUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Deletando histórias...',
              for (var item in result.docs)
                await historiesFirestore.deleteHistory(item['id']),
              _upAllComment(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }

  _upAllComment(BuildContext context) async {
    await commentsFirestore
        .getAllCommentUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Atualizando comentários...',
              for (var item in result.docs)
                await commentsFirestore.upStatusUserComment(item['id']),
              userClass.delete(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }
}
