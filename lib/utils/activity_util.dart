// ignore_for_file: unused_local_variable, constant_identifier_names, prefer_const_declarations, non_constant_identifier_names

import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:uuid/uuid.dart';

ActivityUtil(ActivitiesEnum type, String content) async {
  final Uuid uuid = const Uuid();
  final Api api = Api();

  late Map<String, dynamic> activity;

  activity = {
    'id': uuid.v4(),
    'date': DateTime.now().toString(),
    'type': type.toString().split('.').last,
    'userId': currentUser.value.first.id,
    'content': content.trim(),
  };

  await api.setActivities(activity);
}

enum ActivitiesEnum {
  NEW_COMMENT,
  NEW_HISTORY,
  NEW_ACCOUNT,
  NEW_NICKNAME,
  UP_NICKNAME,
  UP_NOTIFICATION,
  LOGOUT,
  LOGIN
}
