
import 'package:flutter/material.dart';
import 'package:flutter_application_1/MongoDBModel.dart';
import 'package:flutter_application_1/dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Singup extends StatelessWidget {
  String name = "";
  String email = "";
  String password = "";
  String uni = "";
  Singup({super.key});
  
  get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.purple[400],
        child: const Icon(Icons.home),
      ),
      appBar: AppBar(
        title: Text(
          "Log in",
          style: TextStyle(
              fontSize: 30, fontFamily: "myfont", fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.purple[800],
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
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.visibility,
                      color: Colors.purple[900],
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.purple[800],
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
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.visibility,
                      color: Colors.purple[900],
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.purple[800],
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
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    suffix: Icon(
                      Icons.visibility,
                      color: Colors.purple[900],
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.purple[800],
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
                Navigator.pushNamed(context, "/home");
                // _insertData(name, email, password, uni);
                print("$name, $email, $password, $uni");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 106, vertical: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: const Text(
                "login",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _insertData(
      String name, String email, String password, String uni) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id,
        name: name,
        email: email,
        password: password,
        uni: uni,
        joinedClubs: []);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context as BuildContext)
        .showSnackBar(SnackBar(content: Text("Inserted id " + _id.$oid)));
  }


}
