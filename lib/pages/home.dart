// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:io";
import 'package:flutter_application_1/pages/rec.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/constants/flutter_flow_theme.dart';
import 'package:flutter_application_1/widget_tree.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
List<String>? joinedClubs = [];
String userImageUrl = '';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

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
  PreferredSizeWidget h = AppBar(
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        null,
        0,
      ),
      shadowColor: AppColor.darkblue,
      title: const Text(
        "Clubz",
        style: TextStyle(
          color: AppColor.darkblue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.lightsky,
      centerTitle: true,
      automaticallyImplyLeading: false, // Remove the default back arrow
      actions: [
        IconButton(
          icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
              ? Icons.dark_mode
              : Icons.light_mode),
          onPressed: () {
            MyApp.themeNotifier.value =
                MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
          },
        ),
      ],
      elevation: 0 // Set your desired padding
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: h,
      body: _tabs[_currentIndex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.thumb_up),
      // ),
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
    // fetchimage();
  }

  Future<void> fetchimage() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$email.jpg');
    userImageUrl = await storageReference.getDownloadURL();
    print('the url image 3 : ' + userImageUrl);
  }

  // Function to authenticate and retrieve user data

  Future<void> fetchall() async {
    result = '';
    id = '';
    postid = 0;

    username = '';
    email = '';
    universityId = '';
    sex = '';
    joinedClubs = [];
    userImageUrl = '';

    final fetchedUsername = await getUsername();
    final fetchEmail = await getEmail();
    final fetchUniId = await getUniversityId();
    final fetchSex = await getSex();
    final fetchJoinedClubs = await getjoinedClubs();

    setState(() {
      username = fetchedUsername;
      email = fetchEmail;
      universityId = fetchUniId;
      sex = fetchSex;
      joinedClubs = fetchJoinedClubs;
      // userImageUrl = userImageUrl1;
    });

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$email.jpg');
    final userImageUrl1 = await storageReference.getDownloadURL();

    setState(() {
      userImageUrl = userImageUrl1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userImageUrl.isNotEmpty) {
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
  final Stream<QuerySnapshot> _publicEvents = FirebaseFirestore.instance
      .collection('event')
      .where('isPublic', isEqualTo: true)
      .snapshots();

  final Stream<QuerySnapshot> _privateEventsSnapshots = FirebaseFirestore
      .instance
      .collection('event')
      .where('isPublic', isEqualTo: 'false')
      .snapshots();

  void getImage() async {
    print('the url image 2 : ' + userImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    print('the url image 1 : ' + userImageUrl);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hi $username!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                if (userImageUrl.isNotEmpty)
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        userImageUrl), // Adjust the radius as needed
                  ),
              ],
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
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return GestureDetector(
                        onTap: () {
                          // Add your action here when the Container is pressed.
                        },
                        child: EventCard(
                            id: event['Club_ID'],
                            name: event['Event_Title'],
                            place: event['Event_Place'],
                            description: event['Event_Description'],
                            date: event['Event_Date'],
                            time: event['Event_Time'],
                            type: event['Event_Type'],
                            clubName: event['Club_Name']),
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
                  .where('Club_ID', arrayContains: joinedClubs)
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
                      return Text('No Events found.');
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
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
                        });
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
                  // .where('Club_ID', whereIn: joinedClubs)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print('joinedclubs after snapshot $joinedClubs');
                  final clubs = snapshot.data!.docs;
                  // print('club id 0 = ${clubs[0]['Club_ID']}');
                  // print('joined clubs = ${joinedClubs}');
                  // print(
                  //     'true, false = ${!(joinedClubs!.contains(clubs[1]['Club_ID']))}');
                  // if (!(joinedClubs!.contains(clubs[1]['Club_ID']))) {
                  //   return Text('No Clubs found.');
                  // }
                  if (clubs.isEmpty) {
                    return Text('No Clubs found.');
                  }

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: clubs.length,
                    itemBuilder: (context, index) {
                      final club = clubs[index];
                      // print(club['Club_Name']);
                      // print(club['Club_ID']);
                      // print(joinedClubs?[0]);
                      // print(club['Club_ID'] == joinedClubs?[0]);

                      // var art = joinedClubs!.contains(club['Club_ID']);
                      var art = joinedClubs!
                          .where((element) => element.contains(club['Club_ID']))
                          .toList();
                      bool art2 = art.isNotEmpty;
                      if (art2) {
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
                            // Add your action here when the Container is pressed.
                          },
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: ClubCard(
                              id: club['Club_ID'],
                              name: club['Club_Name'],
                              category: club['Club_Category'],
                              numevents: '3',
                              desc: club['Club_Description'],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 0,
                          width: 0,
                        );
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
                          hintText: "Search",
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
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          streamQuery = FirebaseFirestore.instance
                              .collection('clubs')
                              .where('Club_Category', isEqualTo: 'Sports')
                              .snapshots();
                          debugPrint('Received click');
                        });
                      },
                      child: const Text('Sports'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            streamQuery = FirebaseFirestore.instance
                                .collection('clubs')
                                .where('Club_Category', isEqualTo: 'Social')
                                .snapshots();
                            debugPrint('Received click');
                          });
                        },
                        child: const Text('Social'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            streamQuery = FirebaseFirestore.instance
                                .collection('clubs')
                                .where('Club_Category',
                                    isEqualTo: 'Educational')
                                .snapshots();
                            debugPrint('Received click');
                          });
                        },
                        child: const Text('Educational'),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          streamQuery = FirebaseFirestore.instance
                              .collection('clubs')
                              .snapshots();
                        });
                      },
                      child: const Text('all'),
                    ),
                  ],
                ),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HobbiesGrid()),
                    );
                  },
                  child: const Text('Recommend me a club'),
                ),
                SizedBox(
                  height: 10,
                )
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
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: ClubCard(
                              id: club['Club_ID'],
                              name: club['Club_Name'],
                              category: club['Club_Category'],
                              numevents: '3',
                              desc: club['Club_Description'],
                            ),
                          ));
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

