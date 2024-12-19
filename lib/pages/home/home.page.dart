import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/data/data.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';
import 'package:my_sgpa_tracker/pages/about-us/about-us.modal.dart';
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

class _HomePageState extends State<HomePage> {
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController subjectCreditController = TextEditingController();
  final List<Subject> _subjectData = [];
  String gradeValue = "";
  String? _errorTextName;
  String? _errorTextCredit;

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
    }

    if (int.parse(subjectCreditController.text) > 10) {
      _errorTextCredit = "Enter a valid credit";
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                builder: (context) => const AboutUsModal(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
            const SizedBox(height: 10),
            context.customTextField(
              controller: subjectNameController,
              errorText: _errorTextName,
              labelText: "Subject Name",
              prefixIcon: Icons.subject,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              errorTextCredit: _errorTextName ?? "",
            ),
            const SizedBox(height: 20),

            // Row for Credits and Grade Text Fields
            Row(
              children: [
                Expanded(
                  child: context.customTextField(
                    controller: subjectCreditController,
                    errorText: _errorTextCredit,
                    labelText: "Subject Credit",
                    prefixIcon: Icons.done_all,
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
            const SizedBox(
              height: 20,
            ),
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
                    ),
                  ],
                )),

            // Subject List Header
            SubjectListHeader(
              onClear: () => setState(() {
                _subjectData.clear();
              }),
            ),
            // List of Subjects
            Expanded(
              child: ListedSubjects(
                subjectData: _subjectData,
                removeSubjectData: _removeSubjectData,
              ),
            ),
            const SizedBox(height: 50),
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
