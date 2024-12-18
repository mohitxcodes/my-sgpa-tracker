import 'package:flutter/material.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/subject-card.dart';

class SubjectAnalyticsModel {
  final String subjectName;
  final String grade;
  final int credits;
  final String performance;
  SubjectAnalyticsModel(
      {required this.subjectName,
      required this.performance,
      required this.grade,
      required this.credits});
}

class SubjectAnalytics extends StatelessWidget {
  const SubjectAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subject Analytics",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.replay_outlined,
                size: 20,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _subjectAnalytics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SubjectCard(
                    id: index + 1,
                    name: _subjectAnalytics[index].subjectName,
                    grade: _subjectAnalytics[index].grade,
                    credits: _subjectAnalytics[index].credits,
                    performance: _subjectAnalytics[index].performance,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<SubjectAnalyticsModel> _subjectAnalytics = [
  SubjectAnalyticsModel(
    subjectName: "ITPS",
    grade: "A+",
    credits: 4,
    performance: "Excellent",
  ),
  SubjectAnalyticsModel(
    subjectName: "Mathematics",
    grade: "B",
    credits: 5,
    performance: "Average",
  ),
  SubjectAnalyticsModel(
    subjectName: "ITPS",
    grade: "A+",
    credits: 4,
    performance: "Excellent",
  ),
  SubjectAnalyticsModel(
    subjectName: "SPHY",
    grade: "D",
    credits: 3,
    performance: "Not Good",
  ),
  SubjectAnalyticsModel(
    subjectName: "ITPS",
    grade: "A+",
    credits: 4,
    performance: "Excellent",
  ),
  SubjectAnalyticsModel(
    subjectName: "Mathematics",
    grade: "B",
    credits: 5,
    performance: "Average",
  ),
  SubjectAnalyticsModel(
    subjectName: "ITPS",
    grade: "A+",
    credits: 4,
    performance: "Excellent",
  ),
  SubjectAnalyticsModel(
    subjectName: "SPHY",
    grade: "D",
    credits: 3,
    performance: "Not Good",
  )
];
