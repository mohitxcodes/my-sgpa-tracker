import 'package:flutter/material.dart';
import 'package:spga_cal/pages/home/home.page.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({
    super.key,
    required this.subject,
  });

  final Subject subject;
  Color _color = Colors.green;
  String _performance = "";

  void _getPerformance() {
    int gradePoint = int.parse(subject.gradePoint);

    if (gradePoint >= 8) {
      _performance = "Excellent";
      _color = Colors.green;
    } else if (gradePoint >= 6) {
      _performance = "Average";
      _color = const Color.fromARGB(255, 202, 140, 7);
    } else {
      _performance = "Bad";
      _color = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    _getPerformance();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        border: Border.all(color: _color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: _color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _performance,
                  style: TextStyle(
                    color: _color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Grade : ${subject.grade}",
                    style: TextStyle(color: Colors.grey.shade600),
                  )),
              const SizedBox(
                width: 8,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Credits : ${subject.credit}",
                    style: TextStyle(color: Colors.grey.shade600),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
