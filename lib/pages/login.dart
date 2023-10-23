// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/main.dart';
import '../auth.dart';

class Login extends StatefulWidget {
  Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register insted' : 'Login insted'));
  }

  String enteredText = "";

  // Store the entered text here
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         "Log in",
    //         style: TextStyle(
    //           color: AppColor.white,
    //           fontSize: 30,
    //           fontFamily: "myfont",
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //       centerTitle: true,
    //       backgroundColor: AppColor.darkblue,
    //     ),
    //     body: SizedBox(
    //       width: double.infinity,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           IconButton(
    //               icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
    //                   ? Icons.dark_mode
    //                   : Icons.light_mode),
    //               onPressed: () {
    //                 print("clicked swithc");
    //                 MyApp.themeNotifier.value =
    //                     MyApp.themeNotifier.value == ThemeMode.light
    //                         ? ThemeMode.dark
    //                         : ThemeMode.light;
    //                 print(MyApp.themeNotifier.value);
    //               }),
    //           Container(
    //             decoration: BoxDecoration(
    //               color: AppColor.sky,
    //               borderRadius: BorderRadius.circular(66),
    //             ),
    //             width: 266,
    //             padding: EdgeInsets.symmetric(horizontal: 16),
    //             child: TextField(
    //               decoration: InputDecoration(
    //                   icon: Icon(
    //                     Icons.person,
    //                     color: AppColor.darkblue,
    //                   ),
    //                   hintText: "Your Email :",
    //                   border: InputBorder.none),
    //               onChanged: (text) {
    //                 enteredText = text; // Update the entered text
    //               },
    //             ),
    //           ),
    //           SizedBox(
    //             height: 23,
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //               color: AppColor.sky,
    //               borderRadius: BorderRadius.circular(66),
    //             ),
    //             width: 266,
    //             padding: EdgeInsets.symmetric(horizontal: 16),
    //             child: TextField(
    //               obscureText: true,
    //               decoration: InputDecoration(
    //                   suffix: Icon(
    //                     Icons.visibility,
    //                     color: AppColor.darkblue,
    //                   ),
    //                   icon: Icon(
    //                     Icons.lock,
    //                     color: AppColor.darkblue,
    //                     size: 19,
    //                   ),
    //                   hintText: "Password :",
    //                   border: InputBorder.none),
    //               onChanged: (value) {
    //                 // Print the entered text in the console
    //               },
    //             ),
    //           ),
    //           SizedBox(
    //             height: 17,
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.pushNamed(context, "/home");
    //               print("$enteredText");
    //             },
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.all(AppColor.lightsky),
    //               padding: MaterialStateProperty.all(
    //                   EdgeInsets.symmetric(horizontal: 106, vertical: 10)),
    //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(27))),
    //             ),
    //             child: Text(
    //               "login",
    //               style: TextStyle(fontSize: 24, color: Colors.black),
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //   );
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', email),
            _entryField('password', password),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton()
          ],
        ),
      ),
    );
  }
}
