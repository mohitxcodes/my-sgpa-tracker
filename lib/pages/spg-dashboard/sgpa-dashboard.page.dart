import 'package:flutter/material.dart';
import 'package:spga_cal/pages/home/home.page.dart';
import 'package:spga_cal/pages/spg-dashboard/subject-analytics.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/animated-header.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/overview-card.dart';

class SgpaDashboard extends StatelessWidget {
  SgpaDashboard({
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
  String avgGrade = "";

// Function to get the average grade
  void getAvgGrade() {
    int avgGradePoint = 0;
    for (var subject in subjectData) {
      avgGradePoint += int.parse(subject.gradePoint);
    }
    avgGradePoint = (avgGradePoint / subjectData.length).round();

    //Calculating the average grade
    if (avgGradePoint == 10) {
      avgGrade = "A+";
    } else if (avgGradePoint == 9) {
      avgGrade = "A";
    } else if (avgGradePoint == 8) {
      avgGrade = "B+";
    } else if (avgGradePoint == 7) {
      avgGrade = "B";
    } else if (avgGradePoint == 6) {
      avgGrade = "C+";
    } else if (avgGradePoint == 5) {
      avgGrade = "C";
    } else if (avgGradePoint == 4) {
      avgGrade = "D";
    } else {
      avgGrade = "F";
    }
  }

  @override
  Widget build(BuildContext context) {
    //Calling the function to get the average grade
    getAvgGrade();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedHeader(
            height: 300,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "SGPA Overview",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.info_outline,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ],
                    ),
                    Text(
                      "SGPA : $sgpaValue",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OverViewCard(
                            title: "Total Subjects",
                            value: "$totalSubjects Subject"),
                        OverViewCard(
                            title: "Total Credits",
                            value: "$totalCredits Credit"),
                        OverViewCard(
                            title: "Average Grade", value: "$avgGrade Grade"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SubjectAnalytics(
              subjectData: subjectData,
            ),
          ),
        ],
      ),
    );
  }
}
