import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({
    super.key,
    required this.id,
    required this.name,
    required this.grade,
    required this.credits,
    required this.performance,
  });

  final int id;
  final String name;
  final String grade;
  final int credits;
  final String performance;
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    if (performance == "Excellent") {
      _color = Colors.green;
    } else if (performance == "Average") {
      _color = const Color.fromARGB(255, 202, 140, 7);
    } else {
      _color = Colors.red;
    }

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
                name,
                style: TextStyle(
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
                  performance,
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
                    "Grade : $grade",
                    style: TextStyle(color: Colors.grey.shade600),
                  )),
              SizedBox(
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
                    "Credits : $credits",
                    style: TextStyle(color: Colors.grey.shade600),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
