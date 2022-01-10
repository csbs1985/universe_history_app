// ignore_for_file: unnecessary_new

class CommentModel {
  final String id;
  final String text;
  final String user;
  final String date;
  final bool edit;
  final bool delete;

  CommentModel({
    required this.id,
    required this.text,
    required this.user,
    required this.date,
    required this.edit,
    required this.delete,
  });

  static List<CommentModel> allComment = [
    new CommentModel(
        id: '0',
        text: 'Então ontem mesmo ele deve ter voltado ne?',
        user: 'luizaCosta',
        date: '10 de janeiro de 2022',
        edit: false,
        delete: false),
    new CommentModel(
        id: '1',
        text:
            'Mas não era remoto pra sempre??? :sorrindo_suor: Me segue no Instagram pra mais vídeos :apontando_para_a_direita:',
        user: 'charlesSantos',
        date: '10 de janeiro de 2022',
        edit: false,
        delete: false),
    new CommentModel(
        id: '2',
        text:
            'Alô, Salvador! O Nublacks está aqui novamente, e dessa vez para batermos um papo sobre Plataformização! Plataformização também pode ser entendida como um modelo de negócios baseado no uso de plataformas digitais, que são interfaces de interação entre consumidores, empresas parceiras ou serviços internos. Essa relação envolve a padronização de comunicação, circulação de dados, a monetização e estabilidade do “ecossistema” de plataformas - que são importantes para a criação de novos produtos e serviços, bem como realizar vendas e atrair usuários. A ideia de construir plataformas parte do princípio de que isso facilita a velocidade de entrega e eficiência em escala, por meio de recursos reutilizáveis. Em última análise, uma plataforma é atraente quando é mais fácil consumi-la do que construir e manter seu próprio produto. Para conversar sobre isso, estarão conosco Lucas Plácido, Sr Software Engineering Java @Grupo FCamara; Isabela Gonçalves, Sr Software Engineer @Nubank; e Pedro Mariano, Software Engineer @Nubank. Nosso encontro acontecerá no dia 12/01 às 19h. Junte-se a nós! Inscreva-se!',
        user: 'charlesSantos',
        date: '10 de janeiro de 2022',
        edit: false,
        delete: false),
  ];
}
