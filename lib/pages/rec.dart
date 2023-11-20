// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'func.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

class HobbiesGrid extends StatefulWidget {
  @override
  _HobbiesGridState createState() => _HobbiesGridState();
}

String result = '';
String clubid = '';

class _HobbiesGridState extends State<HobbiesGrid> {
  List<String> selectedHobbies = [];
  List<String> btns = [
    "Arts",
    "Basketball",
    "Casual",
    "Cultural",
    "Economy",
    "Football",
    "Innovative",
    "Linguistic",
    "Media",
    "Medical",
    "Nature",
    "Science",
    "Self-growth",
    "Spiritual",
    "Sports",
    "Technology",
    "Volleyball",
    "Volunteering"
  ];

  List<bool> buttonEnabled = [true, true, true, true, true, true];
  String out_in = "";
  String url = '';
  var data;
  String output = 'Initial Output';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                }),
            Text(
              "choose :",
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 10,
            ),
            GroupButton(
              isRadio: true,
              onSelected: (String label, int index, bool isSelected) {
                print('$label button is selected');
                if (isSelected) {
                  // Add the selected hobby
                  if (selectedHobbies.isNotEmpty) {
                    selectedHobbies.removeAt(0);
                  }
                  selectedHobbies.add(label);
                } else {
                  // Remove the unselected hobby from the selection
                  selectedHobbies.remove(label);
                }
                print('Selected hobbies: $selectedHobbies');
              },
              buttons: ["Indoor", "Outdoor"],
              options: GroupButtonOptions(
                selectedShadow: const [],
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor.white, // Red text color for selected buttons
                ),
                selectedColor:
                    AppColor.sky, // White background color for selected buttons
                unselectedShadow: const [],
                unselectedColor: AppColor
                    .white, // White background color for unselected buttons
                unselectedTextStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor
                      .darkblue, // Black text color for unselected buttons
                ),
                selectedBorderColor:
                    AppColor.sky, // Red border color for selected buttons
                unselectedBorderColor: AppColor
                    .darkblue, // Black border color for unselected buttons
                borderRadius: BorderRadius.circular(20),
                spacing: 10,
                runSpacing: 10,
                groupingType: GroupingType.wrap,
                direction: Axis.horizontal,
                buttonHeight: 50,
                buttonWidth: 100,
                mainGroupAlignment: MainGroupAlignment.start,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                textPadding: EdgeInsets.zero,
                alignment: Alignment.center,
                elevation: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "choose your 4 interest: ",
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 10,
            ),
            GroupButton(
              isRadio: false, // Allow multiple selections
              onSelected: (String label, int index, bool isSelected) {
                if (isSelected) {
                  if (selectedHobbies.length >= 5) {
                    // If four options are already selected, don't allow more
                    return;
                  }
                  // Add the selected hobby
                  selectedHobbies.add(label);
                } else {
                  // Remove the unselected hobby from the selection
                  selectedHobbies.remove(label);
                }

                // Update the enabled state of buttons
                if (selectedHobbies.length >= 4) {
                  for (int i = 0; i < buttonEnabled.length; i++) {
                    if (!selectedHobbies.contains(btns[i])) {
                      // Disable buttons that are not selected
                      buttonEnabled[i] = false;
                    }
                  }
                } else {
                  // Enable all buttons if less than four options are selected
                  buttonEnabled = [true, true, true, true, true, true];
                }

                // You can now use the selectedHobbies list with the selected hobbies
                print('Selected hobbies: $selectedHobbies');
              },
              options: GroupButtonOptions(
                selectedShadow: const [],
                selectedTextStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor.white, // Red text color for selected buttons
                ),
                selectedColor:
                    AppColor.sky, // White background color for selected buttons
                unselectedShadow: const [],
                unselectedColor: AppColor
                    .white, // White background color for unselected buttons
                unselectedTextStyle: TextStyle(
                  fontSize: 20,
                  color: AppColor
                      .darkblue, // Black text color for unselected buttons
                ),
                selectedBorderColor:
                    AppColor.sky, // Red border color for selected buttons
                unselectedBorderColor: AppColor
                    .darkblue, // Black border color for unselected buttons
                borderRadius: BorderRadius.circular(20),
                spacing: 10,
                runSpacing: 10,
                groupingType: GroupingType.wrap,
                direction: Axis.horizontal,
                buttonHeight: 50,
                buttonWidth: 100,
                mainGroupAlignment: MainGroupAlignment.start,
                crossGroupAlignment: CrossGroupAlignment.start,
                groupRunAlignment: GroupRunAlignment.start,
                textAlign: TextAlign.center,
                textPadding: EdgeInsets.zero,
                alignment: Alignment.center,
                elevation: 0,
              ),

              buttons: [
                "Arts",
                "Basketball",
                "Casual",
                "Cultural",
                "Economy",
                "Football",
                "Innovative",
                "Linguistic",
                "Media",
                "Medical",
                "Nature",
                "Science",
                "Self-growth",
                "Spiritual",
                "Sports",
                "Technology",
                "Volleyball",
                "Volunteering"
              ], // Pass the buttonEnabled list to manage button enable/disable state
            ),
            SizedBox(
              height: 43,
            ),
            ElevatedButton(
              onPressed: () async {
                String query = jsonEncode(selectedHobbies);
                print(query);
                url = 'http://127.0.0.1:5000/pyml?query=$query';
                data = await fetchdata(url);
                var decoded = jsonDecode(data);
                setState(() {
                  result = decoded['output'];
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClubsPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.darkblue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 106, vertical: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: const Text(
                "Suprise me!",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClubsPage extends StatefulWidget {
  @override
  _ClubsPageState createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  final Stream<QuerySnapshot> _clubsStream = FirebaseFirestore.instance
      .collection('clubs')
      .where('Club_Category', isEqualTo: result)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                        }),
                    Text(
                      "Recommended Clubs: ",
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _clubsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final clubs = snapshot.data!.docs;

                          clubs.shuffle();
                          // Take the first 5 clubs from the shuffled list
                          final randomClubs = clubs.take(5).toList();

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: randomClubs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final club = randomClubs[index];
                              return GestureDetector(
                                onTap: () {
                                  clubid = club['Club_ID'];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClubPage(
                                              clubId: clubid,
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 51,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 20, right: 20, top: 0),
                                  child: Text(club['Club_Name']),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.red),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24))),
              ),
              child: const Text(
                "Go To Home",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ), // Adjust the color and opacity as needed
        ],
      ),
    );
  }
}
