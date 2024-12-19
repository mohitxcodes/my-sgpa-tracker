import 'package:flutter/material.dart';
import 'package:spga_cal/models/subject_item.model.dart';
import 'package:spga_cal/pages/home/home.page.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/subject-card.dart';

class SubjectAnalytics extends StatelessWidget {
  const SubjectAnalytics({
    super.key,
    required this.subjectData,
  });

  final List<Subject> subjectData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: const Row(
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subjectData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SubjectCard(
                    subject: subjectData[index],
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
