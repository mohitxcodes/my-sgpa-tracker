class Subject {
  final int id;
  final String name;
  final String credit;
  final String grade;
  final String gradePoint;

  Subject({
    required this.id,
    required this.name,
    required this.credit,
    required this.grade,
    required this.gradePoint,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] as int,
      name: json['name'] as String,
      credit: json['credit'] as String,
      grade: json['grade'] as String,
      gradePoint: json['gradePoint'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'credit': credit,
      'grade': grade,
      'gradePoint': gradePoint,
    };
  }
}
