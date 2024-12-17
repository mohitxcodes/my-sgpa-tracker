import 'package:flutter/material.dart';
import 'package:spga_cal/pages/home/home.page.dart';

class ListedSubjects extends StatefulWidget {
  const ListedSubjects(
      {super.key, required this.subjectData, required this.removeSubjectData});

  final List<Subject> subjectData;
  final Function(Subject) removeSubjectData;

  @override
  State<ListedSubjects> createState() => _ListedSubjectsState();
}

class _ListedSubjectsState extends State<ListedSubjects> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Added Subjects List",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red[400],
                ),
                onPressed: () {
                  setState(() {
                    widget.subjectData.clear();
                  });
                },
                child: Text("Clear All"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: widget.subjectData.isEmpty
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "No Subject Is Added",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.subjectData.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${index + 1}. ${widget.subjectData[index].name}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Credit : ${widget.subjectData[index].credit}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Grade : ${widget.subjectData[index].grade}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget
                                  .removeSubjectData(widget.subjectData[index]);
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 18,
                              color: Colors.red[400],
                            ),
                          )
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
