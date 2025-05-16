import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';

class SGPAHistory {
  final String id;
  final double sgpa;
  final List<Subject> subjects;
  final double totalCredits;
  final int totalSubjects;
  final String averageGrade;
  final DateTime createdAt;

  SGPAHistory({
    required this.id,
    required this.sgpa,
    required this.subjects,
    required this.totalCredits,
    required this.totalSubjects,
    required this.averageGrade,
    required this.createdAt,
  });

  factory SGPAHistory.fromJson(Map<String, dynamic> json) {
    return SGPAHistory(
      id: json['id'] as String,
      sgpa: (json['sgpa'] as num).toDouble(),
      subjects: (json['subject_data'] as List).map((item) {
        return Subject(
          id: item['id'],
          name: item['name'],
          credit: item['credit'],
          grade: item['grade'],
          gradePoint: item['gradePoint'],
        );
      }).toList(),
      totalCredits: (json['total_credits'] as num).toDouble(),
      totalSubjects: json['total_subjects'] as int,
      averageGrade: json['average_grade'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sgpa': sgpa,
      'subject_data': subjects.map((subject) => subject.toJson()).toList(),
      'total_credits': totalCredits,
      'total_subjects': totalSubjects,
      'average_grade': averageGrade,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
