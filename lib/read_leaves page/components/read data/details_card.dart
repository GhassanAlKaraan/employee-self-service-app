import 'package:flutter/material.dart';

import '../info_card_1.dart';
import '../info_card_2.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard(
      {super.key,
      required this.leaveId,
      required this.empFirstName,
      required this.isExpired,
      required this.validBalance,
      required this.leaveReason,
      required this.isApproved,
      required this.leaveType,
      required this.toDate,
      required this.fromDate});

  final String leaveId; // Same as document id
  final String empFirstName;
  final bool isExpired;
  final bool validBalance;
  final String leaveReason;
  final bool isApproved;
  final String leaveType;
  final String toDate;
  final String fromDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isApproved ? "Pending Approval ❌" : "Approved ✔",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 25
        ),

        // First card
        InfoCard1(
            leaveId: leaveId,
            employeeName: empFirstName,
            leaveType: leaveType,
            leaveReason: leaveReason),
        const SizedBox(height: 20),
        // Second card
        InfoCard2(
          fromDate: fromDate,
          toDate: toDate,
          validBalance: validBalance,
          expired: isExpired,
          // TODO: Total days is missing
        ),
      ],
    );
  }
}
