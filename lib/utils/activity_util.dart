// ignore_for_file: non_constant_identifier_names

import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:uuid/uuid.dart';

ActivityUtil(ActivitiesEnum type, String content, String elementId) async {
  Uuid uuid = const Uuid();
  final Api api = Api();

  late Map<String, dynamic> activity;

  activity = {
    'id': uuid.v4(),
    'date': DateTime.now().toString(),
    'type': type.toString().split('.').last,
    'userId': currentUser.value.first.id,
    'content': content.trim(),
    'elementId': elementId,
  };

  await api.setActivities(activity);
}

enum ActivitiesEnum {
  BLOCK_USER,
  DELETE_COMMENT,
  DELETE_HISTORY,
  DENOUNCE,
  LOGIN,
  LOGOUT,
  NEW_ACCOUNT,
  NEW_COMMENT,
  NEW_HISTORY,
  NEW_NICKNAME,
  TEMPORARILY_DISABLED,
  UP_COMMENT,
  UP_HISTORY,
  UP_NICKNAME,
  UP_NOTIFICATION,
  UNBLOCK_USER,
}
