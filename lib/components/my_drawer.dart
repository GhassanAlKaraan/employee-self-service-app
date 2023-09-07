import 'package:flutter/material.dart';
import 'package:new_ess/pages/all_users_page.dart';
import 'package:new_ess/utilities/utility.dart';

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
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    // Handle the tap event for Home
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Handle the tap event for Settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Chat'),
                  onTap: () {
                    // Handle the tap event for Chat
                  },
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[500],
                ),
                //See all users
                ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('All Users'),
                  onTap: () {
                    utility.goToPage(context, const AllUsersPage());
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
