// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:frontend_api_congressman/congressmans/models/models.dart';

class CongressmanSerializer {
  static Map<String, dynamic> toMap(CongressmanModel model) {
    return <String, dynamic>{
      'id': model.id,
      'nome': model.name,
      'siglaUf': model.abbreviationFederalUnit,
      'siglaPartido': model.abbreviationPoliticalParty,
      'urlFoto': model.urlPhoto,
    };
  }

  static CongressmanModel fromMap(Map<String, dynamic> map) {
    return CongressmanModel(
      id: map['id'].toString(),
      name: map['nome'] as String,
      abbreviationFederalUnit: map['siglaUf'] as String,
      abbreviationPoliticalParty: map['siglaPartido'] as String,
      urlPhoto: map['urlFoto'] as String,
    );
  }

  static String toJson(CongressmanModel model) =>
      json.encode(CongressmanSerializer.toMap(model));

  static CongressmanModel fromJson(String source) =>
      CongressmanSerializer.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
