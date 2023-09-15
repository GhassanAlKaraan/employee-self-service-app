import 'package:flutter/material.dart';

import 'components/info_card_1.dart';
import 'components/info_card_2.dart';

class DetailsPageExample extends StatelessWidget {
  const DetailsPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70,),
        InfoCard1(leaveId: "000001", employeeName: "Ghassan Al Karaan", leaveType: "Annual", leaveReason: "Vacation"),
        SizedBox(height: 20,),
        InfoCard2(fromDate: "20 sep 2023", toDate: "25 sep 2023", validBalance: true, expired: false,),

      ],
    );
  }
}
