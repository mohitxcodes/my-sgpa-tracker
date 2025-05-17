import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onClearHistory;

  const WelcomeHeader({
    super.key,
    required this.userName,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      color: Colors.red.shade400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            tooltip: 'Clear History',
            color: Colors.white,
            onPressed: onClearHistory,
          ),
        ],
      ),
    );
  }
}
