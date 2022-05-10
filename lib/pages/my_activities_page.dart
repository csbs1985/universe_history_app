// ignore_for_file: unused_element, empty_statements, dead_code, unrelated_type_equality_checks, curly_braces_in_flow_control_structures, constant_identifier_names, unused_label

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/item_login_component.dart';
import 'package:universe_history_app/components/item_logout_component.dart';
import 'package:universe_history_app/components/item_new_account_component.dart';
import 'package:universe_history_app/components/item_new_comment_component.dart';
import 'package:universe_history_app/components/item_new_history_component.dart';
import 'package:universe_history_app/components/item_new_nickName_component.dart';
import 'package:universe_history_app/components/item_notification_component.dart';
import 'package:universe_history_app/components/item_temporarily_desabled_component.dart';
import 'package:universe_history_app/components/item_up_block_component.dart';
import 'package:universe_history_app/components/item_up_nickName_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/activities_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/utils/activity_util.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final Api api = Api();

  final ScrollController _scrollController = ScrollController();

  static const PAGE_SIZE = 10;

  bool _allFetched = false;
  bool _isLoading = false;
  final List<ActivitiesModel> _data = [];
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _getContent();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getContent();
      }
    });
  }

  Future<void> _getContent() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    Query _query = FirebaseFirestore.instance
        .collection('activities')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .orderBy('date', descending: true);

    _query = _lastDocument != null
        ? _query = _query.startAfterDocument(_lastDocument!).limit(PAGE_SIZE)
        : _query.limit(PAGE_SIZE);

    final List<ActivitiesModel> pagedData = await _query.get().then((value) {
      _lastDocument = value.docs.isNotEmpty ? value.docs.last : null;

      return value.docs
          .map((e) => ActivitiesModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });

    setState(() {
      _data.addAll(pagedData);
      if (pagedData.length < PAGE_SIZE) _allFetched = true;
      _isLoading = false;
    });
  }

  String _getResume() {
    var qtyHistory = currentUser.value.first.qtyHistory <= 0
        ? 'Nenhuma história'
        : '${currentUser.value.first.qtyHistory} histórias';
    var qtyComment = currentUser.value.first.qtyComment <= 0
        ? 'Nenhum comentário'
        : '${currentUser.value.first.qtyComment} comentários';
    return qtyHistory + ' · ' + qtyComment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TitleResumeComponent('Suas atividades', _getResume())),
            NotificationListener<ScrollEndNotification>(
              child: _data.isEmpty
                  ? _noResult()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _data.length + (_allFetched ? 0 : 1),
                      itemBuilder: (BuildContext context, index) {
                        if (index == _data.length) {
                          return const SkeletonActivityComponent();
                        } else {
                          final item = _data[index];
                          key:
                          ValueKey(item);
                          ActivitiesEnum content = ActivitiesEnum.values
                              .firstWhere((e) =>
                                  e.name.toString() == _data[index].type);

                          switch (content) {
                            case ActivitiesEnum.NEW_HISTORY:
                              return ItemNewHistory(history: item);
                            case ActivitiesEnum.LOGIN:
                              return ItemLogin(history: item);
                            case ActivitiesEnum.LOGOUT:
                              return ItemLogout(history: item);
                            case ActivitiesEnum.UP_NICKNAME:
                              return ItemUpNickName(history: item);
                            case ActivitiesEnum.NEW_COMMENT:
                              return ItemNewComment(history: item);
                            case ActivitiesEnum.NEW_NICKNAME:
                              return ItemNewNickName(history: item);
                            case ActivitiesEnum.UP_NOTIFICATION:
                              return ItemNotificationComponent(history: item);
                            case ActivitiesEnum.BLOCK_USER:
                            case ActivitiesEnum.UNBLOCK_USER:
                              return ItemUpBlockComponent(history: item);
                            case ActivitiesEnum.TEMPORARILY_DISABLED:
                              return ItemTemporarilyDesabledComponent(
                                  history: item);
                            case ActivitiesEnum.NEW_ACCOUNT:
                            default:
                              return ItemNewAccountComponent(history: item);
                          }
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResult() {
    return const NoResultComponent(
        text: 'Não há atividades ou não foi possível encontrá-las.');
  }
}
