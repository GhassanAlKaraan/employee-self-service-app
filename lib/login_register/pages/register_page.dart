import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/continue_with_google.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/signin_now_member.dart';
import '../login_register utilities/utility.dart';

class RegisterPage extends StatefulWidget {
  //onTap Function for the clickable "Login now" Text
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Snack instance
  var utility = Utility();

  //Text fields controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  //dispose text fields
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  //Register User
  //TODO: Don't let the user register more than x times a day, to prevent abuse
  //TODO: User must validate email address before logging in
  //TODO: Password and Email validations separate from the sign up, remove some pressure off the signUp method

  Future signUp() async {

    //Validate user info
    if(!isInfoNotEmpty()){
      return;
    }

    //Show loading animation
    utility.showLoading(context);

    //Create user and authenticate
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        utility.showSnackBar(context, "Passwords do not match!");
        //Stop loading animation
        Navigator.pop(context);
        return;
      }
    } on FirebaseAuthException catch(e){
      utility.showSnackBar(context, "${e.message}");
      //Stop loading animation
      Navigator.pop(context);
      return;
    }
    //Stop loading animation
    Navigator.pop(context);

    // add users details to firestore
    try{
      await addUserDetails(nameController.text.trim(), emailController.text.trim());
    } catch(e){
      utility.showSnackBar(context, e.toString());
    }
  }

  // TODO - manage - FIRESTORE CRUD: add data to firestore
  // NOTE: the firebase handles the uniqueness of each user by their email
  Future<void> addUserDetails(String name, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
      });
    } catch (e) {
      utility.showSnackBar(context, e.toString());
    }
  }


  bool isInfoNotEmpty(){
    if(nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty){
      utility.showSnackBar(context, "Fields can not be empty!");
      return false;
    }else{
      return true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Logo
                const SizedBox(height: 20),
                const Image(
                    image: AssetImage(
                      'assets/images/logos/gtsLogo.png',
                    ),
                    height: 100),

                //welcome message
                const SizedBox(height: 20),
                const Text("Let's make an account for you!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),

                // Username text field
                const SizedBox(height: 30),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                // email text field
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),

                // password text field
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                // confirm password text field
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                // Sign in button
                const SizedBox(height: 20),
                MyButton(
                  onTap: signUp,
                  txt: "Sign Up",
                ),

                //or continue with
                const SizedBox(height: 20),
                const ContinueGoogle(),

                // not a member? register now
                const SizedBox(height: 20),
                GestureDetector(onTap: widget.onTap, child: const LoginNow()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
