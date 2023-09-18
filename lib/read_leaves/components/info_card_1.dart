import 'package:flutter/material.dart';

class InfoCard1 extends StatelessWidget {
  const InfoCard1(
      {super.key,
      required this.leaveId,
      required this.leaveReason,
      required this.employeeName,
      required this.leaveType});

  final leaveId, employeeName, leaveType, leaveReason;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Card elevation (shadow)
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave ID:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  'Employee:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Leave Type:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  'Reason:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leaveId,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  employeeName,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  leaveType,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  leaveReason,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
