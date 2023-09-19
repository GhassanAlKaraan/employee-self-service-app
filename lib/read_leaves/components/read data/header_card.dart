import 'package:flutter/material.dart';

import 'get_leave_header.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key, this.documentId});

  final documentId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Add shadow
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1.0), // Add border
        borderRadius: BorderRadius.circular(5.0), // Add rounded corners
      ),
      color: Colors.white, // Set background color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetLeaveId(documentId: documentId),
      ),
    );
  }
}