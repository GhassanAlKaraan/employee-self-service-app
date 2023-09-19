import 'package:flutter/material.dart';

import '../../utils/leaves_utils.dart';
import '../my_button_3.dart';

class DetailsButtons extends StatelessWidget {
  DetailsButtons({
    super.key,
    required this.isApproved,
  });

  final bool isApproved;
  final Utility utility = Utility();

  @override
  Widget build(BuildContext context) {
    final Color? textColor = isApproved ? Colors.grey[500] : Colors.black;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: MyButton3(
                onTap: () {
                  isApproved
                      ? utility.showSnackBar(context, "Leave Already Approved")
                      : utility.showSnackBar(context, "Done");
                  // TODO: Approve Leave here
                },
                txt: "Approve",
                color: textColor,
              ),
            ),

            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: MyButton3(onTap: () {
                isApproved
                    ? utility.showSnackBar(context, "Leave Already Approved")
                    : utility.showSnackBar(context, "Done");
                // TODO: Reject Leave here
              }, txt: "Reject", color: textColor),
            ),

          ],
        ),
        const SizedBox(height: 25),
        Row(children: [
          Expanded(
              child: MyButton3(
            onTap: () {
              isApproved
                  ? utility.showSnackBar(context, "Leave Already Approved")
                  : utility.showSnackBar(context, "Done");
              // TODO: Remind Later here

            },
            txt: "Remind me Later",
            color: textColor,
          ))
        ]),
      ],
    );
  }
}
