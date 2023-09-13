// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
    ObjectId id;
    String name;
    String email;
    String password;
    String uni;
    List<String> joinedClubs;

    MongoDbModel({
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.uni,
        required this.joinedClubs,
    });

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        uni: json["uni"],
        joinedClubs: List<String>.from(json["joinedClubs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "uni": uni,
        "joinedClubs": List<dynamic>.from(joinedClubs.map((x) => x)),
    };
}
