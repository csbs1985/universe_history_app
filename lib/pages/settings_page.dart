import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_image.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nickNameController = TextEditingController();

  bool notification = true;

  @override
  void initState() {
    _nickNameController.text = 'charles.sbs';
    super.initState();
  }

  void _toggleNotification(bool value) {
    setState(() {
      notification = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Text(
                'Configurações',
                style: uiTextStyle.header1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome de usuário',
                      style: uiTextStyle.text1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    controller: _nickNameController,
                    minLines: 1,
                    maxLines: 1,
                    style: uiTextStyle.header2,
                    decoration: const InputDecoration(
                      counterText: "",
                      hintText: 'Título com até 60 caracteres',
                      hintStyle: uiTextStyle.header2,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: uiColor.second),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: uiColor.second),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Minhas histórias',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Meus comentários',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notificações',
                      style: uiTextStyle.text1,
                    ),
                    FlutterSwitch(
                      value: notification,
                      activeText: "ligada",
                      inactiveText: "desligada",
                      width: 80,
                      height: 30,
                      valueFontSize: 12,
                      toggleSize: 20,
                      toggleColor: uiColor.third,
                      activeColor: uiColor.first,
                      inactiveColor: uiColor.comp_1,
                      showOnOff: true,
                      onToggle: (value) => _toggleNotification(value),
                    ),
                  ],
                ),
                onPressed: () => _toggleNotification(!notification),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Perguntas frequentes',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bloqueados',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Termo de uso',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed("/terms"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Política de privacidade',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () => Navigator.of(context).pushNamed("/privacy"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Deletar conta',
                    style: uiTextStyle.text1,
                  ),
                ),
                onPressed: () => _showAlertDelete(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                    child: Image.asset(
                      uiImage.logo,
                    ),
                  ),
                  const Text(
                    'v1.0.0(c)',
                    style: uiTextStyle.text2,
                  ),
                  const Text(
                    '17 de janeiro de 2022 às 10:20',
                    style: uiTextStyle.text2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: TextButton(
                      child: const Text(
                        'Sair',
                        style: uiTextStyle.button1,
                      ),
                      style: uiButton.button1,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Future> _showAlertDelete(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      var child;
      return AlertDialog(
        backgroundColor: uiColor.second,
        title: const Text(
          'Deletar conta',
          style: uiTextStyle.text5,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: const [
              Text(
                'Você não poderá mais acessar suas hitórias e comentários. Tem certeza que deseja deletar sua conta definitivamente?',
                style: uiTextStyle.text1,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: const Text(
                    'Deletar',
                    style: uiTextStyle.text3,
                  ),
                ),
                TextButton(
                  style: uiButton.button1,
                  child: const Text(
                    'Cancelar',
                    style: uiTextStyle.text1,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
