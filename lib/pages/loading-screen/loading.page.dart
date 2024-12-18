import 'package:flutter/material.dart';
import 'package:spga_cal/pages/loading-screen/widgets/getName-modal.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  void _openModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GetNameModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash-img.jpg"),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: [
            // The main content, centered (logo, title, and subtitle)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo for loading
                    Image.asset(
                      "assets/images/loading-logo.jpg",
                      width: 400,
                    ),
                    const SizedBox(
                      height: 70,
                    ),

                    // Title for loading
                    const Text(
                      'MySGPA Tracker',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Subtitle for loading
                    const Text(
                      "Calculate SGPA Quickly In Few Steps",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Get Started Button
                    ElevatedButton(
                      onPressed: () {
                        _openModal(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        enableFeedback: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 2,
                        backgroundColor: Colors.red[400],
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Copyright Text - This will be pushed to the bottom
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Copyright©2024.All rights reserved.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
