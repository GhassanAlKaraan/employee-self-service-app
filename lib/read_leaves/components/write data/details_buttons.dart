import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/leaves_utils.dart';
import '../my_button_3.dart';

class DetailsButtons extends StatelessWidget {
  DetailsButtons({
    super.key,
    required this.isApproved,
    required this.documentId,
  });

  final String documentId; // Same as leave id

  final bool isApproved;
  final Utility utility = Utility();

  Future setApprove(String documentId, bool approval) async {
    final Map<String, dynamic> dataToUpdate = {
      'approved': approval,
    };
    try {
      await FirebaseFirestore.instance
          .collection('leave details')
          .doc(documentId)
          .update(dataToUpdate)
          .then((_) {
        print('Field updated successfully.'); //todo
      }).catchError((error) {
        print('Error updating field: $error'); //todo
      });
    } catch (e) {
      print("Something wrong happened."); //todo
    }
  }

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
                  try {
                    if (isApproved) {
                      utility.showSnackBar(context, "Leave Already Approved");
                    } else {
                      utility.showAlertDialog(context, () {
                        Navigator.of(context).pop();
                        setApprove(documentId, true);
                        utility.showSnackBar(context, "Done");
                      }, "Approve Leave");

                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                txt: "Approve",
                color: textColor,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: MyButton3(
                  onTap: () {
                    try {
                      if (!isApproved) {
                        utility.showSnackBar(context, "Leave is not Approved");
                      } else {
                        utility.showAlertDialog(context, () {
                          Navigator.of(context).pop();
                          setApprove(documentId, false);
                          utility.showSnackBar(context, "Done");
                        }, "Reject Leave");


                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  txt: "Reject",
                  //color: textColor,
                  color: Colors.black,
              ),
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
            txt: "Remind me Later 🕑",
            color: textColor,
          ))
        ]),
      ],
    );
  }
}
