import 'package:flutter/material.dart';
import 'package:new_ess/read_leaves page/components/my_button_2.dart';

import 'components/info_card_1.dart';
import 'components/info_card_2.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key});

  // TODO: require the document ID, and implement firestore Read function to fetch data

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
              "Pending Approval", // TODO: change
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            leaveId: "000001", // TODO: change
            employeeName: "Ghassan Al Karaan", // TODO: change
            leaveType: "Annual", // TODO: change
            leaveReason: "Vacation"), // TODO: change
        const SizedBox(
          height: 20,
        ),

        // Second card
        const InfoCard2(
          fromDate: "20 sep 2023", // TODO: change
          toDate: "25 sep 2023", // TODO: change
          validBalance: true, // TODO: change
          expired: false, // TODO: change
        ),
        const SizedBox(
          height: 40,
        ),

        //TODO: implement buttons functions
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: MyButton2(onTap: () {}, txt: "Approve")),
                // TODO: change
                const SizedBox(
                  width: 25,
                ),
                Expanded(child: MyButton2(onTap: () {}, txt: "Reject")),
                // TODO: change
              ],
            ),
            const SizedBox(height: 25),
            Row(children: [
              Expanded(
                  child: MyButton2(
                onTap: () {},
                txt: "Remind me Later",
              ))
            ]),
          ],
        )
      ],
    );
  }
}
