// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'func.dart';

class HobbiesGrid extends StatefulWidget {
  @override
  _HobbiesGridState createState() => _HobbiesGridState();
}

String result = '';
String id = '';

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
              "what you intereset in :",
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
            Text(
              result,
              style: TextStyle(fontSize: 40, color: Colors.green),
            )
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
        body: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: clubs.length,
                            itemBuilder: (context, index) {
                              final club = clubs[index];
                              return GestureDetector(
                                onTap: () {
                                  id = club['Club_ID'];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClubPage()),
                                  );
                                  // Add your action here when the Container is pressed.
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    gradient: AppColor.linearGradient,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 16, left: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          club['Club_Name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.red),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                      ),
                      child: const Text(
                        "Go To Home",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ]),
            )));
  }
}

class RecClub extends StatefulWidget {
  @override
  _RecClub createState() => _RecClub();
}

class _RecClub extends State<RecClub> {
  List interests = [];
  TextEditingController bodyController = TextEditingController();
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
              "Recommended Clubs: ",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClubPage()),
                );
                // Add your action here when the Container is pressed.
              },
              child: Container(
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  gradient: AppColor.linearGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Main Text - Club Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Main Text - Club Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 37,
            ),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}
