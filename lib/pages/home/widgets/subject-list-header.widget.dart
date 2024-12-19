import 'package:flutter/material.dart';

class SubjectListHeader extends StatelessWidget {
  final Function() onClear;
  const SubjectListHeader({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Added Subjects",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onClear(),
          icon: const Icon(Icons.delete_sweep, size: 20),
          label: const Text("Clear All"),
        ),
      ],
    );
  }
}
