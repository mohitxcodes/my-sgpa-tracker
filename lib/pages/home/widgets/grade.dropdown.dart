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
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(10),
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      onChanged: (val) {
        onValueChange(val!);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.grade_outlined,
          size: 20,
        ),
        label: Text(
          label ?? "Select Grade",
          style: const TextStyle(
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
