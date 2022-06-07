import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/select_categories_component.dart';
import 'package:universe_history_app/components/select_toggle_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/category_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class CreateHistoryModal extends StatefulWidget {
  const CreateHistoryModal({Key? key}) : super(key: key);

  @override
  _CreateHistoryModalState createState() => _CreateHistoryModalState();
}

class _CreateHistoryModalState extends State<CreateHistoryModal> {
  final HistoryClass historyClass = HistoryClass();
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final Uuid uuid = const Uuid();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<CategoryModel> allCategories = CategoryModel.allCategories;
  List<CategoryModel> categoriesSelected = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  bool isEdit = false;
  bool _isSigned = true;
  bool _isComment = true;
  bool _btnPublish = false;
  bool _isAuthorized = false;

  List<String> _categories = [];

  late Map<String, dynamic> history;
  late Map<String, dynamic> activity;

  @override
  void initState() {
    if (currentHistory.value.isNotEmpty) {
      isEdit = true;
      _btnPublish = true;
      titleController.text = currentHistory.value.first.title;
      textController.text = currentHistory.value.first.text;
      _isSigned = currentHistory.value.first.isSigned;
      _isComment = currentHistory.value.first.isComment;
      _isAuthorized = currentHistory.value.first.isAuthorized;
      _categories = currentHistory.value.first.categories;
    }

    super.initState();
  }

  void _setPrivacy() {
    setState(() {
      _isSigned = !_isSigned;
      _canPublish();
    });
  }

  void _setComment() {
    setState(() {
      _isComment = !_isComment;
      _canPublish();
    });
  }

  void _setAuthorized() {
    setState(() {
      _isAuthorized = !_isAuthorized;
      _canPublish();
    });
  }

  void _setCategories(List<String> value) {
    setState(() {
      _categories = value;
      _canPublish();
    });
  }

  void _canPublish() {
    setState(() {
      _btnPublish = (textController.text.isNotEmpty && _categories.isNotEmpty)
          ? true
          : false;
    });
  }

  Future<void> _publishHistory(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    currentDialog.value = 'Criando história...';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    setState(() {
      if (currentHistory.value.isNotEmpty) {
        historyClass.add({
          'id': currentHistory.value.first.id,
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': currentHistory.value.first.date,
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': true,
          'isAuthorized': _isAuthorized,
          'qtyComment': currentHistory.value.first.qtyComment,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userName': currentUser.value.first.name,
          'bookmarks': currentHistory.value.first.bookmarks,
        });
      } else {
        historyClass.add({
          'id': uuid.v4(),
          'title': titleController.text.trim(),
          'text': textController.text.trim(),
          'date': DateTime.now().toString(),
          'isComment': _isComment,
          'isSigned': _isSigned,
          'isEdit': false,
          'isAuthorized': _isAuthorized,
          'qtyComment': 0,
          'categories': _categories,
          'userId': currentUser.value.first.id,
          'userName': currentUser.value.first.name,
          'bookmarks': [],
        });
      }
    });

    try {
      await db.postNewHistory(currentHistory.value.first);
      _setUpQtyHistoryUser();
    } on AuthException catch (error) {
      debugPrint('ERROR => postNewHistory:' + error.toString());
      toast.toast(context, ToastEnum.WARNING.name,
          'Erro ao publicar história, tente novamente mais tarde.');
    }
  }

  Future<void> _setUpQtyHistoryUser() async {
    if (!isEdit) currentUser.value.first.qtyHistory++;

    await db
        .pathQtyHistoryUser(currentUser.value.first.id)
        .then((value) => _success())
        .catchError((error) =>
            debugPrint('ERROR => _setUpQtyHistoryUser:' + error.toString()));
  }

  void _success() {
    ActivityUtil(
      isEdit ? ActivitiesEnum.NEW_HISTORY.name : ActivitiesEnum.UP_HISTORY.name,
      titleController.text,
      currentHistory.value.first.id,
    );
    if (currentHistory.value.isNotEmpty) Navigator.of(context).pop();
    toast.toast(context, ToastEnum.SUCCESS.name,
        isEdit ? 'Sua história foi alterada.' : 'Sua história foi publicada.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppbarComponent(
        btnBack: true,
        btnPublish: _btnPublish,
        callback: (value) => _publishHistory(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 2,
                maxLength: 60,
                style: UiTextStyle.header1,
                onChanged: (value) => _canPublish(),
                decoration: const InputDecoration(
                  counterText: "",
                  hintText: 'Título',
                  hintStyle: UiTextStyle.header2,
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                controller: textController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                style: UiTextStyle.text1,
                onChanged: (value) => _canPublish(),
                decoration: const InputDecoration(
                  hintText: 'História',
                  hintStyle: UiTextStyle.text1,
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                title: 'Assinatura',
                resume:
                    'Ligado para assinar como ${currentUser.value.first.name} ou desligado para anônimo.',
                value: _isSigned,
                callback: (value) => _setPrivacy(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                title: 'Comentários',
                resume:
                    'Ligado para habilitar ou desligado para desabilitar os comentários na história. ',
                value: _isComment,
                callback: (value) => _setComment(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectToggleComponent(
                title: 'Autorizado',
                resume:
                    'Ligado para marcar história como de terceiro com autorização para publicar. ',
                value: _isAuthorized,
                callback: (value) => _setAuthorized(),
              ),
            ),
            SelectCategoriesComponent(
              title: 'Assunto',
              resume: 'Selecione ao menos uma categoria/tema.',
              content: allCategories,
              selected: currentHistory.value.isNotEmpty
                  ? currentHistory.value.first.categories
                  : [],
              callback: (value) => _setCategories(value),
            )
          ],
        ),
      ),
    );
  }
}
