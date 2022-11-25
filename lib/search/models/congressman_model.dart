class CongressmanModel {
  String id;
  String name;
  String abbreviationFederalUnit;
  String abbreviationGender;
  String abbreviationPoliticalParty;
  String startDate;
  String urlPhoto;

  CongressmanModel({
    required this.id,
    required this.name,
    required this.abbreviationFederalUnit,
    required this.abbreviationGender,
    required this.abbreviationPoliticalParty,
    required this.startDate,
    required this.urlPhoto,
  });

  CongressmanModel copyWith({
    String? id,
    String? name,
    String? abbreviationFederalUnit,
    String? abbreviationGender,
    String? abbreviationPoliticalParty,
    String? startDate,
    String? urlPhoto,
  }) {
    return CongressmanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviationFederalUnit:
          abbreviationFederalUnit ?? this.abbreviationFederalUnit,
      abbreviationGender: abbreviationGender ?? this.abbreviationGender,
      abbreviationPoliticalParty:
          abbreviationPoliticalParty ?? this.abbreviationPoliticalParty,
      startDate: startDate ?? this.startDate,
      urlPhoto: urlPhoto ?? this.urlPhoto,
    );
  }
}
