import 'package:flutter/material.dart';
import 'package:my_sgpa_tracker/models/subject_item.model.dart';

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Added Subjects",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.subjectData.clear();
                });
              },
              icon: const Icon(Icons.delete_sweep, size: 20),
              label: const Text("Clear All"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: widget.subjectData.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.library_books_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "No Subjects Added Yet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: widget.subjectData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${index + 1}.",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.subjectData[index].name.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      "Credit: ${widget.subjectData[index].credit}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Grade: ${widget.subjectData[index].grade}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget
                                  .removeSubjectData(widget.subjectData[index]);
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.red[400],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
