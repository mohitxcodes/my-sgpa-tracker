import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';

class SGPAHistory {
  final double sgpa;
  final List<Subject> subjects;
  final double totalCredits;
  final int totalSubjects;
  final String averageGrade;
  final DateTime createdAt;

  SGPAHistory({
    required this.sgpa,
    required this.subjects,
    required this.totalCredits,
    required this.totalSubjects,
    required this.averageGrade,
    required this.createdAt,
  });

  factory SGPAHistory.fromJson(Map<String, dynamic> json) {
    return SGPAHistory(
      sgpa: json['sgpa'],
      subjects: (json['subject_data'] as List).map((item) {
        return Subject(
          id: item['id'],
          name: item['name'],
          credit: item['credit'],
          grade: item['grade'],
          gradePoint: item['gradePoint'],
        );
      }).toList(),
      totalCredits: json['total_credits'],
      totalSubjects: json['total_subjects'],
      averageGrade: json['average_grade'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }
}
