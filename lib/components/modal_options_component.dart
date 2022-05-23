import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/btn_confirm_component.dart';
import 'package:universe_history_app/components/button_option_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class ModalOptionsComponent extends StatefulWidget {
  const ModalOptionsComponent(
    String id,
    String type,
    String idUser,
    String userNickName,
    String text,
    bool isDelete,
  )   : _id = id,
        _type = type,
        _idUser = idUser,
        _userNickName = userNickName,
        _text = text,
        _isDelete = isDelete;

  final String _id;
  final String _type;
  final String _idUser;
  final String _userNickName;
  final String _text;
  final bool _isDelete;

  @override
  _ModalOptionsComponentState createState() => _ModalOptionsComponentState();
}

class _ModalOptionsComponentState extends State<ModalOptionsComponent> {
  final ToastComponent toast = ToastComponent();
  final Api api = Api();
  final Uuid uuid = const Uuid();

  late Map<String, dynamic> _form;

  bool _canCopy() {
    return !widget._isDelete ? true : false;
  }

  bool _canEdit() {
    return (currentUser.value.first.id == widget._idUser) && !widget._isDelete
        ? true
        : false;
  }

  bool _canDelete() {
    if (widget._isDelete) return false;
    if (currentUser.value.first.id == widget._idUser) return true;
    if (currentUser.value.first.id == currentHistory.value.first.userId) {
      return true;
    }
    return false;
  }

  bool _canBlock() {
    return currentUser.value.first.id == widget._idUser ? false : true;
  }

  void _copy(String _text) {
    Clipboard.setData(ClipboardData(text: _text));
    toast.toast(context, ToastEnum.SUCCESS, 'Texto copiado!');
    Navigator.of(context).pop();
  }

  void _edit(BuildContext context) {
    widget._type == 'comentário'
        ? _showModal(context)
        : Navigator.of(context).pushNamed('/create');
  }

  void _delete(bool value) {
    widget._type == 'comentário'
        ? _deleteComment(value)
        : _deleteHistory(value);
  }

  void _deleteComment(bool value) async {
    if (value) {
      api
          .deleteComment()
          .then((result) => {
                ActivityUtil(
                  ActivitiesEnum.DELETE_COMMENT,
                  widget._text,
                  widget._userNickName,
                ),
                toast.toast(context, ToastEnum.SUCCESS, 'Comentário deletado!'),
                Navigator.of(context).pop(),
              })
          .catchError((error) => debugPrint('ERROR:' + error.toString()));
    }

    Navigator.of(context).pop();
  }

  void _deleteHistory(bool value) async {
    if (value) {
      api
          .deleteHistory(currentHistory.value.first.id)
          .then((result) => {
                ActivityUtil(
                  ActivitiesEnum.DELETE_HISTORY,
                  widget._text,
                  widget._userNickName,
                ),
                toast.toast(context, ToastEnum.SUCCESS, 'História deletada!'),
                Navigator.of(context).pop(),
              })
          .catchError((error) => debugPrint('ERROR:' + error.toString()));
    }
    Navigator.of(context).pop();
  }

  void _setBlock(bool value) {
    if (value) {
      _form = {
        'id': uuid.v4(),
        'blockerId': currentUser.value.first.id,
        'blockedId': widget._idUser,
        'blockedNickName': widget._userNickName,
        'date': DateTime.now().toString(),
      };

      api
          .setBlock(_form)
          .then((result) => {
                toast.toast(context, ToastEnum.SUCCESS, 'Usuário bloqueado!'),
                Navigator.of(context).pop(),
              })
          .catchError((error) => debugPrint('ERROR:' + error.toString()));
    }
    Navigator.of(context).pop();
  }

  void _setDenounce(bool value) {
    value ? Navigator.of(context).pushNamed('/denounce') : null;
  }

  void _showModal(BuildContext context) {
    showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => ModalInputCommmentComponent(id: widget._id));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  if (_canCopy())
                    ButtonOptionComponent(
                      label: 'Copiar ' + widget._type,
                      icon: uiSvg.copy,
                      callback: (value) => _copy(widget._text),
                    ),
                  if (_canEdit())
                    ButtonOptionComponent(
                      label: 'Editar ' + widget._type,
                      icon: uiSvg.edit,
                      callback: (value) => _edit(context),
                    ),
                  if (_canDelete())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: BtnConfirmComponent(
                        title: 'Excluir ' + widget._type,
                        icon: uiSvg.delete,
                        btnPrimaryLabel: 'Cancelar',
                        btnSecondaryLabel: 'Excluir',
                        text:
                            'Tem certeza de que deseja excluir esse comentário definitivamente?',
                        callback: (value) => _delete(value),
                      ),
                    ),
                  if (_canBlock())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: BtnConfirmComponent(
                        title: 'Bloquear ' + widget._userNickName,
                        icon: uiSvg.block,
                        btnPrimaryLabel: 'Cancelar',
                        btnSecondaryLabel: 'Bloquear',
                        text:
                            'Tem certeza de que deseja bloquear este usuário?',
                        callback: (value) => _setBlock(value),
                      ),
                    ),
                  if (_canBlock())
                    ButtonOptionComponent(
                      label: 'Denunciar ' + widget._userNickName,
                      icon: uiSvg.delate,
                      callback: (value) => _setDenounce(value),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum ModalOption { COMMENT, HISTORY }
