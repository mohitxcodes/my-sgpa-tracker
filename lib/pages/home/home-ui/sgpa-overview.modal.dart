import 'package:flutter/material.dart';

class SGPAOverview extends StatelessWidget {
  const SGPAOverview({super.key, required this.sgpa});

  final String sgpa;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('SGPA Overview'),
      content: Text(
        'Your SGPA is $sgpa',
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('View Details'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red[400],
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
