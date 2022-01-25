import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/components/btn_link_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
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
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent('Configurações'),
              const TitleResumeComponent('Conta',
                  'Mantenha seus dados atualizados e consulte seu conteúdo.'),
              const BtnLinkComponent('Nome de usuário', '/account'),

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
                        value: notification,
                        activeText: "Ligada",
                        inactiveText: "Desligada",
                        width: 80,
                        height: 30,
                        valueFontSize: 12,
                        toggleSize: 20,
                        toggleColor: uiColor.third,
                        activeColor: uiColor.first,
                        inactiveColor: uiColor.comp_3,
                        showOnOff: true,
                        onToggle: (value) => _toggleNotification(value),
                      ),
                    ],
                  ),
                  onPressed: () => _toggleNotification(!notification),
                ),
              ),
              const BtnLinkComponent('Bloqueados', '/blocked'),
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
              const DividerComponent(),
              const TitleResumeComponent('Finalizar',
                  'Sair temporariamente ou deletar a conta History.'),
              const BtnLinkComponent('Sair', '/blocked'),
              const BtnLinkComponent('Deletar conta', '/delete-account'),
              // const BtnConfirmComponent(
              //   'Deletar conta',
              //   'Você não poderá mais acessar suas hitórias e comentários. Tem certeza que deseja deletar sua conta definitivamente?',
              //   '/home',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
