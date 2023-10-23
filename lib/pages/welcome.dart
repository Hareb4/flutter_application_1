// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/constants/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "welcome To Clubz",
              style: TextStyle(fontSize: 54),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.darkblue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 77, vertical: 13)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: Text(
                "Log in",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.sky),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 77, vertical: 13)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 24),
              ),
            ),
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
      ),
    );
  }
}
