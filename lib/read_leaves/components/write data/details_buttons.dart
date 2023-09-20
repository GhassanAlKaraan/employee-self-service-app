import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/leaves_utils.dart';
import '../my_button_3.dart';

class DetailsButtons extends StatelessWidget {
  DetailsButtons({
    super.key,
    required this.isApproved,
    required this.documentId,
    required this.isExpired,
  });

  final String documentId; // Same as leave id
  final bool isExpired;

  final bool isApproved;
  final Utility utility = Utility();

  Future updateFirestoreApproved(String documentId, bool approval) async {
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
    //Handle buttons colors
    Color? approvedColor;
    Color? disapprovedColor;
    if (isExpired) {
      approvedColor = Colors.grey[500];
      disapprovedColor = Colors.grey[500];
    } else {
      if (isApproved) {
        approvedColor = Colors.grey[500];
        disapprovedColor = Colors.black;
      } else {
        disapprovedColor = Colors.grey[500];
        approvedColor = Colors.black;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            //Approve Button
            Expanded(
              child: MyButton3(
                onTap: () {
                  try {
                    if (isExpired) {
                      utility.showAlert(context, "Leave request is expired");
                    } else {
                      if (isApproved) {
                        utility.showAlert(context, "Leave Already Approved");
                      } else {
                        utility.showAlertDialog(context, () {
                          Navigator.of(context).pop();
                          updateFirestoreApproved(documentId, true);
                          utility.showSnackBar(context, "Done");
                        }, "Approve Leave");
                      }
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                txt: "Approve",
                color: approvedColor,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            //Disapprove button
            Expanded(
              child: MyButton3(
                onTap: () {
                  try {
                    if (isExpired) {
                      utility.showAlert(context, "Leave request is expired");
                    } else {
                      if (!isApproved) {
                        utility.showAlert(context, "Leave is not Approved");
                      } else {
                        utility.showAlertDialog(context, () {
                          Navigator.of(context).pop();
                          updateFirestoreApproved(documentId, false);
                          utility.showSnackBar(context, "Done");
                        }, "Disapprove Leave");
                      }
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                txt: "Disapprove",
                color: disapprovedColor,
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
                  : utility.showSnackBar(context, "Feature Coming Soon");
              // TODO: Remind Later here
            },
            txt: "Remind me Later 🕑",
            color: approvedColor,
          ))
        ]),
      ],
    );
  }
}
