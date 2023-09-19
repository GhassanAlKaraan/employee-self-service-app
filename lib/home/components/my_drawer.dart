import 'package:flutter/material.dart';
import 'package:new_ess/read_leaves/pages/leave_headers_page.dart';

import '../../read_users page/all_users_page.dart';
import '../utils/home_utils.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  //Utility
  final utility = Utility();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset('assets/images/logos/gtsLogo.png'),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 12,
              children: [
                ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('Show All Users', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.pop(context);
                    utility.goToPage(context, const AllUsersPage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.time_to_leave),
                  title: const Text('Show All leaves', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Handle the tap event for this Tile
                    Navigator.pop(context);
                    utility.goToPage(context, const LeaveHeadersPage());
                  },
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[500],
                ),
                const SizedBox(height: 30,),
                const Text("Coming Soon", style: TextStyle(fontSize: 22)),
                const SizedBox(height: 50,),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Handle the tap event for Settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.time_to_leave_outlined),
                  title: const Text('Pending leaves', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    // Handle the tap event for this Tile
                  },
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
