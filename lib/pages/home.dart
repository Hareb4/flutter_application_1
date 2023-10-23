// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    ClubsScreen(),
    ProfileScreen(),
    ClubPage(),
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

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 20, top: 20),
              // Add margin on the left
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi User',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                color: AppColor.sky,
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
                        color: Color(0xFF22005d),
                      ),
                    ),
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF22005d),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 23,
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
            SizedBox(
              height: 17,
            ),
          ],
        ),
      ),
    );
  }
}

class ClubsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    // Print the entered text in the console
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
                      // Do something when the button is pressed.
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0), // Add margin to create space
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Text("culture"),
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
                        Text("education"),
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
          ],
        ),
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
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text('Sign Out'));
  }

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
                _signOutButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClubPage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isPublic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/home");
          },
          icon: Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        backgroundColor: AppColor.sky,
        title: Text('The Club Name'),
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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add Club button action
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
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
                                    color: Color.fromARGB(255, 113, 95, 162),
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
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: 350,
                                                        height: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              113,
                                                              95,
                                                              162),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 16,
                                                                  left: 16),
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
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: 350,
                                                        height: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              113,
                                                              95,
                                                              162),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 16,
                                                                  left: 16),
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
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
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
                                      color: Color.fromARGB(255, 113, 95, 162),
                                      borderRadius: BorderRadius.circular(20),
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
                                              fontWeight: FontWeight.bold,
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
                                    color: Color.fromARGB(255, 113, 95, 162),
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
                                    color: Color.fromARGB(255, 113, 95, 162),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            EventCard(
              name: 'Event 1',
              description: 'Description of Event 1',
              date: 'Date 1',
              time: 'Time 1',
            ),
            EventCard(
              name: 'Event 2',
              description: 'Description of Event 2',
              date: 'Date 2',
              time: 'Time 2',
            ),
            SizedBox(height: 8),
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
                margin: EdgeInsets.all(16),
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: AppColor.darkblue)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Images',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.darkblue,
                        ),
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.darkblue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
                              'New Event',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: dateController,
                              decoration: InputDecoration(labelText: 'Date'),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: placeController,
                              decoration: InputDecoration(labelText: 'Place'),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: descriptionController,
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPublic
                                    ? Color.fromARGB(255, 56, 24, 66)
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
                                        : Color.fromARGB(255, 56, 24, 66),
                                  )),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Get values from text fields and isPublic checkbox
                              },
                              child: Text('Add image'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Get values from text fields and isPublic checkbox
                                String title = titleController.text;
                                String date = dateController.text;
                                String place = placeController.text;
                                String description = descriptionController.text;

                                // Do something with the values
                                print('Title: $title');
                                print('Date: $date');
                                print('Place: $place');
                                print('Description: $description');
                                print('Is Public: $isPublic');

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
      ),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: AppColor.sky, title: Text('Forum'), actions: [
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage()),
                );
                // Add your action here when the Container is pressed.
              },
              child: ForumPostCard(
                title: 'hi',
                body: 'why me ?',
                date: '1/4',
                authorName: 'no name',
                imageUrl: "",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
                            if (imageFile != null) Image.file(imageFile!),
                            Text(
                              'New Post',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(labelText: 'Title'),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: descriptionController,
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Get values from text fields and isPublic checkbox
                                _getImage();
                              },
                              child: Text('Add image'),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Get values from text fields and isPublic checkbox
                                String title = titleController.text;
                                String description = descriptionController.text;

                                // Do something with the values
                                print('Title: $title');
                                print('Description: $description');

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
    );
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
    } else {}
  }
}

class PostPage extends StatelessWidget {
  TextEditingController bodyController = TextEditingController();
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
            ForumPostCard(
              title: 'hi',
              body: 'why me ?',
              date: '1/4',
              authorName: 'no name',
              imageUrl: "",
            ),
            ForumCommentCard(
              authorName: "hareb",
              comment: "blahblahblahblahblah",
              date: "day1",
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

class EventCard extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final String time;

  EventCard({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.sky,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(description),
            Text(date),
            Text(time),
          ],
        ),
      ),
    );
  }
}

class ForumPostCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final String authorName;
  final String imageUrl;

  ForumPostCard({
    required this.title,
    required this.body,
    required this.date,
    required this.authorName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClubPage()),
          );
          // Add your action here when the Container is pressed.
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    body,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    authorName,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForumCommentCard extends StatelessWidget {
  final String comment;
  final String date;
  final String authorName;

  ForumCommentCard({
    required this.comment,
    required this.date,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.sky,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comment by $authorName',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              comment,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
