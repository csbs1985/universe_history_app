import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_login_logout_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_account_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_comment_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_history_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_new_nickName_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_notification_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_temporarily_desabled_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_block_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_history_component.dart';
import 'package:universe_history_app/pages/activiti/components/item_up_nickName_component.dart';
import 'package:universe_history_app/components/no_history_component.dart';
import 'package:universe_history_app/components/resume_component.dart';
import 'package:universe_history_app/components/skeleton_activity_componen.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/activities_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

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

  String _qtyHistory = 'henhuma história';
  String _qtyComment = 'henhum comentário';

  final List<ActivitiesModel> _data = [];

  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _getContent();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_allFetched) {
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
        ? _query.startAfterDocument(_lastDocument!).limit(PAGE_SIZE)
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

  _getResume() {
    api
        .getUser(currentUser.value.first.email)
        .then((result) => {
              if (result.docs.first['qtyHistory'] == 1)
                _qtyHistory = '1 história',
              if (result.docs.first['qtyHistory'] > 1)
                _qtyHistory = '${result.docs.first['qtyHistory']} histórias',
              if (result.docs.first['qtyComment'] == 1)
                _qtyComment = '1 comentário',
              if (result.docs.first['qtyComment'] > 1)
                _qtyComment = '${result.docs.first['qtyComment']} comentários',
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));

    return _qtyHistory + ' · ' + _qtyComment;
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
              child: TitleResumeComponent(
                'Suas atividades',
                _getResume(),
              ),
            ),
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
                          ActivitiesEnum content = ActivitiesEnum.values
                              .firstWhere((e) =>
                                  e.name.toString() == _data[index].type);

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (content == ActivitiesEnum.UP_HISTORY)
                                  ItemUpHistory(history: item),
                                if (content == ActivitiesEnum.NEW_HISTORY)
                                  ItemNewHistory(history: item),
                                if (content == ActivitiesEnum.LOGIN ||
                                    content == ActivitiesEnum.LOGOUT)
                                  ItemLoginLogout(history: item),
                                if (content == ActivitiesEnum.UP_NICKNAME)
                                  ItemUpNickName(history: item),
                                if (content == ActivitiesEnum.NEW_COMMENT)
                                  ItemNewComment(history: item),
                                if (content == ActivitiesEnum.NEW_NICKNAME)
                                  ItemNewNickName(history: item),
                                if (content == ActivitiesEnum.UP_NOTIFICATION)
                                  ItemNotificationComponent(history: item),
                                if (content == ActivitiesEnum.BLOCK_USER ||
                                    content == ActivitiesEnum.UNBLOCK_USER)
                                  ItemUpBlockComponent(history: item),
                                if (content ==
                                    ActivitiesEnum.TEMPORARILY_DISABLED)
                                  const ItemTemporarilyDesabledComponent(),
                                if (content == ActivitiesEnum.NEW_ACCOUNT)
                                  const ItemNewAccountComponent(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 2, 0, 0),
                                  child: ResumeComponent(
                                    resume: editDateUtil(item.date),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
            )
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