class _ProfileScreen extends State<ProfileScreen> {
  File? _image;
  String? _url;

  File? imagePicked;

  void galleryImage2() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);

      final storage = FirebaseStorage.instance;
      final Reference storageReference =
          storage.ref().child('images/').child('$email.jpg');

      UploadTask uploadTask = storageReference.putFile(pickedImageFile);

      uploadTask.then((res) {
        // Image has been uploaded to Firebase Storage. You can do something with the URL.
        storageReference.getDownloadURL().then((url) {
          setState(() {
            imagePicked = pickedImageFile;
            var imageUrl = url;
            // Store the URL for later use or display.
          });
          Navigator.pop(context);
        });
      });
    }
  }

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
      await Auth().signOut();
      Navigator.pushNamed(context, '/');
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
                                        onPressed: galleryImage2,
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
                  '$username', // Replace with the user's name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: () {
                //     showModalBottomSheet(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return StatefulBuilder(
                //             builder:
                //                 (BuildContext context, StateSetter setState) {
                //               return SingleChildScrollView(
                //                 child: Container(
                //                   padding: EdgeInsets.all(16.0),
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children: <Widget>[
                //                       Text(
                //                         'New Event',
                //                         style: TextStyle(
                //                           fontSize: 20,
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                       ),
                //                       SizedBox(height: 16),
                //                       TextField(
                //                         controller: nameController,
                //                         decoration:
                //                             InputDecoration(labelText: 'Name'),
                //                       ),
                //                       ElevatedButton(
                //                         onPressed: () {
                //                           // Get values from text fields and isPublic checkbox
                //                           gallaryImage();
                //                         },
                //                         child: Text('Add image'),
                //                       ),
                //                       SizedBox(height: 16),
                //                       ElevatedButton(
                //                         onPressed: () {
                //                           Navigator.of(context).pop();
                //                           // Get values from text fields and isPublic checkbox
                //                         },
                //                         child: Text('Edit profile'),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             },
                //           );
                //         });
                //   },
                //   child: Text('Edit Profile'),
                // ),
                SizedBox(
                  height: 8,
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center children vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Clubs')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Events'))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('clubs')
                      // .where('Club_ID', whereIn: joinedClubs)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // print('joinedclubs after snapshot $joinedClubs');
                      final clubs = snapshot.data!.docs;
                      // print('club id 0 = ${clubs[0]['Club_ID']}');
                      // print('joined clubs = ${joinedClubs}');
                      // print(
                      //     'true, false = ${!(joinedClubs!.contains(clubs[1]['Club_ID']))}');
                      // if (!(joinedClubs!.contains(clubs[1]['Club_ID']))) {
                      //   return Text('No Clubs found.');
                      // }
                      if (clubs.isEmpty) {
                        return Text('No Clubs found.');
                      }

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: clubs.length,
                        itemBuilder: (context, index) {
                          final club = clubs[index];
                          // print(club['Club_Name']);
                          // print(club['Club_ID']);
                          // print(joinedClubs?[0]);
                          // print(club['Club_ID'] == joinedClubs?[0]);

                          // var art = joinedClubs!.contains(club['Club_ID']);
                          var art = joinedClubs!
                              .where((element) =>
                                  element.contains(club['Club_ID']))
                              .toList();
                          bool art2 = art.isNotEmpty;
                          if (art2) {
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
                                // Add your action here when the Container is pressed.
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: ClubCard(
                                  id: club['Club_ID'],
                                  name: club['Club_Name'],
                                  category: club['Club_Category'],
                                  numevents: '3',
                                  desc: club['Club_Description'],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 0,
                              width: 0,
                            );
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('event')
                      .where('isPublic', isEqualTo: 'false')
                      .where('Club_ID', arrayContains: joinedClubs)
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
                          return Text('No Events found.');
                        }
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];
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
                                    padding: const EdgeInsets.only(
                                        bottom: 16, left: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          event['Event_Description'],
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
                            });
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SizedBox(height: 10),
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
  String? clubName;

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
      "Event_Time": timeController.text,
      "Club_Name": clubName,
      "isPublic": isPublic,
    };

    documentReference.set(event);
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = selectedTime.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toString().substring(0, 11);
      });
    }
  }

  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

  Widget build(BuildContext context) {
    String clid = widget.clubId;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('clubs')
          .where('Club_ID', isEqualTo: clid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final clubInfo =
              snapshot.data!.docs[0].data() as Map<String, dynamic>;

          if (clubInfo['Club_Leader'] == email) {
            isAuth = true; // Or true, depending on your condition
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
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
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
                            MaterialPageRoute(
                                builder: (context) => ForumPage()),
                          );
                          // Add your action here when the Container is pressed.
                        },
                        child: // Generated code for this Container Widget...
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Color(0xFF39D2C0),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Color(0x98FFFFFF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Icon(
                                      Icons.people_alt_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Forum',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '12 posts',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              color: Color(0xFF57636C),
                                              size: 24,
                                            )
                                          ]))
                                ],
                              ),
                            ),
                          ),
                        )),
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
                                  name: event['Event_Title'],
                                  place: event['Event_Place'],
                                  description: event['Event_Description'],
                                  date: event['Event_Date'],
                                  time: event['Event_Time'],
                                  type: event['Event_Type'],
                                  clubName: event['Club_Name']),
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
                                          ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                            child: Text('Pick a Date'),
                                          ),
                                          SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              _selectTime(context);
                                            },
                                            child: Text('Pick a Time'),
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
                                          FilledButton(
                                            onPressed: () {
                                              // Get values from text fields and isPublic checkbox
                                              clubName = clubInfo['Club_Name'];
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
      return lastPostSnapshot.docs.first.get('Post_ID') as int;
    } else {
      return 0;
    }
  }

  Future<void> createPost4() async {
    int newPostid = await getLastPostId();
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
      "isEdited": false,
    };

    // Add the new post to the collection
    await documentReference.set(newpost);
  }

  void deletePost(int postID) async {
    try {
      // Reference to the 'posts' collection
      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

      // Reference to the document with the specified postID
      DocumentReference postRef = posts.doc(postID.toString());

      // Delete the document
      setState(() async {
        await postRef.delete();
      });

      print('Post deleted successfully');
    } catch (e) {
      print('Error deleting post: $e');
    }
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
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
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
                        var isAuth = false;
                        var isEdited = false;

                        if (post['Author_ID'] == email) {
                          isAuth = true;
                        }
                        final Stream<QuerySnapshot> _postsStream =
                            FirebaseFirestore.instance
                                .collection('post')
                                .where('Post_ID', isEqualTo: id)
                                .snapshots();
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
                              onDelete: () => {
                                    FirebaseFirestore.instance
                                        .collection('post')
                                        .where('Post_ID',
                                            isEqualTo: post[
                                                'Post_ID']) // Filter documents based on Post_ID
                                        .get() // Retrieve the matching documents
                                        .then((QuerySnapshot snapshot) {
                                      print(snapshot.docs);
                                      if (snapshot.docs.isNotEmpty) {
                                        // Check if there are any matching documents
                                        print(snapshot.docs);
                                        snapshot.docs.forEach(
                                            (DocumentSnapshot document) {
                                          // Iterate over matching documents
                                          print(document);
                                          document.reference
                                              .delete(); // Delete the document using its reference
                                        });
                                      } else {
                                        print(
                                            'No documents found with Post_ID: ${post['Post_ID']}'); // No matching documents found
                                      }
                                    }),
                                    FirebaseFirestore.instance
                                        .collection('comments')
                                        .where('Post_ID',
                                            isEqualTo: post[
                                                'Post_ID']) // Filter documents based on Post_ID
                                        .get() // Retrieve the matching documents
                                        .then((QuerySnapshot snapshot) {
                                      print(snapshot.docs);
                                      if (snapshot.docs.isNotEmpty) {
                                        // Check if there are any matching documents
                                        print(snapshot.docs);
                                        snapshot.docs.forEach(
                                            (DocumentSnapshot document) {
                                          // Iterate over matching documents
                                          print(document);
                                          document.reference
                                              .delete(); // Delete the document using its reference
                                        });
                                      } else {
                                        print(
                                            'No documents found with Post_ID: ${post['Post_ID']}'); // No matching documents found
                                      }
                                    })
                                  },
                              onEdit: () {},
                              isEdited: isEdited,
                              isAuth: isAuth),
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
      .collection('comments')
      .where('Club_ID', isEqualTo: id)
      .where('Post_ID', isEqualTo: postid)
      .snapshots();

  TextEditingController bodyController = TextEditingController();

  Future<int> getLastCommentId() async {
    final CollectionReference commentCollection =
        FirebaseFirestore.instance.collection('comments');
    final QuerySnapshot<Object?> lastCommentSnapshot = await commentCollection
        .orderBy('Comment_ID', descending: true)
        .limit(1)
        .get();

    if (lastCommentSnapshot.docs.isNotEmpty) {
      return lastCommentSnapshot.docs.first.get('Comment_ID') as int;
    } else {
      return 0;
    }
  }

  Future<void> createComment() async {
    int commid = await getLastCommentId();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("comments").doc();

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
                  MyApp.themeNotifier.value =
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
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
                  final post =
                      snapshot.data!.docs[0].data() as Map<String, dynamic>;
                  var isAuth = false;
                  var isEdited = false;
                  if (post['Author_ID'] == email) {
                    isAuth = true;
                  }
                  return ForumPostCard(
                      username: post['Username'],
                      title: post['Post_Title'],
                      body: post['Post_Content'],
                      date: post['Post_Date'],
                      onDelete: () => {},
                      onEdit: () {},
                      isEdited: isEdited,
                      isAuth: isAuth);
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
