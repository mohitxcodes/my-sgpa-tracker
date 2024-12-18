import 'package:flutter/material.dart';

class GradeDropdown extends StatefulWidget {
  GradeDropdown({super.key, required this.setGradeValue});

  Function(String) setGradeValue;

  @override
  State<GradeDropdown> createState() => _GradeDropdownState();
}

final List<String> gradeList = [
  'A+',
  'A',
  'B+',
  'B',
  'C+',
  'C',
  'D',
  'E',
  'F',
  'I'
];

class _GradeDropdownState extends State<GradeDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(10),
      value: gradeList[0],
      items: gradeList
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          // Update the parent widget's controller value
          widget.setGradeValue(val!);
        });
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.grade_outlined,
          size: 20,
        ),
        label: const Text(
          "Select Grade",
          style: TextStyle(
            color: Colors.black,
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
            )),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
