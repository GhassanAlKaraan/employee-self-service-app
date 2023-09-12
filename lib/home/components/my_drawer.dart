import 'package:flutter/material.dart';

import '../../read_users page/all_users_page.dart';
import '../home utilities/utility.dart';

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
                  title: const Text('Show All Users'),
                  onTap: () {
                    Navigator.pop(context);
                    utility.goToPage(context, const AllUsersPage());
                  },
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[500],
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings (Coming Soon)'),
                  onTap: () {
                    // Handle the tap event for Settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Chat (Coming Soon)'),
                  onTap: () {
                    // Handle the tap event for Chat
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
