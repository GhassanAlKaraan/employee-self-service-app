import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ess/read_leaves%20page/all_leaves_page.dart';
import '../login_register/components/my_button.dart';
import '../read_users page/all_users_page.dart';
import 'components/my_drawer.dart';
import 'home utilities/utility.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //utility
  final homeUtility = Utility();

  //Get info about the user
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //SIGN OUT method
    void firebaseLogout() {
      FirebaseAuth.instance.signOut();
    }

    void signOut() {
      homeUtility.showAlertDialog(context, firebaseLogout, "Logout");
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MyButton(
              onTap: () {
                homeUtility.goToPage(context, const AllUsersPage());
              },
              txt: "Fetch Users",
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              onTap: () {
                homeUtility.goToPage(context, const AllLeavesPage());
              },
              txt: "Fetch Leaves",
            ),
          ],
        ),
      ),
    );
  }
}
