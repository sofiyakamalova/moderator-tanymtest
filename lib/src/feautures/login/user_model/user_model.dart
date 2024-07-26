class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String description;
  final String gov_institution;
  final String school_id;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.description,
    required this.gov_institution,
    required this.school_id,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
      uid: data['uid'] ?? 'Id не найден',
      name: data['name'] ?? 'Имя не найдено',
      email: data['email'] ?? 'Email не найден',
      image: data['image'] ?? 'Фото не найдено',
      description: data['description'] ?? 'Описание не найдено',
      gov_institution: data['gov_institution'] ?? 'Гос. учреждение не найдено',
      school_id: data['school_id'] ?? 'Id гос. учреждения не найден');
}
