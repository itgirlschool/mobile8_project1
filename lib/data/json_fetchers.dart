//функции для работы с данными json в папке data, которые заменяют ответы бэкэнда

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile8_project1/classes.dart';

Future<List> parseJsonAsList(String path) async {
  final String response = await rootBundle.loadString(path);
  final data = jsonDecode(response);

  return data;
}

Future<Map> parseJsonAsMap(String path) async {
  final String response = await rootBundle.loadString(path);
  final data = jsonDecode(response);

  return data;
}

Future<User> fetchUser(int id) async {
  String path = 'lib/data/users.json';

  final List data = await parseJsonAsList(path);
  Map item = data.firstWhere((element) => element['id'] == id);
  User user = _buildUserFromJson(item);
  return user;
}

Future<List<User>> fetchSearchUserList({String? nameQuery, int? ratingQuery, bool? diplomaQuery}) async {
  String path = 'lib/data/users.json';

  List<User> userList = [];
  nameQuery = nameQuery?.trim().toLowerCase();
  List items = await parseJsonAsList(path);

  if (nameQuery != null && nameQuery != '') {
    items = items.where((user) => (user['name'].toLowerCase()).contains(nameQuery)).toList();
  }
  if (ratingQuery != null) {
    items = items.where((user) => user['rating'] >= ratingQuery).toList();
  }
  if (diplomaQuery != null && diplomaQuery != false) {
    items = items.where((user) => user['diploma'] == diplomaQuery).toList();
  }
  for (var item in items) {
    userList.add(_buildUserFromJson(item));
  }
  userList.sort((a, b) => b.rating.compareTo(a.rating));
  return userList;
}

Future<List<Question>> fetchQuestionList() async {
  String path = 'lib/data/questions.json';

  List<Question> questionList = [];

  List items = await parseJsonAsList(path);

  for (var item in items) {
    questionList.add(
      Question(
          text: item['text'],
          author: _buildUserFromJson(item['user']),
          id: item['id'],
          anonymous: item['anonymous'],
          numAnswers: item['numAnswers'],
          postTime: DateTime.parse(item['postTime']),
          questionTheme: QuestionTheme.values.byName(item['questionTheme'])),
    );
  }
  return questionList;
}

Future<List<Answer>> fetchAnswerList(int id) async {
  String path = 'lib/data/answers.json';
  List<Answer> answerList = [];
  final List data = await parseJsonAsList(path);
  for (var map in data) {
    if (map?.containsKey("id") ?? false) {
      if (map!["id"] == id) {
        for (var item in map['answers']) {
          answerList.add(Answer(
            text: item['text'],
            author: _buildUserFromJson(item['user']),
            postTime: DateTime.parse(item['postTime']),
            id: item['id'],
            rating: item['rating'],
            questionId: item['questionId'],
          ));
        }
      }
    }
  }

  return answerList;
}

User _buildUserFromJson(item) { //вместо этой функции позднее был добавлен специальный конструктор классa, лучше использовать его
  return User(
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
}
