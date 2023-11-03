// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:io";
import 'package:flutter_application_1/pages/rec.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/widget_tree.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'func.dart';
import '../components/component.dart';
import 'dart:async';

User? user = FirebaseAuth.instance.currentUser;

String result = '';
String id = '';
int postid = 0;

String? username;
String? email;
String? universityId;
String? sex;
List<String>? joinedClubs;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  // final User? user = Auth().currentUser;

  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }

  // Widget _userUid() {
  //   return Text(user?.email ?? 'User email');
  // }

  // Widget _signOutButton() {
  //   return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  // }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Loadingpage(),
    ClubsScreen(),
    ProfileScreen(),
    ClubPage(
      clubId: id,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clubz",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.darkblue,
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove the default back arrow
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
        elevation: 0,
      ),
      body: _tabs[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.thumb_up),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  @override
  void initState() {
    super.initState();
    fetchall();
  }

  Future<void> fetchall() async {
    result = '';
    id = '';
    postid = 0;

    username = '';
    email = '';
    universityId = '';
    sex = '';
    joinedClubs = [];
    final fetchedUsername = await getUsername();
    final fetchEmail = await getEmail();
    final fetchUniId = await getUniversityId();
    final fetchSex = await getSex();
    final fetchJoinedClubs = await getjoinedClubs();

    setState(() {
      username = fetchedUsername;
      print('in setState username = $username');
      email = fetchEmail;
      print('in setState email = $email');
      universityId = fetchUniId;
      print('in setState universityId = $universityId');
      sex = fetchSex;
      print('in setState sex = $sex');
      joinedClubs = fetchJoinedClubs;
      print('in setState joined clubs = $joinedClubs');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (joinedClubs!.isNotEmpty) {
      print('before home screen = $joinedClubs');
      return HomeScreen();
    } else {
      return CircularProgressIndicator();
    }
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchall();
  // }

  // Future<void> fetchall() async {
  //   final fetchedUsername = await getUsername();
  //   final fetchEmail = await getEmail();
  //   final fetchUniId = await getUniversityId();
  //   final fetchSex = await getSex();
  //   final fetchJoinedClubs = await getjoinedClubs();

  //   setState(() {
  //     username = fetchedUsername;
  //     print('in setState username = $username');
  //     email = fetchEmail;
  //     print('in setState email = $email');
  //     universityId = fetchUniId;
  //     print('in setState universityId = $universityId');
  //     sex = fetchSex;
  //     print('in setState sex = $sex');
  //     joinedClubs = fetchJoinedClubs;
  //     print('in setState joined clubs = $joinedClubs');
  //   });
  // }

  final Stream<QuerySnapshot> _clubsSnapshots = FirebaseFirestore.instance
      .collection('clubs')
      .where('Club_ID', arrayContainsAny: joinedClubs)
      .snapshots();

  final Stream<QuerySnapshot> _publicEvents = FirebaseFirestore.instance
      .collection('event')
      .where('isPublic', isEqualTo: "true")
      .snapshots();

  final Stream<QuerySnapshot> _privateEventsSnapshots = FirebaseFirestore
      .instance
      .collection('event')
      .where('isPublic', isEqualTo: 'false')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    print('after go home screen = $joinedClubs');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi ${username}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Events For Everyone!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                    )),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _publicEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data!.docs;
                  print(events.length);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      print(event['Event_Name']);
                      return GestureDetector(
                        onTap: () {
                          // Add your action here when the Container is pressed.
                        },
                        child: Container(
                          margin: EdgeInsets.all(15),
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColor.sky,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 16, left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['Event_Name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF22005d),
                                  ),
                                ),
                                Text(
                                  event['Event_Date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF22005d),
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
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
              // Add margin on the left
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your events',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('event')
                  .where('isPublic', isEqualTo: 'false')
                  .where('Club_ID', whereIn: joinedClubs)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While data is loading, show a loading indicator.
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final events = snapshot.data!.docs;
                    if (events.isEmpty) {
                      return Text('No clubs found.');
                    }
                    print('events.length = ${events.length}');
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        // print(club['Club_Name']);
                        // print(club['Club_ID']);
                        // print(joinedClubs?[0]);
                        // print(club['Club_ID'] == joinedClubs?[0]);
                        // joinedClubs!.contains(event['Club_ID'])
                        if (true) {
                          return GestureDetector(
                            onTap: () {
                              // Add your action here when the Container is pressed.
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColor.sky,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event['Event_Name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF22005d),
                                      ),
                                    ),
                                    Text(
                                      event['Event_description'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF22005d),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
              // Add margin on the left
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Clubs',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('clubs')
                  .where('Club_ID', whereIn: joinedClubs)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('joinedclubs after snapshot $joinedClubs');
                  print('snapshot ${snapshot.data!.docs}');
                  final clubs = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: clubs.length,
                    itemBuilder: (context, index) {
                      final club = clubs[index];
                      // print(club['Club_Name']);
                      // print(club['Club_ID']);
                      print(joinedClubs?[0]);
                      // print(club['Club_ID'] == joinedClubs?[0]);
                      // var art = joinedClubs!.contains(club['Club_ID']);
                      if (true) {
                        return GestureDetector(
                          onTap: () {
                            // Add your action here when the Container is pressed.
                          },
                          child: Container(
                            margin: EdgeInsets.all(15),
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColor.sky,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 16, left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    club['Club_Name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF22005d),
                                    ),
                                  ),
                                  Text(
                                    club['Club_Description'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF22005d),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(); // Return an empty container instead of null
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ClubsScreen extends StatefulWidget {
  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  final Stream<QuerySnapshot> _clubsStream =
      FirebaseFirestore.instance.collection('clubs').snapshots();

  String searchText = '';
  String selectedCategory = '';
  Stream<QuerySnapshot> streamQuery =
      FirebaseFirestore.instance.collection('clubs').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20), // Add space at the top
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(66),
                        border: Border.all(width: 1, color: AppColor.darkblue)),
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: TextStyle(color: AppColor.darkblue),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: AppColor.darkblue,
                          ),
                          hintText: "hareb",
                          fillColor: AppColor.darkblue,
                          border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          streamQuery = FirebaseFirestore.instance
                              .collection('clubs')
                              .where('Club_Name',
                                  isGreaterThanOrEqualTo:
                                      searchText.toLowerCase())
                              .where('Club_Name',
                                  isLessThan: '${searchText.toLowerCase()}z')
                              .snapshots();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center children vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0), // Add margin to create space
                      child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(100, 20)), // Width and height values
                        ),
                        child: Row(
                          children: [
                            Text("sports"),
                          ],
                        ),
                        onPressed: () {
                          selectedCategory = 'Sports';
                          // Do something when the button is pressed.
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0), // Add margin to create space
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Text("Social"),
                          ],
                        ),
                        onPressed: () {
                          selectedCategory = 'Social';
                          // Do something when the button is pressed.
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0), // Add margin to create space
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Text("Educational"),
                          ],
                        ),
                        onPressed: () {
                          selectedCategory = 'Educational';
                          // Do something when the button is pressed.
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  margin: EdgeInsets.all(8.0), // Add margin to create space
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size(100, 20)), // Width and height values
                    ),
                    child: Row(
                      children: [
                        Text("recomend me club"),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HobbiesGrid()),
                      );
                      // Do something when the button is pressed.
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: streamQuery,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final clubs = snapshot.data!.docs;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final club = clubs[index];

                      return GestureDetector(
                        onTap: () {
                          id = club['Club_ID'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClubPage(
                                      clubId: id,
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
                      // } else {
                      //   return Container();
                      // }
                    },
                    childCount: clubs.length,
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                    child: Text('Error: ${snapshot.error}'));
              } else {
                return SliverToBoxAdapter(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

// final User? user = Auth().currentUser;

class _ProfileScreen extends State<ProfileScreen> {
  File? imagePicked;
  TextEditingController nameController = TextEditingController();

  void gallaryImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imagePicked = pickedImageFile;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      print('why? ');
      await Auth().signOut();
      Navigator.pushNamed(context, '/');
      print(FirebaseAuth.instance.currentUser);
    }

    Widget _userUid() {
      return Text(user?.email ?? 'User email');
    }

    Widget _signOutButton() {
      return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter, // Give it the alignment you need
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 69,
                          backgroundImage: imagePicked == null
                              ? null
                              : FileImage(
                                  imagePicked!,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 90,
                      top: 90,
                      child: RawMaterialButton(
                        fillColor: Theme.of(context).backgroundColor,
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose Option',
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton.icon(
                                        onPressed: gallaryImage,
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        icon: Icon(Icons.image),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe', // Replace with the user's name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Web Developer', // Replace with the user's occupation
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Text("hareb"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'New Event',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextField(
                                        controller: nameController,
                                        decoration:
                                            InputDecoration(labelText: 'Name'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Get values from text fields and isPublic checkbox
                                          gallaryImage();
                                        },
                                        child: Text('Add image'),
                                      ),
                                      SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // Get values from text fields and isPublic checkbox
                                        },
                                        child: Text('Edit profile'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                  child: Text('Edit Profile'),
                ),
                SizedBox(
                  height: 8,
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center children vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.0), // Add margin to create space
                      child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(87, 20)), // Width and height values
                        ),
                        child: Row(
                          children: [
                            Text("Clubs"),
                          ],
                        ),
                        onPressed: () {
                          // Do something when the button is pressed.
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0), // Add margin to create space
                      child: ElevatedButton(
                        child: Row(
                          children: [
                            Text("Events"),
                          ],
                        ),
                        onPressed: () {
                          // Do something when the button is pressed.
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  width: 350,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
                SizedBox(height: 5),
                _signOutButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClubPage extends StatefulWidget {
  final String clubId;

  ClubPage({required this.clubId});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  String? type;

  Widget _typeDropdown() {
    return DropdownButton<String>(
      value: type,
      items: <String>['Social', 'Sports', 'Educational']
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          type = value;
          print(type);
        });
      },
      hint: Text('Select Type'),
    );
  }

  Future<void> createEvent() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("event").doc();

    Map<String, dynamic> event = {
      "Event_Title": titleController.text,
      "Event_Description": descriptionController.text,
      "Event_Type": type,
      "Event_Place": placeController.text,
      "Club_ID": id,
      "Event_Date": dateController.text,
      "isPublic": isPublic,
    };

    documentReference.set(event);
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isPublic = false;
  bool isAuth = false;

  @override
  final Stream<QuerySnapshot> _clubInfo = FirebaseFirestore.instance
      .collection('clubs')
      .where('Club_ID', isEqualTo: id)
      .snapshots();

  final Stream<QuerySnapshot> _eventsStream = FirebaseFirestore.instance
      .collection('event')
      .where('Club_ID', isEqualTo: id)
      .snapshots();

  Future<void> _updateJoinedClubs(String newClubId) async {
    // Get the user document.
    final userDocument = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();

    // Get the joinedClubs list from the user document.

    // Add the new club ID to the joinedClubs list.
    joinedClubs!.add(id);

    // Update the user document with the new joinedClubs list.
    await FirebaseFirestore.instance.collection('users').doc(username).update({
      'joined_clubs': joinedClubs,
    });
  }

  Widget build(BuildContext context) {
    String clid = widget.clubId;

    print("club id = $clid");
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('clubs')
          .where('Club_ID', isEqualTo: clid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final clubInfo =
              snapshot.data!.docs[0].data() as Map<String, dynamic>;

          if (isAuth) {
            setState(() {
              isAuth = false; // Or true, depending on your condition
            });
          }

          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                backgroundColor: AppColor.sky,
                title: Text(clubInfo['Club_Name']),
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
                      }),
                  if (!joinedClubs!.contains(clid))
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        joinedClubs!.add(clid);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .update({
                          'joined_clubs': joinedClubs,
                        });
                        setState(() {});
                      },
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        print('logout email');
                        print(clid);
                        joinedClubs!.remove(clid);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .update({
                          'joined_clubs': joinedClubs,
                        });
                        setState(() {});
                      },
                    ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Information',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: 350,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 113, 95, 162),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, left: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Admin',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Ahmed Ali',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                width: 350,
                                                                height: 70,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          113,
                                                                          95,
                                                                          162),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              16,
                                                                          left:
                                                                              16),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'hareb omar',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                width: 350,
                                                                height: 70,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          113,
                                                                          95,
                                                                          162),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              16,
                                                                          left:
                                                                              16),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Ahmed Ali',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    );
                                                  });
                                                });
                                            // Add your action here when the Container is pressed.
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            width: 350,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 113, 95, 162),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16, left: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Members',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    '12',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: 350,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 113, 95, 162),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, left: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Moderater',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Ahmed Ali',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Juma ahmed',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: 350,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 113, 95, 162),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, left: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tags',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Thinking money language',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });

                      // Info button action
                    },
                  ),
                ],
              ),
              body: CustomScrollView(slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForumPage()),
                        );
                        // Add your action here when the Container is pressed.
                      },
                      child: Container(
                        margin: EdgeInsets.all(16),
                        width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Forum',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                StreamBuilder<QuerySnapshot>(
                  stream: _eventsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final events = snapshot.data!.docs;
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final event =
                                events[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                // Add your action here when the Container is pressed.
                              },
                              child: EventCard(
                                  id: event['Club_ID'],
                                  name: event['Event_Name'],
                                  description: event['Event_description'],
                                  date: event['Event_Date'],
                                  time: '25:00'),
                            );
                          },
                          childCount: events.length,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return SliverToBoxAdapter(
                          child: Text('Error: ${snapshot.error}'));
                    } else {
                      return SliverToBoxAdapter(
                          child: CircularProgressIndicator());
                    }
                  },
                ),
              ]),
              floatingActionButton: isAuth
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'New Event',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: titleController,
                                            decoration: InputDecoration(
                                                labelText: 'Title'),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                                labelText: 'Date'),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: placeController,
                                            decoration: InputDecoration(
                                                labelText: 'Place'),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                                labelText: 'Description'),
                                          ),
                                          SizedBox(height: 16),
                                          _typeDropdown(),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isPublic
                                                  ? Color.fromARGB(
                                                      255, 56, 24, 66)
                                                  : Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isPublic = !isPublic;
                                                print(isPublic);
                                              });
                                            },
                                            child: Text('Public: $isPublic',
                                                style: TextStyle(
                                                  color: isPublic
                                                      ? Colors.white
                                                      : Color.fromARGB(
                                                          255, 56, 24, 66),
                                                )),
                                          ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Get values from text fields and isPublic checkbox
                                              createEvent();

                                              // Close the bottom sheet
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Add event'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      },
                      label: const Text('Add event'),
                      icon: const Icon(Icons.add),
                    )
                  : null);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(child: Text('Error: ${snapshot.error}'));
        } else {
          return SliverToBoxAdapter(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  late final File imageFile;

  final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance
      .collection('post')
      .where('Club_ID', isEqualTo: id)
      .snapshots();

  Future<int> getLastPostId() async {
    final CollectionReference postCollection =
        FirebaseFirestore.instance.collection('post');
    final QuerySnapshot<Object?> lastPostSnapshot = await postCollection
        .orderBy('Post_ID', descending: true)
        .limit(1)
        .get();

    if (lastPostSnapshot.docs.isNotEmpty) {
      print('last post id = ${lastPostSnapshot.docs.first.get('Post_ID')}');
      return lastPostSnapshot.docs.first.get('Post_ID') as int;
    } else {
      return 0;
    }
  }

  Future<void> createPost4() async {
    int newPostid = await getLastPostId();
    print(newPostid);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("post").doc();

    Map<String, dynamic> newpost = {
      "Post_Title": title.text,
      "Post_Content": content.text,
      "Author_ID": email,
      "Post_Date": DateTime.now().toString(),
      "Username": username,
      "Post_ID": newPostid + 1,
      "Club_ID": id,
    };

    // Add the new post to the collection
    print(newpost);
    await documentReference.set(newpost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.sky,
            title: Text('Forum'),
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
                  }),
            ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Posts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _postsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return GestureDetector(
                          onTap: () {
                            postid = post['Post_ID'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostPage()),
                            );
                            // Add your action here when the Container is pressed.
                          },
                          child: ForumPostCard(
                            username: post['Username'],
                            title: post['Post_Title'],
                            body: post['Post_Content'],
                            date: post['Post_Date'],
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
              )
            ],
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton.extended(
            onPressed: () async {
              // Add your onPressed code here!
              await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'New Post',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  controller: title,
                                  decoration:
                                      InputDecoration(labelText: 'Title'),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  controller: content,
                                  decoration:
                                      InputDecoration(labelText: 'Content'),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Get values from text fields and isPublic checkbox
                                    createPost4();

                                    // Do something with the values
                                    print('Title: $title');
                                    print('Description: $content');

                                    // Close the bottom sheet
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Add post'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  });
            },
            label: const Text('Add post'),
            icon: const Icon(Icons.add),
          ),
          SizedBox(height: 5),
          FloatingActionButton.extended(
            onPressed: () async {
              var collection = FirebaseFirestore.instance
                  .collection('post')
                  .where('Club_ID', isEqualTo: id);
              var snapshots = await collection.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
              setState(() {});
            },
            label: const Text('delete posts'),
            icon: const Icon(Icons.delete),
            backgroundColor: AppColor.red,
          ),
        ]));
  }
}

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final Stream<QuerySnapshot> _postinfo = FirebaseFirestore.instance
      .collection('post')
      .where('Club_ID', isEqualTo: id)
      .where('Post_ID', isEqualTo: postid)
      .snapshots();

  final Stream<QuerySnapshot> _commentsStream = FirebaseFirestore.instance
      .collection('comment')
      .where('Club_ID', isEqualTo: id)
      .where('Post_ID', isEqualTo: postid)
      .snapshots();

  TextEditingController bodyController = TextEditingController();

  Future<int> getLastCommentId() async {
    final CollectionReference commentCollection =
        FirebaseFirestore.instance.collection('comment');
    final QuerySnapshot<Object?> lastCommentSnapshot = await commentCollection
        .orderBy('Comment_ID', descending: true)
        .limit(1)
        .get();

    if (lastCommentSnapshot.docs.isNotEmpty) {
      print(
          'last comment id = ${lastCommentSnapshot.docs.first.get('Post_ID')}');
      return lastCommentSnapshot.docs.first.get('Comment_ID') as int;
    } else {
      return 0;
    }
  }

  Future<void> createComment() async {
    int commid = await getLastCommentId();
    print(commid);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("comment").doc();

    Map<String, dynamic> newComment = {
      "Comment_Content": bodyController.text,
      "Comment_Date": DateTime.now().toString(),
      "Post_ID": postid,
      "Comment_ID": commid + 1,
      "Username": username,
      "Author_ID": email,
      "Club_ID": id,
    };

    // Add the new post to the collection
    print(newComment);
    await documentReference.set(newComment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.sky,
          title: Text('Post', style: TextStyle(color: AppColor.white)),
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
                }),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _postinfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final postInfo =
                      snapshot.data!.docs[0].data() as Map<String, dynamic>;

                  return ForumPostCard(
                    username: postInfo['Username'],
                    title: postInfo['Post_Title'],
                    body: postInfo['Post_Content'],
                    date: postInfo['Post_Date'],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _commentsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final comments = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ForumCommentCard(
                        username: comment['Username'],
                        comment: comment['Comment_Content'],
                        date: comment['Comment_Date'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'New Comment',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: bodyController,
                              decoration: InputDecoration(
                                  labelText: 'Say something...'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                createComment();
                                // Get values from text fields and isPublic checkbox
                                String body = bodyController.text;

                                // Do something with the values
                                print('Body: $body');

                                // Close the bottom sheet
                                Navigator.of(context).pop();
                              },
                              child: Text('Add Comment'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
        },
        label: const Text('Add comment'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
