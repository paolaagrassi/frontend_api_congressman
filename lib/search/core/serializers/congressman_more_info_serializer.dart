// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:frontend_api_congressman/search/models/models.dart';

class CongressmanMoreInfoSerializer {
  static Map<String, dynamic> toMap(CongressmanMoreInfoModel model) {
    return <String, dynamic>{
      'abbreviationGender': model.education,
      'startDate': model.birthCity,
      'civilName': model.abbreviationGender,
    };
  }

  static CongressmanMoreInfoModel fromMap(Map<String, dynamic> map) {
    return CongressmanMoreInfoModel(
      education: map['escolaridade'] as String,
      birthCity: map['municipioNascimento'] as String,
      abbreviationGender: map['sexo'] as String,
    );
  }

  static String toJson(CongressmanMoreInfoModel model) =>
      json.encode(CongressmanMoreInfoSerializer.toMap(model));

  static CongressmanMoreInfoModel fromJson(String source) =>
      CongressmanMoreInfoSerializer.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
