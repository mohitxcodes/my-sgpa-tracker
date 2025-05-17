import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_sgpa_tracker/core/widgets/feedback_form.dart';
import 'package:my_sgpa_tracker/pages/about-us/about_us_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_sgpa_tracker/pages/sgpa-history/sgpa-history.page.dart';

class SidebarMenu extends StatelessWidget {
  final Function onClose;
  final String userName;

  Future<void> sendFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mohitxcodes@gmail.com',
      queryParameters: {
        'subject': 'App Feedback - MySGPA Tracker',
        'body': 'Hi,\n\nI would like to share the following feedback:\n',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client';
    }
  }

  void shareApp(BuildContext context) {
    const link =
        'https://play.google.com/store/apps/details?id=com.msxcodes.my_sgpa_tracker';
    Clipboard.setData(const ClipboardData(text: link));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard!')),
    );

    onClose();
  }

  const SidebarMenu({
    Key? key,
    required this.onClose,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red[400]!,
                  Colors.red[600]!,
                ],
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '👋 Hey there,',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      const Text(
                        'SGPA Tracker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildMenuItem(
                  icon: Icons.home_rounded,
                  title: 'Home',
                  onTap: () {
                    onClose();
                  },
                ),
                _buildMenuItem(
                  icon: Icons.calculate_rounded,
                  title: 'SGPA History',
                  onTap: () {
                    onClose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryPage(userName: userName),
                      ),
                    );
                  },
                ),
                const Divider(height: 32),
                _buildMenuItem(
                  icon: Icons.feedback_rounded,
                  title: 'Send Feedback',
                  onTap: () {
                    onClose();
                    FeedbackForm.show(context, userName);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.share_rounded,
                  title: 'Share App',
                  onTap: () {
                    shareApp(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info_rounded,
                  title: 'About Us',
                  onTap: () {
                    onClose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border(
                top: BorderSide(
                  color: Colors.red[100]!,
                  width: 1,
                ),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'MySGPA Tracker v1.0.0',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Track your academic progress',
                  style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.red[400], size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
