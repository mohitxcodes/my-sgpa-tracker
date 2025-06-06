import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/core/widgets/sidebar_menu.dart';
import 'package:my_sgpa_tracker/data/data.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';
import 'package:my_sgpa_tracker/pages/about-us/about_us_screen.dart';
import 'package:my_sgpa_tracker/pages/home/widgets/grade.dropdown.dart';
import 'package:my_sgpa_tracker/pages/home/widgets/list-subjects.dart';
import 'package:my_sgpa_tracker/pages/home/widgets/subject-list-header.widget.dart';
import 'package:my_sgpa_tracker/pages/spg-dashboard/sgpa-dashboard.page.dart';
import 'package:my_sgpa_tracker/widget.extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController subjectCreditController = TextEditingController();
  final List<Subject> _subjectData = [];
  String gradeValue = "";
  String? _errorTextName;
  String? _errorTextCredit;

  bool isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    gradeValue = AppData.gradeList.first;
  }

  @override
  void dispose() {
    subjectNameController.dispose();
    subjectCreditController.dispose();
    super.dispose();
  }

  void addSubjectData() {
    _subjectData.add(
      Subject(
        id: _subjectData.length + 1,
        name: subjectNameController.text,
        credit: subjectCreditController.text,
        grade: gradeValue,
        gradePoint: gradeValue.findGradePoint(),
      ),
    );
    subjectNameController.clear();
    subjectCreditController.clear();
  }

  bool formValidation() {
    _errorTextName = null;
    _errorTextCredit = null;

    if (subjectNameController.text.isEmpty) {
      _errorTextName = "Name is required";
    }

    if (subjectCreditController.text.isEmpty) {
      _errorTextCredit = "Subject Credit is required";
    } else if (subjectCreditController.text.isNotEmpty) {
      try {
        if (int.parse(subjectCreditController.text) > 10) {
          _errorTextCredit = "Enter a valid credit";
        }
      } catch (e) {
        _errorTextCredit = "Enter a valid number";
      }
    }

    if (_errorTextName == null && _errorTextCredit == null) {
      return true;
    }
    return false;
  }

  void _removeSubjectData(Subject data) {
    setState(() {
      _subjectData.remove(data);
    });
  }

  void _toggleSidebarMenu() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  Future<void> _saveSGPAHistory(double sgpa, List<Subject> subjectData,
      double totalCredits, int totalSubjects, String averageGrade) async {
    try {
      // Convert Subject objects to a format Firebase can store
      final List<Map<String, dynamic>> serializedSubjects =
          subjectData.map((subject) {
        return {
          'id': subject.id,
          'name': subject.name,
          'credit': subject.credit,
          'grade': subject.grade,
          'gradePoint': subject.gradePoint,
        };
      }).toList();

      await FirebaseFirestore.instance
          .collection("Registered Users")
          .doc(widget.name)
          .collection("sgpa_history")
          .add({
        "sgpa": sgpa,
        "subject_data": serializedSubjects,
        "total_credits": totalCredits,
        "total_subjects": totalSubjects,
        "average_grade": averageGrade,
        "created_at": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Show error to user if Firebase save fails
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save SGPA history: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      // Re-throw to handle in calling function
      rethrow;
    }
  }

  Future<void> _calculateSGPA() async {
    try {
      double totalGradePoint = 0;
      double totalCredit = 0;
      for (var subject in _subjectData) {
        totalGradePoint +=
            double.parse(subject.gradePoint) * double.parse(subject.credit);
        totalCredit += double.parse(subject.credit);
      }
      double sgpa = totalGradePoint / totalCredit;
      final formattedSGPA = double.parse(sgpa.toStringAsFixed(2));

      // Calculate average grade letter based on SGPA
      String averageGrade = "F";
      if (formattedSGPA >= 8.5)
        averageGrade = "A+";
      else if (formattedSGPA >= 7.5)
        averageGrade = "A";
      else if (formattedSGPA >= 6.5)
        averageGrade = "B+";
      else if (formattedSGPA >= 5.5)
        averageGrade = "B";
      else if (formattedSGPA >= 4.5)
        averageGrade = "C";
      else if (formattedSGPA >= 4.0)
        averageGrade = "P";
      else
        averageGrade = "F";

      // Save to Firebase first
      await _saveSGPAHistory(
        formattedSGPA,
        _subjectData,
        totalCredit,
        _subjectData.length,
        averageGrade,
      );

      // Only navigate if Firebase save was successful
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SgpaDashboard(
              userName: widget.name,
              sgpaValue: formattedSGPA,
              totalSubjects: _subjectData.length,
              totalCredits: totalCredit,
              averageGrade: averageGrade,
              subjectData: _subjectData,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error calculating SGPA: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // App Bar
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.white,
                title: const Center(
                  child: Text(
                    "MySGPA Tracker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    isSidebarOpen ? Icons.close : Icons.list,
                    size: 24,
                  ),
                  onPressed: _toggleSidebarMenu,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      size: 20,
                    ),
                    onPressed: () {
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
              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Enter Subject Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      context.customTextField(
                        controller: subjectNameController,
                        errorText: _errorTextName,
                        labelText: "Subject Name",
                        prefixIcon: Icons.school,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        errorTextCredit: _errorTextName ?? "",
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: context.customTextField(
                              controller: subjectCreditController,
                              errorText: _errorTextCredit,
                              labelText: "Subject Credit",
                              prefixIcon: Icons.star,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              errorTextCredit: _errorTextCredit ?? "",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GradeDropdown(
                              onValueChange: (p0) => gradeValue = p0,
                              value: gradeValue,
                              label: "Select Grade",
                              items: AppData.gradeList,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formValidation()) {
                            addSubjectData();
                          }
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add Subject"),
                            SizedBox(width: 2),
                            Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SubjectListHeader(
                        onClear: () => setState(() {
                          _subjectData.clear();
                        }),
                      ),
                      Expanded(
                        child: ListedSubjects(
                          subjectData: _subjectData,
                          removeSubjectData: _removeSubjectData,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_subjectData.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please add at least one subject'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              _calculateSGPA();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Calculate SGPA"),
                              SizedBox(width: 4),
                              Icon(
                                Icons.calculate,
                                size: 14,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sidebar overlay
          if (isSidebarOpen)
            GestureDetector(
              onTap: _toggleSidebarMenu,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
            ),

          // Animated Sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: isSidebarOpen ? 0 : -MediaQuery.of(context).size.width * 0.65,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 0.65,
            child: SidebarMenu(
              userName: widget.name,
              onClose: _toggleSidebarMenu,
            ),
          ),
        ],
      ),
    );
  }
}
