import 'package:flutter/material.dart';
import 'package:flutter_application_1/dbHelper/mongodb.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:flutter_application_1/pages/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Welcome(),
        "/login": (context) => Login(),
        "/signup": (context) => Singup(),
        "/home": (context) => const Home(),
      },
    );
  }
}
