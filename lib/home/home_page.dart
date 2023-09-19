import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/read_leaves/pages/leave_headers_page.dart';
import '../read_users page/all_users_page.dart';
import 'components/my_drawer.dart';
import 'utils/home_utils.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //utility
  final utility = Utility();

  //Get info about the user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //SIGN OUT method
    void firebaseLogout() {
      FirebaseAuth.instance.signOut();
    }

    void signOut() {
      utility.showAlertDialog(context, firebaseLogout, "Logout");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: user.displayName != null
            ? Text("Welcome ${user.displayName}")
            : Text("Welcome ${user.email}"),
        leading: Builder(
          builder: (context) {
            return IconButton(icon: const Icon(Icons.menu),
                onPressed: () {
              Scaffold.of(context).openDrawer();
            });
          }
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.dashboard_customize, size: 120,),
            const SizedBox(height: 10,),
            const Text("Dashboard (Coming Soon)", style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20,),
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('See all users'),
                subtitle: const Text('Fetch a list of all admins'),
                onTap: () {
                  utility.goToPage(context, const AllUsersPage());
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.time_to_leave_sharp),
                title: const Text('See all leaves requests'),
                subtitle: const Text('Pending and Accepted leave requests'),
                onTap: () {
                  utility.goToPage(context, const LeaveHeadersPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
