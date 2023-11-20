import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/rec.dart';
import 'package:flutter_application_1/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'widget_tree.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier<ThemeMode>(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);
  // Replace with your desired color value
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    hintColor: AppColor.red,
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      primary: AppColor.darkblue,
      secondary: AppColor.lightsky,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    hintColor: AppColor.red,
    colorScheme: ColorScheme.dark(
      primary: AppColor.sky,
      secondary: AppColor.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: '',
            theme: ThemeData(
                useMaterial3: true,
                fontFamily: 'Raleway',
                primarySwatch: Colors.teal,
                appBarTheme: AppBarTheme(color: AppColor.darkblue)),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            initialRoute: "/",
            routes: {
              "/": (context) => const WidgetTree(),
              "/login": (context) => Login(),
              "/home": (context) => Home(),
              "/rec": (context) => HobbiesGrid(),
            },
            // home: const WidgetTree(),
          );
        });
  }
}
