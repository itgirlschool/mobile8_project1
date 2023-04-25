import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile8_project1/classes.dart';

Future<List> parseJson(String path) async {
  final String response = await rootBundle.loadString(path);
  final data = jsonDecode(response);

  return data;
}

Future<User> fetchUser(int id) async {
  String path = 'lib/data/users.json';

  final List data = await parseJson(path);
  Map item = data.firstWhere((element) => element['id'] == id);

  User user = User(
      name: item['name'],
      aboutSelf: item['aboutSelf'],
      city: item['city'],
      diploma: item['diploma'],
      email: item['email'],
      helper: item['helper'],
      id: item['id'],
      password: item['password'],
      phone: item['phone'],
      photo: item['photo'],
      rating: item['rating'],
      numAnswers: item['numAnswers'],
      experienceYears: item['experienceYears'],
      role: Role.values.byName(item['role']));
  return user;
}

Future<List<User>> fetchSearchUserList(
    {String? nameQuery, int? ratingQuery, bool? diplomaQuery}) async {
  String path = 'lib/data/users.json';
  List items;
  List<User> userList = [];
  nameQuery = nameQuery?.trim().toLowerCase();
  final List data = await parseJson(path);
  items = data.toList();
  if (nameQuery != null && nameQuery != '') {
    items = items.where((user) => (user['name'].toLowerCase()).contains(nameQuery)).toList();
  }
  if (ratingQuery != null) {
    items = items.where((user) => user['rating'] >= ratingQuery).toList();
  }
  if (diplomaQuery != null && diplomaQuery != false ) {
    items = items.where((user) => user['diploma'] == diplomaQuery).toList();
  }
//  items.sort((a, b) => a['rating'].compareTo(b['rating']));
  items.forEach((item) {
    userList.add(User(
        name: item['name'],
        aboutSelf: item['aboutSelf'],
        city: item['city'],
        diploma: item['diploma'],
        email: item['email'],
        helper: item['helper'],
        id: item['id'],
        password: item['password'],
        phone: item['phone'],
        photo: item['photo'],
        rating: item['rating'],
        numAnswers: item['numAnswers'],
        experienceYears: item['experienceYears'],
        role: Role.values.byName(item['role'])));
  });
  userList.sort((a,b) => b.rating.compareTo(a.rating));
  return userList;
}

