import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_sgpa_tracker/pages/home/home.page.dart';

class GetNameModal extends StatefulWidget {
  const GetNameModal({super.key});

  @override
  State<GetNameModal> createState() => _GetNameModalState();
}

class _GetNameModalState extends State<GetNameModal> {
  final TextEditingController _nameController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                name: _nameController.text,
              )),
      (route) => false,
    );
  }

  bool isLoading = false;

  void addUserToDatabase(BuildContext context, String name) async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firestore.collection('Registered Users').add(
        {
          'username': name,
          'createdAt': Timestamp.now(),
        },
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', name);
      setState(() {
        isLoading = false;
      });
      navigateToHome(context);
    } catch (e) {
      throw Exception('Error adding user to database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "MySGPA Tracker",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey[600],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                cursorColor: Colors.red[400],
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  labelText: "Enter Your Name",
                  labelStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Colors.grey[600],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      return;
                    } else {
                      addUserToDatabase(context, _nameController.text);
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
