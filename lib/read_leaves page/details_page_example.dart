import 'package:flutter/material.dart';

import 'components/info_card_1.dart';
import 'components/info_card_2.dart';

class DetailsPageExample extends StatelessWidget {
  const DetailsPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pending Approval",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.circle)
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const InfoCard1(
            leaveId: "000001",
            employeeName: "Ghassan Al Karaan",
            leaveType: "Annual",
            leaveReason: "Vacation"),
        const SizedBox(
          height: 20,
        ),
        InfoCard2(
          fromDate: "20 sep 2023",
          toDate: "25 sep 2023",
          validBalance: true,
          expired: false,
        ),
      ],
    );
  }
}
