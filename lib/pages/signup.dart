// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/main.dart';

class Singup extends StatelessWidget {
  List joinedclubs = [];
  String name = "";
  String email = "";
  String password = "";
  String uni = "";
  Singup({super.key});

  get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up",
          style: TextStyle(
              fontSize: 30, fontFamily: "myfont", fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: AppColor.sky,
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                print("clicked swithc");
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
                print(MyApp.themeNotifier.value);
              })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.sky,
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: AppColor.darkblue,
                    ),
                    hintText: "Name :",
                    border: InputBorder.none),
                onChanged: (text) {
                  name = text; // Update the entered text
                },
              ),
            ),
            SizedBox(
              height: 23,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.sky,
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail,
                      color: AppColor.darkblue,
                      size: 19,
                    ),
                    hintText: "Email :",
                    border: InputBorder.none),
                onChanged: (value) {
                  // Print the entered text in the console
                  email = value;
                },
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.sky,
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                   
                    suffix: Icon(
                      Icons.visibility,
                      color: AppColor.darkblue,
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: AppColor.darkblue,
                      size: 19,
                    ),
                    hintText: "Password :",
                    border: InputBorder.none),
                onChanged: (value) {
                  password = value;
                  // Print the entered text in the console
                },
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.sky,
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.visibility,
                      color: AppColor.darkblue,
                    ),
                    icon: Icon(
                      Icons.school,
                      color: AppColor.darkblue,
                      size: 19,
                    ),
                    hintText: "University :",
                    border: InputBorder.none),
                onChanged: (value) {
                  uni = value;
                  // Print the entered text in the console
                },
              ),
            ),
            SizedBox(
              height: 17,
            ),
            ElevatedButton(
              
              onPressed: () {
                print("$name, $email, $password, $uni");
                createUesr();
                Navigator.pushNamed(context, "/rec");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.lightsky),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: const Text(
                "Sign up",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createUesr() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(name);

    Map<String, dynamic> users = {
      "name": name,
      "email": email,
      "password": password,
      "university_id": uni,
      "joined_clubs": joinedclubs
    };

    documentReference.set(users).whenComplete(() => {print("$name created")});
  }
}
