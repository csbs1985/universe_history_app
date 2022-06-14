class DenounceModel {
  DenounceModel({
    required this.id,
    required this.userId,
    required this.idDenounced,
    required this.nickDenounced,
    required this.code,
    required this.justify,
    required this.date,
  });

  late String id;
  late String userId;
  late String idDenounced;
  late String nickDenounced;
  late String code;
  late String justify;
  late String date;
}
