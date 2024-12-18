import 'package:flutter/material.dart';
import 'package:spga_cal/pages/spg-dashboard/subject-analytics.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/animated-header.dart';
import 'package:spga_cal/pages/spg-dashboard/widgets/overview-card.dart';

class SgpaDashboard extends StatelessWidget {
  const SgpaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedHeader(
            height: 300,
            child: SafeArea(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "SGPA Overview",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.dashboard,
                          color: Colors.white70,
                          size: 14,
                        ),
                      ],
                    ),
                    Text(
                      "- SGPA : 8.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OverViewCard(
                            title: "Total Subjects", value: "8 Subject"),
                        OverViewCard(
                            title: "Total Credits", value: "21 Credit"),
                        OverViewCard(title: "Average Grade", value: "A+ Grade"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SubjectAnalytics(),
          ),
        ],
      ),
    );
  }
}
