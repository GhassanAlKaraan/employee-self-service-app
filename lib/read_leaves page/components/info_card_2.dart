import 'package:flutter/material.dart';

class InfoCard2 extends StatelessWidget {
  const InfoCard2(
      {super.key,
      required this.fromDate,
      required this.toDate,
      required this.validBalance,
      required this.expired});

  final String fromDate, toDate; // TODO: change type to date
  final bool validBalance, expired;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Card elevation (shadow)
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'To:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fromDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          toDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                    const VerticalDivider(width: 2, thickness: 2,),
                    const SizedBox(
                      width: 5,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Days",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "5", // TODO: calculate the total days
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(height: 2, color: Colors.grey,),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valid Balance:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Expired:',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        validBalance.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        expired.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
