// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/main.dart';
import '../auth.dart';

// After successful login or registration
User? user = FirebaseAuth.instance.currentUser;

class Login extends StatefulWidget {
  Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController universityId = TextEditingController();
  final TextEditingController gender = TextEditingController();
  String? sex;
  List<String> joinedclubs = [];

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      createUesr();
      Navigator.of(context).pushReplacementNamed('/rec');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUesr() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("users").doc(email.text);

    Map<String, dynamic> users = {
      "Username": username.text,
      "Email": email.text,
      "University_id": universityId.text,
      "joined_clubs": joinedclubs,
      "Sex": sex
    };

    documentReference.set(users).whenComplete(() => print("$username created"));
  }

  Widget _title() {
    return const Text('auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _sexDropdown() {
    return DropdownButton<String>(
      value: sex,
      items: <String>['male', 'female']
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          sex = value;
        });
      },
      hint: Text('Select sex'),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register insted' : 'Login insted'));
  }

  String enteredText = "";

  // Store the entered text here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', email),
            _entryField('password', password),
            if (!isLogin) ...[
              _entryField('username', username),
              _entryField('university Id', universityId),
              _sexDropdown(),
            ],
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton()
          ],
        ),
      ),
    );
  }
}
