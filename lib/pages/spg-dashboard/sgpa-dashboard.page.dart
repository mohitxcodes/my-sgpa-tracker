import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';
import 'package:my_sgpa_tracker/pages/spg-dashboard/subject-analytics.dart';
import 'package:my_sgpa_tracker/pages/spg-dashboard/widgets/animated-header.dart';
import 'package:my_sgpa_tracker/pages/spg-dashboard/widgets/dashboard_header_content.dart';

class SgpaDashboard extends StatelessWidget {
  const SgpaDashboard({
    super.key,
    required this.sgpaValue,
    required this.totalSubjects,
    required this.totalCredits,
    required this.averageGrade,
    required this.subjectData,
  });

  final double sgpaValue;
  final int totalSubjects;
  final double totalCredits;
  final String averageGrade;
  final List<Subject> subjectData;

  String _calculateAverageGrade() {
    final avgGradePoint = subjectData.isEmpty
        ? 0
        : (subjectData
                    .map((s) => int.parse(s.gradePoint))
                    .reduce((a, b) => a + b) /
                subjectData.length)
            .round();

    const gradeMap = {
      10: "A+",
      9: "A",
      8: "B+",
      7: "B",
      6: "C+",
      5: "C",
      4: "D",
    };

    return gradeMap[avgGradePoint] ?? "F";
  }

  @override
  Widget build(BuildContext context) {
    final avgGrade = _calculateAverageGrade();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedHeader(
                height: constraints.maxHeight * 0.4,
                child: DashboardHeaderContent(
                  sgpaValue: sgpaValue,
                  totalSubjects: totalSubjects,
                  totalCredits: totalCredits,
                  avgGrade: avgGrade,
                ),
              ),
              Expanded(
                child: SubjectAnalytics(
                  subjectData: subjectData,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
