import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';
import 'package:my_sgpa_tracker/pages/spg-dashboard/widgets/subject-card.dart';
import 'package:my_sgpa_tracker/pages/sgpa-history/sgpa-history.page.dart';

class SubjectAnalytics extends StatelessWidget {
  const SubjectAnalytics({
    super.key,
    required this.subjectData,
    required this.userName,
  });

  final List<Subject> subjectData;
  final String userName;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subject Analytics",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryPage(userName: userName),
                          ),
                        );
                      },
                      child: Text(
                        "View History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.history_outlined,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
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
