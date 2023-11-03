import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

Future<String?> getUsername() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final _userinfo = FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: user.email)
        .snapshots();

    final querySnapshot = await _userinfo.first;
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();

      final username = data['Username'];

      return username;
    } else {
      return null;
    }
  } else {
    print('No user is logged in');
    return null;
  }
}

Future<String?> getEmail() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final _userinfo = FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: user.email)
        .snapshots();

    final querySnapshot = await _userinfo.first;
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();
      final email = data['Email'];

      return email;
    } else {
      return null;
    }
  } else {
    print('No user is logged in');
    return null;
  }
}

Future<String?> getUniversityId() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final _userinfo = FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: user.email)
        .snapshots();

    final querySnapshot = await _userinfo.first;
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();

      final universityId = data['University_id'];

      return universityId;
    } else {
      return null;
    }
  } else {
    print('No user is logged in');
    return null;
  }
}

Future<String?> getSex() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final _userinfo = FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: user.email)
        .snapshots();

    final querySnapshot = await _userinfo.first;
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();

      final sex = data['Sex'];

      // final username = querySnapshot.docs.first.data()['Username'];

      return sex;
    } else {
      return null;
    }
  } else {
    print('No user is logged in');
    return null;
  }
}

Future<List<String>?> getjoinedClubs() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final _userinfo = FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: user.email)
        .snapshots();

    final querySnapshot = await _userinfo.first;
    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();

      final joinedClubs = List<String>.from(data['joined_clubs'] ?? []);

      return joinedClubs;
    } else {
      return null;
    }
  } else {
    print('No user is logged in');
    return null;
  }
}

