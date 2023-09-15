import 'package:flutter/material.dart';
import 'package:new_ess/login_register/components/my_button_2.dart';

import 'components/info_card_1.dart';
import 'components/info_card_2.dart';

class DetailsPageExample extends StatelessWidget {
  const DetailsPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status
        const SizedBox(
          height: 20,
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

        // First card
        const InfoCard1(
            leaveId: "000001",
            employeeName: "Ghassan Al Karaan",
            leaveType: "Annual",
            leaveReason: "Vacation"),
        const SizedBox(
          height: 20,
        ),

        // Second card
        const InfoCard2(
          fromDate: "20 sep 2023",
          toDate: "25 sep 2023",
          validBalance: true,
          expired: false,
        ),
        const SizedBox(
          height: 50,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyButton2(onTap: () {}, txt: "Approve"),
            MyButton2(onTap: () {}, txt: "Reject"),
          ],
        )
      ],
    );
  }
}
