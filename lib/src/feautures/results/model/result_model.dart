class ResultModel {
  final String name_of_test;
  final String data;
  final int depression;
  final int neuroticism;
  final int sincerity;
  final int sociability;
  final List<dynamic> list_of_emotions;

  ResultModel({
    required this.name_of_test,
    required this.data,
    required this.depression,
    required this.neuroticism,
    required this.sincerity,
    required this.sociability,
    required this.list_of_emotions,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        name_of_test: json['name_of_test'] ?? 'Название теста найдено',
        data: json['data'] ?? 'Дата не найдена',
        depression: json['depression'] ?? 0,
        neuroticism: json['neuroticism'] ?? 0,
        sincerity: json['sincerity'] ?? 0,
        sociability: json['sociability'] ?? 0,
        list_of_emotions: (json['list_of_emotions'] as List<dynamic>?) ?? [],
      );
}
