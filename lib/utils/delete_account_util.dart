// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_constructors, unused_field, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:uuid/uuid.dart';

class DeleteAccountUtil {
  final Api api = Api();
  final UserClass userClass = UserClass();
  final Uuid uuid = Uuid();

  late Map<String, dynamic> _form;

  Future<void> deleteAccount(BuildContext _context, _justifySelected) async {
    Navigator.of(_context).pop();

    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    if (_justifySelected == null) {
      _deletetAllHistory(_context);
    } else {
      _form = {
        'id': uuid.v4(),
        'date': DateTime.now().toString(),
        'idUser': currentUser.value.first.id,
        'nicknameUser': currentUser.value.first.nickname,
        'idJustify': _justifySelected!.id,
        'titleJustify': _justifySelected!.title
      };

      await api
          .setJustify(_form)
          .then((result) => _deletetAllHistory(_context))
          .catchError((error) => print('ERROR:' + error));
    }
  }

  Future<void> _deletetAllHistory(BuildContext _context) async {
    await api
        .getAllUserHistory()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.deleteHistory(item['id']),
              _upAllComment(_context)
            })
        .catchError((error) => print('ERROR:' + error));
  }

  Future<void> _upAllComment(BuildContext _context) async {
    await api
        .getAllUserComment()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.upStatusUserComment(item['id']),
              userClass.delete(_context)
            })
        .catchError((error) => print('ERROR:' + error));
  }
}
