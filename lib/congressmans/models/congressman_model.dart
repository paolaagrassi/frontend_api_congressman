class CongressmanModel {
  String id;
  String name;
  String abbreviationFederalUnit;
  String abbreviationPoliticalParty;
  String urlPhoto;

  CongressmanModel({
    required this.id,
    required this.name,
    required this.abbreviationFederalUnit,
    required this.abbreviationPoliticalParty,
    required this.urlPhoto,
  });

  CongressmanModel copyWith({
    String? id,
    String? name,
    String? abbreviationFederalUnit,
    String? abbreviationPoliticalParty,
    String? urlPhoto,
  }) {
    return CongressmanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviationFederalUnit:
          abbreviationFederalUnit ?? this.abbreviationFederalUnit,
      abbreviationPoliticalParty:
          abbreviationPoliticalParty ?? this.abbreviationPoliticalParty,
      urlPhoto: urlPhoto ?? this.urlPhoto,
    );
  }
}
