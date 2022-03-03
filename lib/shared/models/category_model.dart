// ignore_for_file: unnecessary_new

import 'dart:convert';

class CategoryModel {
  final String? id;
  final String? label;
  final bool? isShowMenu;
  final bool? isShowInput;
  final bool? isDisabled;

  CategoryModel({
    this.id,
    this.label,
    this.isShowMenu,
    this.isShowInput,
    this.isDisabled,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel.fromMap(json);

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        label: json['label'],
        isShowMenu: json['isShowMenu'],
        isShowInput: json['isShowInput'],
        isDisabled: json['isDisabled'],
      );

  static String toJson(List<CategoryModel> category) =>
      json.encode(toMap(category));

  static Map<String, dynamic> toMap(List<CategoryModel> category) => {
        'id': category.first.id,
        'label': category.first.label,
        'isShowMenu': category.first.isShowMenu,
        'isShowInput': category.first.isShowInput,
        'isDisabled': category.first.isDisabled,
      };

  static List<CategoryModel> allCategories = [
    new CategoryModel(
      id: 'todas',
      label: 'todas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'minhas',
      label: 'minhas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'salvas',
      label: 'salvas',
      isShowMenu: true,
      isShowInput: false,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'animais',
      label: 'animais',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'astrologia',
      label: 'astrologia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'astronomia',
      label: 'astronomia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'bebida',
      label: 'bebida',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'beleza',
      label: 'beleza',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'ciencias',
      label: 'ciências',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'climaTempo',
      label: 'clima e tempo',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'comedia',
      label: 'comédia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'comida',
      label: 'comida',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'cultura',
      label: 'cultura',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'dinheiro',
      label: 'dinheiro',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'entretenimento',
      label: 'entretenimento',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'esportes',
      label: 'esportes',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'estudos',
      label: 'estudos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'eventos',
      label: 'eventos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'extraterrestre',
      label: 'extraterrestre',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'familia',
      label: 'família',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'folclore',
      label: 'folclore',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'fotografiaVideos',
      label: 'fotografia e vídeos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'geografia',
      label: 'geografia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'internet',
      label: 'internet',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'moda',
      label: 'moda',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'musica',
      label: 'música',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'religiao',
      label: 'religião',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'romance',
      label: 'romance',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'saude',
      label: 'saúde',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'sexo',
      label: 'sexo',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'tatuagemPiercing',
      label: 'tatuagem e piercing',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'tecnologia',
      label: 'tecnologia',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'terror',
      label: 'terror',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'trabalho',
      label: 'trabalho',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'transportes',
      label: 'transportes',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'tvFilmesSeries',
      label: 'tv, filmes e séries',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'veiculos',
      label: 'veículos',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    ),
    new CategoryModel(
      id: 'violencia',
      label: 'violência',
      isShowMenu: true,
      isShowInput: true,
      isDisabled: false,
    )
  ];
}
