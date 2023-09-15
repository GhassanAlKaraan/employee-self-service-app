import 'package:flutter/material.dart';
import 'package:new_ess/read_leaves page/components/my_button_2.dart';

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
          height: 40,
        ),

        //TODO: implement buttons functions
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: MyButton2(onTap: () {}, txt: "Approve")),
                const SizedBox(
                  width: 25,
                ),
                Expanded(child: MyButton2(onTap: () {}, txt: "Reject")),
              ],
            ),
            // Row(children: [
            //   Expanded(
            //       child: MyButton2(
            //     onTap: () {},
            //     txt: "Remind me Later",
            //   ))
            // ]),
            SizedBox(height: 25,),

            Row(children:[Expanded(child: MyButton2(onTap: (){}, txt: "Remind me Later",))]),

          ],
        )
      ],
    );
  }
}
