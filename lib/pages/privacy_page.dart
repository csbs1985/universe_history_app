import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(UiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleComponent(title: 'Política de Privacidade'),
              Text(
                'O History utiliza segurança de ponta e criptografia ponta a ponta para fornecer conteúdo privado e seus'
                ' serviços para usuários em todo o mundo (“Serviços”). Suas mensagens são sempre criptografadas, de modo que nunca'
                ' podem ser compartilhadas ou visualizadas por ninguém, exceto você e os destinatários pretendidos'
                '\n\n'
                'Informações que você fornece'
                '\n\n'
                'Informação da conta'
                '\n\n'
                'Você registra seu email, nome e apelido ao criar uma conta do History. Os dados usados ​​para fornecer nossos Serviços'
                ' a você e a outros usuários do History. Opcionalmente, você pode alterar essas informações à sua conta. Essas'
                ' informações são criptografadas de ponta a ponta.'
                '\n\n'
                'Conteúdo'
                '\n\n'
                'O History não pode descriptografar ou acessar de outra forma o conteúdo de suas mensagens ou chamadas. O History'
                ' enfileira mensagens criptografadas de ponta a ponta em seus servidores para entrega a dispositivos que estão'
                ' temporariamente offline (por exemplo, um telefone cuja bateria acabou). Seu histórico de mensagens é armazenado'
                ' em seus próprios dispositivos.'
                '\n\n'
                'Informações técnicas adicionais são armazenadas em nossos servidores, incluindo tokens de autenticação gerados'
                ' aleatoriamente, chaves, tokens push e outros materiais necessários para estabelecer chamadas e transmitir'
                ' contepudo. O History limita essas informações técnicas adicionais ao mínimo necessário para operar os Serviços.'
                '\n\n'
                'Suporte ao usuário'
                '\n\n'
                'Se você entrar em contato com o Suporte ao Usuário do History, quaisquer dados pessoais que você compartilhar'
                ' conosco serão mantidos apenas para fins de pesquisa do problema e contato com você sobre o seu caso.'
                '\n\n'
                'Gerenciando suas informações'
                '\n\n'
                'Você pode gerenciar suas informações pessoais nas configurações do aplicativo History. Por exemplo, você pode'
                ' atualizar as informações do seu perfil ou optar por habilitar recursos adicionais de privacidade, como uma senha.'
                '\n\n'
                'Informações que podemos compartilhar'
                '\n\n'
                'Terceiros'
                '\n\n'
                'Trabalhamos com terceiros para fornecer alguns de nossos Serviços. Por exemplo, nossos provedores terceirizados'
                ' enviam um código de verificação para o seu número de telefone quando você se registra em nossos serviços. Esses'
                ' provedores são regidos por suas Políticas de Privacidade para proteger essas informações. Se você usar outros'
                ' Serviços de terceiros como YouTube, Spotify, Giphy, etc. em conexão com nossos Serviços, seus Termos e Políticas'
                ' de Privacidade regem o uso desses serviços'
                '\n\n'
                'Outras instâncias em que o History pode precisar compartilhar seus dados'
                '\n\n'
                '- Para atender a qualquer lei aplicável, regulamento, processo legal ou solicitação governamental aplicável.'
                '\n'
                '- Para fazer cumprir os Termos aplicáveis, incluindo investigação de possíveis violações.'
                '\n'
                '- Para detectar, prevenir ou solucionar problemas técnicos, de segurança ou de fraude.'
                '\n'
                '- Para proteger contra danos aos direitos, propriedade ou segurança do History, de nossos usuários ou do público,'
                ' conforme exigido ou permitido por lei.'
                '\n\n'
                'Atualizações'
                '\n\n'
                'Atualizaremos esta política de privacidade conforme necessário para que seja atual, precisa e o mais clara'
                ' possível. O uso contínuo de nossos serviços confirma sua aceitação de nossa Política de Privacidade atualizada.',
                style: UiTextStyle.text4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
