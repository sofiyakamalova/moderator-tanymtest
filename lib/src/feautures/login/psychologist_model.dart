class PsychologistModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String description;
  final String gov_institution;
  final String school_id;

  const PsychologistModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.description,
    required this.gov_institution,
    required this.school_id,
  });

  factory PsychologistModel.fromJson(Map<String, dynamic> json) =>
      PsychologistModel(
          uid: json['uid'] ?? 'Id не найден',
          name: json['name'] ?? 'Имя не найдено',
          email: json['email'] ?? 'Email не найден',
          image: json['image'] ?? 'Фото не найдено',
          description: json['description'] ?? 'Описание не найдено',
          gov_institution:
              json['gov_institution'] ?? 'Гос. учреждение не найдено',
          school_id: json['school_id'] ?? 'Id гос. учреждения не найден');
}
