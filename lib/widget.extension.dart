import 'package:flutter/material.dart';

extension CustomWidgets on BuildContext {
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  Widget customTextField({
    required TextEditingController controller,
    String? errorText,
    required String labelText,
    required IconData prefixIcon,
    required TextInputType keyboardType,
    required Function(String) onChanged,
    required String errorTextCredit,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      cursorRadius: const Radius.circular(50),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 20,
        ),
        errorText: errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        label: Text(
          labelText,
          style: bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            width: 2,
            color: errorText != null ? Colors.red : Colors.black,
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

extension CustomStringExt on String {
  String findGradePoint() {
    if (this == "A+") {
      return "10";
    } else if (this == "A") {
      return "9";
    } else if (this == "B+") {
      return "8";
    } else if (this == "B") {
      return "7";
    } else if (this == "C+") {
      return "6";
    } else if (this == "C") {
      return "5";
    } else if (this == "D") {
      return "4";
    } else {
      return "0";
    }
  }
}
