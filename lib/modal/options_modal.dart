import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/btn_confirm_component.dart';
import 'package:universe_history_app/components/button_option_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/firestore/blockeds_firestore.dart';
import 'package:universe_history_app/firestore/comments_firestore.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/modal/create_history_modal.dart';
import 'package:universe_history_app/modal/input_comment_modal.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class OptionsModal extends StatefulWidget {
  const OptionsModal(
    String id,
    String type,
    String userId,
    String userName,
    String text,
    bool isDelete,
  )   : _id = id,
        _type = type,
        _idUser = userId,
        _userName = userName,
        _text = text,
        _isDelete = isDelete;

  final String _id;
  final String _type;
  final String _idUser;
  final String _userName;
  final String _text;
  final bool _isDelete;

  @override
  _OptionsModalState createState() => _OptionsModalState();
}

class _OptionsModalState extends State<OptionsModal> {
  final BlockedsFirestore blockedsFirestore = BlockedsFirestore();
  final CommentsFirestore commentsFirestore = CommentsFirestore();
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final ToastComponent toast = ToastComponent();
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
    toast.toast(context, ToastEnum.SUCCESS.name, 'Texto copiado!');
    Navigator.of(context).pop();
  }

  void _edit(BuildContext context) {
    widget._type == 'comentário'
        ? _showModal(context)
        : showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            barrierColor: Colors.black87,
            duration: const Duration(milliseconds: 300),
            builder: (context) => const CreateHistoryModal(),
          );
  }

  void _delete(bool value) {
    widget._type == 'comentário'
        ? _deleteComment(value)
        : _deleteHistory(value);
  }

  void _deleteComment(bool value) async {
    if (value) {
      try {
        await commentsFirestore.deleteComment();
        ActivityUtil(
          ActivitiesEnum.DELETE_COMMENT.name,
          widget._text,
          widget._userName,
        );
        toast.toast(context, ToastEnum.SUCCESS.name, 'Comentário deletado!');
        Navigator.of(context).pop();
      } on AuthException catch (error) {
        debugPrint('ERROR => deleteComment: ' + error.toString());
      }
    }

    Navigator.of(context).pop();
  }

  void _deleteHistory(bool value) async {
    if (value) {
      historiesFirestore
          .deleteHistory(currentHistory.value.first.id)
          .then((result) => {
                ActivityUtil(
                  ActivitiesEnum.DELETE_HISTORY.name,
                  widget._text,
                  widget._userName,
                ),
                toast.toast(
                    context, ToastEnum.SUCCESS.name, 'História deletada!'),
                Navigator.of(context).pop(),
              })
          .catchError((error) => debugPrint('ERROR:' + error.toString()));
    }
    Navigator.of(context).pop();
  }

  void _setBlock(bool value) async {
    if (value) {
      _form = {
        'id': uuid.v4(),
        'blockerId': currentUser.value.first.id,
        'userId': widget._idUser,
        'userName': widget._userName,
        'date': DateTime.now().toString(),
      };

      try {
        await blockedsFirestore.postBlock(_form);
        _getAllHistoryUser();
        toast.toast(context, ToastEnum.SUCCESS.name, 'Usuário bloqueado!');
        Navigator.of(context).pop();
      } on AuthException catch (error) {
        debugPrint('ERROR => postBlock: ' + error.toString());
      }
    }
    Navigator.of(context).pop();
  }

  void _getAllHistoryUser() async {
    await historiesFirestore.getAllHistoryUser().then((result) async => {
          if (result.size > 0)
            {
              for (var item in result.docs)
                {
                  currentHistory.value.first.qtyComment - result.size,
                  await historiesFirestore
                      .pathQtyCommentHistory(currentHistory.value.first),
                  for (var item in result.docs)
                    await commentsFirestore.deleteCommentBlocked(item['id']),
                }
            }
        });
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
        builder: (context) => InputCommmentModal(id: widget._id));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: UiColor.comp_1,
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
                      icon: UiSvg.copy,
                      callback: (value) => _copy(widget._text),
                    ),
                  if (_canEdit())
                    ButtonOptionComponent(
                      label: 'Editar ' + widget._type,
                      icon: UiSvg.edit,
                      callback: (value) => _edit(context),
                    ),
                  if (_canDelete())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: BtnConfirmComponent(
                        title: 'Excluir ' + widget._type,
                        icon: UiSvg.delete,
                        btnPrimaryLabel: 'Cancelar',
                        btnSecondaryLabel: 'Excluir',
                        text: 'Tem certeza de que deseja excluir ' +
                            widget._type +
                            ' definitivamente?',
                        callback: (value) => _delete(value),
                      ),
                    ),
                  if (_canBlock())
                    ButtonOptionComponent(
                      label: 'Denunciar ' + widget._userName,
                      icon: UiSvg.delate,
                      callback: (value) => _setDenounce(value),
                    ),
                  if (_canBlock())
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: BtnConfirmComponent(
                        title: 'Bloquear ' + widget._userName,
                        icon: UiSvg.block,
                        btnPrimaryLabel: 'Cancelar',
                        btnSecondaryLabel: 'Bloquear',
                        text:
                            'Tem certeza de que deseja bloquear este usuário?',
                        callback: (value) => _setBlock(value),
                      ),
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
