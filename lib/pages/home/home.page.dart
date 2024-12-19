import 'package:flutter/material.dart';
import 'package:spga_cal/pages/about-us/about-us.modal.dart';
import 'package:spga_cal/pages/home/home-ui/grade.dropdown.dart';
import 'package:spga_cal/pages/home/home-ui/list-subjects.dart';
import 'package:spga_cal/pages/spg-dashboard/sgpa-dashboard.page.dart';

class Subject {
  final int id;
  final String name;
  final String credit;
  final String gradePoint;
  final String grade;

  Subject({
    required this.id,
    required this.name,
    required this.credit,
    required this.gradePoint,
    required this.grade,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});
  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController subjectCreditController = TextEditingController();
  final List<Subject> _subjectData = [];
  String gradeValue = "";
  String? _errorTextName;
  String? _errorTextCredit;

  void setGradeValue(String value) {
    setState(() {
      gradeValue = value;
    });
  }

  void addSubjectData() {
    if (subjectNameController.text.isEmpty ||
        subjectCreditController.text.isEmpty ||
        gradeValue == "") {
      setState(() {
        if (subjectNameController.text.isEmpty) {
          _errorTextName = "Name is required";
        }
        if (subjectCreditController.text.isEmpty) {
          _errorTextCredit = "Subject Credit is required";
        } else if (int.parse(subjectCreditController.text) > 10) {
          _errorTextCredit = "Enter a valid credit";
        }

        if (gradeValue == "") {
          // _errorText = "Please fill in all fields";
        }
      });

      return;
    }
    setState(() {
      _errorTextName = null;
      _errorTextCredit = null;
    });

    setState(() {
      _subjectData.add(
        Subject(
          id: _subjectData.length + 1,
          name: subjectNameController.text,
          credit: subjectCreditController.text,
          grade: gradeValue,
          gradePoint: findGradePoint(gradeValue),
        ),
      );
      subjectNameController.clear();
      subjectCreditController.clear();
      gradeValue = "";
    });
  }

  void _removeSubjectData(Subject data) {
    setState(() {
      _subjectData.remove(data);
    });
  }

  String findGradePoint(String gradeVal) {
    if (gradeVal == "A+") {
      return "10";
    } else if (gradeVal == "A") {
      return "9";
    } else if (gradeVal == "B+") {
      return "8";
    } else if (gradeVal == "B") {
      return "7";
    } else if (gradeVal == "C+") {
      return "6";
    } else if (gradeVal == "C") {
      return "5";
    } else if (gradeVal == "D") {
      return "4";
    } else {
      return "0";
    }
  }

  void _calculateSGPA() {
    double totalGradePoint = 0;
    double totalCredit = 0;
    for (var subject in _subjectData) {
      totalGradePoint +=
          double.parse(subject.gradePoint) * double.parse(subject.credit);
      totalCredit += double.parse(subject.credit);
    }
    double sgpa = totalGradePoint / totalCredit;

    //Opening The SGPADashboard Page
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SgpaDashboard(
                  sgpaValue: double.parse(sgpa.toStringAsFixed(2)),
                  totalSubjects: _subjectData.length,
                  totalCredits: totalCredit,
                  averageGrade: totalGradePoint.toString(),
                  subjectData: _subjectData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "MySGPA Tracker",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              size: 20,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AboutUsModal(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hello, ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                            ),
                          ),
                          TextSpan(
                            text: widget.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.red[400],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const TextSpan(
                            text: " 👋",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: subjectNameController,
                    cursorColor: Colors.black,
                    cursorRadius: const Radius.circular(50),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.library_books,
                        size: 20,
                      ),
                      errorText: _errorTextName,
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
                      label: const Text(
                        "Enter Subject Name",
                        style: TextStyle(
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Row for Credits and Grade Text Fields
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: subjectCreditController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          cursorRadius: const Radius.circular(50),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.done_all,
                              size: 20,
                            ),
                            errorText: _errorTextCredit,
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
                            label: const Text(
                              "Subject Credit",
                              style: TextStyle(
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
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GradeDropdown(
                          setGradeValue: setGradeValue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addSubjectData();
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
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),

                  // List of Subjects
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 0
                        ? MediaQuery.of(context).size.height * 0.18
                        : MediaQuery.of(context).size.height * 0.48,
                    child: ListedSubjects(
                        subjectData: _subjectData,
                        removeSubjectData: _removeSubjectData),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              if (_subjectData.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please add at least one subject'),
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
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Calculate SGPA"), Icon(Icons.calculate)],
            ),
          ),
        ),
      ),
    );
  }
}
