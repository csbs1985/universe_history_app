import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_text/styled_text.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

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
            children: [
              const TitleComponent(title: 'Termo de uso'),
              StyledText(
                  style: UiTextStyle.text4,
                  tags: {
                    'b': StyledTextTag(
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  },
                  text: 'Atualizado em 16 de junho de 2021'
                      '\n\n'
                      'O History foi projetado para nunca coletar ou armazenar informações confidenciais. Todo o conteúdo no History não pode ser acessado por'
                      ' nós ou terceiros porque são sempre criptografadas de ponta a ponta, privadas e seguras. Nossos Termos de uso e serviço estão disponíveis abaixo.'
                      '\n\n'
                      'Termos de serviço'
                      '\n\n'
                      'O History utiliza segurança de ponta e criptografia ponta a ponta para fornecer serviços para usuários em todo o mundo. Você concorda com nossos '
                      'Termos de Serviço ao instalar ou usar nossos aplicativos ou serviços.'
                      '\n\n'
                      'Sobre nossos serviços'
                      '\n\n'
                      'Idade mínima'
                      '\n\n'
                      'Você deve ter pelo menos 13 anos para usar nossos Serviços. A idade mínima para usar nossos Serviços sem a aprovação dos pais pode ser mais alta'
                      ' em seu país de origem.'
                      '\n\n'
                      'Registro de conta'
                      '\n\n'
                      'Para criar uma conta, você deve se registrar em nossos Serviços usando uma conta Google ou Apple. Você concorda em receber mensagens de texto'
                      ' (de nós ou de nossos provedores terceirizados) com códigos de verificação para se registrar em nossos Serviços.'
                      '\n\n'
                      'Privacidade dos dados do usuário'
                      '\n\n'
                      'O History nunca vende, aluga ou monetiza seus dados pessoais ou conteúdo de nenhuma forma.'
                      '\n\n'
                      'Leia nossa Política de Privacidade para entender como protegemos as informações que nos fornece ao usar nossos Serviços. Para a finalidade de'
                      ' operar nossos Serviços, você concorda com nossas práticas de dados conforme descrito em nossa Política de Privacidade, bem como a transferência'
                      ' de suas informações criptografadas para países onde temos ou usamos instalações, provedores de serviços ou parceiros.'
                      '\n\n'
                      'Programas'
                      '\n\n'
                      'Para habilitar novos recursos e funcionalidades aprimoradas, você consente em baixar e instalar atualizações em nossos Serviços.'
                      '\n\n'
                      'Taxas e impostos'
                      '\n\n'
                      'Você é responsável por taxas e impostos de operadora de dados e celular associados aos dispositivos nos quais você usa nossos Serviços.'
                      '\n\n'
                      'Usando o History'
                      '\n\n'
                      'Nossos Termos e Políticas'
                      '\n\n'
                      'Você deve usar nossos Serviços de acordo com nossos Termos e políticas publicadas. Se desativarmos sua conta por violação de nossos Termos, você'
                      ' não criará outra conta sem nossa permissão.'
                      '\n\n'
                      'Uso legal e aceitável'
                      '\n\n'
                      'Você concorda em usar nossos Serviços apenas para fins legais, autorizados e aceitáveis. Você não usará (ou ajudará outros a usar) nossos Serviços'
                      ' de maneiras que:'
                      '\n'
                      '(a) violem ou infrinjam os direitos do History, de nossos usuários ou de outros, incluindo privacidade, publicidade, propriedade'
                      ' intelectual ou outros direitos de propriedade;'
                      '\n'
                      '(b) envolvem o envio de comunicações ilegais ou inadmissíveis, como mensagens em massa, mensagens automáticas e discagem automática.'
                      '\n\n'
                      'Danos ao History'
                      '\n\n'
                      'Você não deve (ou ajudar outros a) acessar, usar, modificar, distribuir, transferir ou explorar nossos Serviços de maneiras não autorizadas ou de'
                      ' maneiras que prejudiquem o History, nossos Serviços ou sistemas. Por exemplo, você não deve:'
                      '\n'
                      '(a) obter ou tentar obter acesso não autorizado aos nossos Serviços ou sistemas;'
                      '\n'
                      '(b) interromper a integridade ou o desempenho dos nossos Serviços;'
                      '\n'
                      '(c) criar contas para nossos Serviços por meios não autorizados ou automatizados;'
                      '\n'
                      '(d) coletar informações sobre nossos usuários de qualquer maneira não autorizada; ou'
                      '\n'
                      '(e) vender, alugar ou cobrar por nossos Serviços.'
                      '\n\n'
                      'Mantendo sua conta segura'
                      '\n\n'
                      'O History adota a privacidade desde o design e não tem a capacidade de acessar seu conteúdo. Você é responsável por manter seu dispositivo e sua'
                      ' conta History seguros e protegidos. Se você perder seu telefone, siga as etapas de recuperação de conta para registrar-se novamente em nossos'
                      ' Serviços. Quando você se registra em um novo dispositivo, o dispositivo antigo irá parar de receber todas as mensagens e chamadas.'
                      '\n\n'
                      'Sem acesso a serviços de emergência'
                      '\n\n'
                      'Nossos serviços não fornecem acesso a prestadores de serviços de emergência, como polícia, corpo de bombeiros, hospitais ou outras organizações de'
                      ' segurança pública. Certifique-se de entrar em contato com os provedores de serviços de emergência por meio de um celular, telefone fixo ou outro serviço.'
                      '\n\n'
                      'Serviços terceirizados'
                      '\n\n'
                      'Nossos Serviços podem permitir que você acesse, use ou interaja com sites, aplicativos, conteúdo e outros produtos e serviços de terceiros. Quando'
                      ' você usa serviços de terceiros, seus termos e políticas de privacidade regem o uso desses serviços.'
                      '\n\n'
                      'Seus direitos e licença'
                      '\n\n'
                      'Seus direitos'
                      '\n\n'
                      'Você é o proprietário das informações que envia por meio de nossos Serviços. Você deve ter direitos sobre o as informações que informará para se'
                      ' inscrever em sua conta do History.'
                      '\n\n'
                      'Direitos do History'
                      '\n\n'
                      'Somos proprietários de todos os direitos autorais, marcas registradas, domínios, logotipos, imagem comercial, segredos comerciais, patentes e outros'
                      ' direitos de propriedade intelectual associados aos nossos Serviços. Você não pode usar nossos direitos autorais, marcas registradas, domínios,'
                      ' logotipos, imagem comercial, patentes e outros direitos de propriedade intelectual, a menos que tenha nossa permissão por escrito. Para denunciar'
                      ' direitos autorais, marcas registradas ou outra violação de propriedade intelectual, entre em contato com csbs.conta@outlook.com.'
                      '\n\n'
                      'Licença do History para você'
                      '\n\n'
                      'O History concede a você uma licença limitada, revogável, não exclusiva e intransferível para usar nossos Serviços de acordo com estes Termos.'
                      '\n\n'
                      'Renúncias e limitações'
                      '\n\n'
                      'Isenções de responsabilidade'
                      '\n\n'
                      'VOCÊ USA NOSSOS SERVIÇOS POR SEU PRÓPRIO RISCO E SUJEITO ÀS SEGUINTES ISENÇÕES. FORNECEMOS NOSSOS SERVIÇOS "COMO ESTÃO" SEM NENHUMA GARANTIA EXPRESSA'
                      ' OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO A, GARANTIAS DE COMERCIALIZAÇÃO, ADEQUAÇÃO A UM DETERMINADO FIM, TÍTULO, NÃO VIOLAÇÃO E LIBERDADE DE'
                      ' VÍRUS DE COMPUTADOR . O HISTORY NÃO GARANTE QUE QUALQUER INFORMAÇÃO FORNECIDA POR NÓS É PRECISA, COMPLETA OU ÚTIL, QUE NOSSOS SERVIÇOS SERÃO'
                      ' OPERACIONAIS, LIVRES DE ERROS, SEGUROS OU SEGUROS, OU QUE NOSSOS SERVIÇOS FUNCIONARÃO SEM INTERRUPÇÕES, ATRASOS OU IMPERFEIÇÕES. NÃO CONTROLAMOS E NÃO'
                      ' SOMOS RESPONSÁVEIS POR CONTROLAR COMO OU QUANDO NOSSOS USUÁRIOS USAM NOSSOS SERVIÇOS. NÃO SOMOS RESPONSÁVEIS PELAS AÇÕES OU INFORMAÇÕES (INCLUINDO'
                      ' CONTEÚDO) DE NOSSOS USUÁRIOS OU DE OUTROS TERCEIROS. VOCÊ LIBERA-NOS, AFILIADOS, DIRETORES, DIRETORES, FUNCIONÁRIOS.'
                      '\n\n'
                      'Limitação de responsabilidade'
                      '\n\n'
                      'AS PARTES DO HISTORY NÃO SERÃO RESPONSÁVEIS POR QUAISQUER LUCROS PERDIDOS OU CONSEQUENTES, ESPECIAIS, PUNITIVOS, DIRETOS OU INCIDENTAIS RELACIONADOS'
                      ' A, DECORRENTES DE, OU DE QUALQUER FORMA EM CONEXÃO COM NOSSOS TERMOS, OU NOSSOS SERVIÇOS, MESMO SE AS PARTES DO HISTORY SÃO AVISADAS DA POSSIBILIDADE'
                      ' DE TAIS DANOS. NOSSA RESPONSABILIDADE AGREGADA RELACIONADA A, DECORRENTE DE, OU DE QUALQUER FORMA EM CONEXÃO COM NOSSOS TERMOS, NÓS OU NOSSOS SERVIÇOS'
                      ' NÃO EXCEDERÁ CEMTAVOS DE DÓLARES AMERICANO OU QUALQUER MOEDA FISICA OU DIGITAL. A ISENÇÃO DE RESPONSABILIDADE ANTERIOR DE CERTOS DANOS E LIMITAÇÃO DE'
                      ' RESPONSABILIDADE SE APLICARÁ NA EXTENSÃO MÁXIMA PERMITIDA PELA LEI APLICÁVEL. AS LEIS DE ALGUNS ESTADOS OU JURISDIÇÕES PODEM NÃO PERMITIR A EXCLUSÃO'
                      ' OU LIMITAÇÃO DE CERTOS DANOS, PORTANTO ALGUMAS OU TODAS AS EXCLUSÕES E LIMITAÇÕES ESTABELECIDAS ACIMA PODEM NÃO SE APLICAR A VOCÊ. NÃO OBSTANTE'
                      ' QUALQUER COISA AO CONTRÁRIO EM NOSSOS TERMOS.'
                      '\n\n'
                      'Disponibilidade de nossos serviços'
                      '\n\n'
                      'Nossos serviços podem ser interrompidos, inclusive para manutenção, atualizações ou falhas de rede ou equipamento. Podemos descontinuar alguns ou'
                      ' todos os nossos Serviços, incluindo determinados recursos e o suporte para determinados dispositivos e plataformas, a qualquer momento.'
                      '\n\n'
                      'Em geral'
                      '\n\n'
                      'O History pode atualizar os Termos de tempos em tempos. Quando atualizarmos nossos Termos, atualizaremos a data da “Última Modificação” associada aos'
                      ' Termos atualizados. O uso continuado de nossos Serviços confirma sua aceitação de nossos Termos atualizados e substitui quaisquer Termos anteriores.'
                      ' Você cumprirá todas as leis de controle de exportação e sanções comerciais aplicáveis. Nossos Termos cobrem todo o acordo entre você e o History em'
                      ' relação aos nossos Serviços. Se você não concorda com nossos Termos, você deve parar de utilizar nossos Serviços.'
                      '\n\n'
                      'Se deixarmos de aplicar qualquer um de nossos Termos, isso não significa que renunciamos ao direito de aplicá-los. Se qualquer cláusula dos Termos for'
                      ' considerada ilegal, nula ou inexequível, essa cláusula será considerada separável de nossos Termos e não afetará a aplicabilidade das cláusulas'
                      ' restantes. Nossos Serviços não se destinam à distribuição ou uso em qualquer país onde tal distribuição ou uso violaria as leis locais ou nos'
                      ' sujeitaria a quaisquer regulamentos em outro país. Nós nos reservamos o direito de limitar nossos serviços em qualquer país. Se você tiver perguntas'
                      ' específicas sobre estes Termos, entre em contato conosco em csbs.conta@outlook.com.'),
            ],
          ),
        ),
      ),
    );
  }
}
