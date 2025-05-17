import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/models/sgpa_history.modal.dart';
import 'package:my_sgpa_tracker/pages/sgpa-history/widgets/welcome_header.dart';
import 'package:my_sgpa_tracker/pages/sgpa-history/widgets/sgpa_history_card.dart';
import 'package:my_sgpa_tracker/pages/sgpa-history/widgets/sgpa_details_sheet.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  final String userName;
  const HistoryPage({super.key, required this.userName});

  Future<List<SGPAHistory>> fetchSGPAHistory() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Registered Users")
        .doc(userName)
        .collection("sgpa_history")
        .orderBy("created_at", descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return SGPAHistory.fromJson({...doc.data(), 'id': doc.id});
    }).toList();
  }

  Future<void> deleteHistoryItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('sgpa_history')
          .doc(id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAllHistory(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear all SGPA history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final snapshot = await FirebaseFirestore.instance
          .collection("Registered Users")
          .doc(userName)
          .collection("sgpa_history")
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Color getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green;
      case 'A':
        return Colors.lightGreen;
      case 'B+':
        return Colors.blue;
      case 'B':
        return Colors.lightBlue;
      case 'C':
        return Colors.orange;
      case 'P':
        return Colors.amber;
      case 'F':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getPerformanceColor(double sgpa) {
    if (sgpa >= 8.0) return Colors.green;
    if (sgpa >= 7.0) return Colors.amber;
    return Colors.red;
  }

  String getPerformanceText(double sgpa) {
    if (sgpa >= 8.0) return "Excellent";
    if (sgpa >= 7.0) return "Average";
    return "Needs Improvement";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SGPA History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SGPAHistory>>(
        future: fetchSGPAHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          final historyList = snapshot.data!;

          if (historyList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No SGPA history found',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Calculate your SGPA to see history',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              WelcomeHeader(
                userName: userName,
                onClearHistory: () => clearAllHistory(context),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => Future.value(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      final gradeColor = getGradeColor(history.averageGrade);
                      final performanceColor =
                          getPerformanceColor(history.sgpa);
                      final performanceText = getPerformanceText(history.sgpa);
                      final formattedDate =
                          DateFormat('MMM dd, yyyy').format(history.createdAt);

                      return SGPAHistoryCard(
                        history: history,
                        performanceColor: performanceColor,
                        performanceText: performanceText,
                        onDelete: deleteHistoryItem,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
