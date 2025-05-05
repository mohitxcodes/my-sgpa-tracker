import 'package:flutter/material.dart';

class GradeDropdown extends StatelessWidget {
  final Function(String) onValueChange;
  final String? value;
  final String? label;
  final List<String> items;
  const GradeDropdown({
    super.key,
    required this.onValueChange,
    this.value,
    this.label,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(15),
      value: value,
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.red[400],
      ),
      dropdownColor: Colors.white,
      elevation: 8,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: _getGradeColor(e).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: _getGradeColor(e),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    e,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (val) {
        if (val != null) {
          onValueChange(val);
        }
      },
      decoration: InputDecoration(
        label: Text(
          label ?? "Select Grade",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green[700]!;
      case 'A':
        return Colors.green[500]!;
      case 'B+':
        return Colors.blue[700]!;
      case 'B':
        return Colors.blue[500]!;
      case 'C+':
        return Colors.orange[700]!;
      case 'C':
        return Colors.orange[500]!;
      case 'D':
        return Colors.red[500]!;
      case 'E':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  String _getGradeDescription(String grade) {
    switch (grade) {
      case 'A+':
        return 'Outstanding (10.0)';
      case 'A':
        return 'Excellent (9.0)';
      case 'B+':
        return 'Very Good (8.0)';
      case 'B':
        return 'Good (7.0)';
      case 'C+':
        return 'Above Average (6.0)';
      case 'C':
        return 'Average (5.0)';
      case 'D':
        return 'Below Average (4.0)';
      case 'E':
        return 'Failed (0.0)';
      default:
        return 'N/A';
    }
  }
}
