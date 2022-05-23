import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_confirm_component.dart';
import 'package:universe_history_app/components/btn_link_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/select_toggle_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserClass userClass = UserClass();
  final Api api = Api();

  @override
  void initState() {
    userNew.value = false;
    super.initState();
  }

  void _toggleNotification() {
    setState(() {
      currentUser.value.first.isNotification =
          !currentUser.value.first.isNotification;
      ActivityUtil(ActivitiesEnum.UP_NOTIFICATION,
          currentUser.value.first.isNotification.toString(), '');
      api.toggleNotification();
    });
  }

  Future<void> goLogout(bool value) async {
    value
        ? userClass.clean(
            context, UserStatus.INACTIVE.toString().split('.').last)
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (BuildContext context, value, __) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleComponent(title: 'Configurações'),
                  if (!currentUser.value.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleResumeComponent('Conta',
                            'Você deve ter uma conta Apple ou Google para usar os serviços do History.'),
                        const SizedBox(height: 10),
                        const Text(
                          'Entrar ou criar conta',
                          style: UiTextStyle.text1,
                        ),
                        const SizedBox(height: 10),
                        Button3dComponent(
                          label: 'Entrar',
                          size: ButtonSizeEnum.MEDIUM,
                          style: ButtonStyleEnum.PRIMARY,
                          callback: (value) =>
                              Navigator.of(context).pushNamed("/login"),
                        ),
                      ],
                    ),

                  if (currentUser.value.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleResumeComponent('Conta',
                            'Mantenha seus dados atualizados e consulte seu conteúdo.'),
                        const BtnLinkComponent('Nome de usuário', '/nickname'),
                        const BtnLinkComponent(
                            'Suas atividades', '/activities'),
                        SelectToggleComponent(
                          callback: (value) => _toggleNotification(),
                          title: 'Notificações',
                          resume: 'Habilitar ou desabilitar as notificações',
                          value: currentUser.value.first.isNotification,
                        ),
                        const BtnLinkComponent('Bloqueados', '/blocked'),
                      ],
                    ),
                  const SizedBox(height: 20),
                  const DividerComponent(),
                  const TitleResumeComponent('Informações',
                      'Sobre o History, perguntas, políticas e termos.'),
                  // const BtnLinkComponent('Avaliação', '/questions'), TODO: adicionar feedback nas lojas de aplicativos.
                  const BtnLinkComponent('Perguntas frequentes', '/questions'),
                  const BtnLinkComponent('Termo de uso', '/terms'),
                  const BtnLinkComponent('Política de privacidade', '/privacy'),
                  const BtnLinkComponent('Sobre', '/about'),
                  const SizedBox(height: 20),

                  if (currentUser.value.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DividerComponent(),
                        const TitleResumeComponent(
                          'Finalizar',
                          'Sair temporariamente ou deletar a conta History.',
                        ),
                        BtnConfirmComponent(
                          title: 'Sair',
                          btnPrimaryLabel: 'Cancelar',
                          btnSecondaryLabel: 'Sair',
                          link: '/home',
                          text:
                              'Dar uma tempo e mandar meu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta Apple ou Google cadastrada.',
                          callback: (value) => goLogout(value),
                        ),
                        const BtnLinkComponent(
                          'Deletar conta',
                          '/delete-account',
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
