class CongressmanModel {
  List<int> id;
  String name;
  String abbreviationFederalUnit;
  String abbreviationGender;
  String abbreviationPoliticalParty;
  String startDate;

  CongressmanModel({
    required this.id,
    required this.name,
    required this.abbreviationFederalUnit,
    required this.abbreviationGender,
    required this.abbreviationPoliticalParty,
    required this.startDate,
  });

  CongressmanModel copyWith({
    List<int>? id,
    String? name,
    String? abbreviationFederalUnit,
    String? abbreviationGender,
    String? abbreviationPoliticalParty,
    String? startDate,
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
    );
  }
}
