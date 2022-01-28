// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/components/btn_confirm_component.dart';
import 'package:universe_history_app/components/btn_link_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nickNameController = TextEditingController();

  bool _notification = true;
  bool _login = true;

  @override
  void initState() {
    _nickNameController.text = 'charles.sbs';
    super.initState();
  }

  void _toggleNotification(bool value) {
    setState(() {
      _notification = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent('Configurações'),
              if (!_login)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleResumeComponent('Conta',
                        'Você deve ter uma conta Apple ou Google para usar os serviços do History.'),
                    const Text(
                      'Entrar ou criar conta',
                      style: uiTextStyle.text1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: const Text(
                        'entrar',
                        style: uiTextStyle.button1,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/login"),
                      style: uiButton.button1,
                    ),
                  ],
                ),
              if (_login)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleResumeComponent('Conta',
                        'Mantenha seus dados atualizados e consulte seu conteúdo.'),
                    const BtnLinkComponent('Nome de usuário', '/account'),
                    const BtnLinkComponent('Minhas histórias', '/myHistory'),
                    const BtnLinkComponent('Meus comentário', '/myComment'),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Notificações',
                              style: uiTextStyle.text1,
                            ),
                            FlutterSwitch(
                              value: _notification,
                              activeText: "ligada",
                              inactiveText: "desligada",
                              width: 80,
                              height: 30,
                              valueFontSize: 12,
                              toggleSize: 20,
                              toggleColor: uiColor.third,
                              activeColor: uiColor.first,
                              inactiveColor: uiColor.comp_3,
                              borderRadius: 0,
                              showOnOff: true,
                              onToggle: (value) => _toggleNotification(value),
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () => _toggleNotification(!_notification),
                      ),
                    ),
                    const BtnLinkComponent('Bloqueados', '/blocked'),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              const DividerComponent(),
              const TitleResumeComponent('Informações',
                  'Sobre o History, perguntas, políticas e termos.'),
              // const BtnLinkComponent('Avaliação', '/questions'), TODO: adicionar feedback nas lojas de aplicativos.
              const BtnLinkComponent('Perguntas frequentes', '/questions'),
              const BtnLinkComponent('Termo de uso', '/terms'),
              const BtnLinkComponent('Política de privacidade', '/privacy'),
              const BtnLinkComponent('Sobre', '/about'),
              const SizedBox(
                height: 20,
              ),

              if (_login)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DividerComponent(),
                    TitleResumeComponent('Finalizar',
                        'Sair temporariamente ou deletar a conta History.'),
                    BtnConfirmComponent(
                      title: 'Sair',
                      btnPrimaryLabel: 'Cancelar',
                      btnSecondaryLabel: 'Sair',
                      link: '/home',
                      text:
                          'Dar uma tempo e mandar meu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta Apple ou Google cadastrada.',
                    ),
                    BtnLinkComponent('Deletar conta', '/delete-account'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// TextField(
//   controller: _nickNameController,
//   minLines: 1,
//   maxLines: 1,
//   style: uiTextStyle.header3,
//   decoration: InputDecoration(
//     counterText: "",
//     hintText: _nickNameController.text,
//     hintStyle: uiTextStyle.header3,
//     enabledBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(color: uiColor.comp_1),
//     ),
//     focusedBorder: const UnderlineInputBorder(
//       borderSide: BorderSide(color: uiColor.comp_1),
//     ),
//   ),
// ),
