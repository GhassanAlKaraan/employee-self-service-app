import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:new_ess/read_leaves%20page/components/read%20data/details_card.dart';
import 'package:new_ess/read_leaves%20page/read_leaves%20utilities/utility.dart';

import 'components/my_button_2.dart';

class LeaveDetailsPage extends StatefulWidget {
  const LeaveDetailsPage({super.key, required this.documentId});

  final String documentId; // Same as leave id

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  // Flag to track whether data is being loaded
  bool isLoading = true;
  bool isApproved = false;

  final utility = Utility();

  Map<String, dynamic>? myData; // Declare a variable to store the data

  Future<Map<String, dynamic>?> getData(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('leave details')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        return data;
      } else {
        utility.showSnackBar(context, "No Details for this leave!");
        return null;
      }
    } catch (e) {
      utility.showSnackBar(context, e.toString());
      return null;
    }
  }

  String convertFromDate(Map<String, dynamic> myData) {
    Timestamp fromDateTimestamp = myData['from date'];
    DateTime fromDateDateTime = fromDateTimestamp.toDate();
    String formattedFromDate =
        DateFormat('yyyy-MM-dd').format(fromDateDateTime);

    return formattedFromDate;
  }

  String convertToDate(Map<String, dynamic> myData) {
    Timestamp toDateTimestamp = myData['to date'];
    DateTime toDateDateTime = toDateTimestamp.toDate();
    String formattedToDate = DateFormat('yyyy-MM-dd').format(toDateDateTime);

    return formattedToDate;
  }

  @override
  void initState() {
    super.initState();
    // Call getData and update myData when data is fetched
    getData(widget.documentId).then((data) {
      setState(() {
        myData = data; // Update myData with the fetched data
        isLoading = false; // Set isLoading to false
        isApproved = myData!['approved'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isApproved? Colors.green: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Leave details:",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      DetailsCard(
                        toDate: convertToDate(myData!),
                        leaveId: widget.documentId,
                        empFirstName: myData!['employee first name'],
                        isExpired: myData!['expired'],
                        validBalance: myData!['valid balance'],
                        fromDate: convertFromDate(myData!),
                        leaveReason: myData!['reason'],
                        isApproved: myData!['approved'],
                        leaveType: myData!['type'],
                      ),

                      const SizedBox(height: 40),

                      // TODO: implement buttons functions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child:
                                      MyButton2(onTap: () {}, txt: "Approve")),
                              // TODO: change onTap
                              const SizedBox(
                                width: 25,
                              ),
                              Expanded(
                                  child:
                                      MyButton2(onTap: () {}, txt: "Reject")),
                              // TODO: change onTap
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
                  ),
                ),
        ),
      ),
    );
  }
}
