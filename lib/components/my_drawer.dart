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
            decoration: BoxDecoration(
              color: Colors.red[900],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/logos/google.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
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
          Divider(thickness: 1.0,color: Colors.grey[400],),
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
    );
  }
}
