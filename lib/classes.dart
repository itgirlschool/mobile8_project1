//классы пользователя, вопроса, ответа, а также вспомогательные функции, которые используются на многих экранах

import 'package:intl/intl.dart';

enum Role { basicUser, psychologist }

enum QuestionTheme { family, work, relationship, children }

class User {
  int id;
  String name;
  String phone;
  String email;
  String? password;
  DateTime birthDate = DateTime.now();
  String city;
  String aboutSelf;
  int rating;
  Role role;
  bool helper;
  bool diploma;
  String photo;
  int numAnswers;
  int experienceYears;

  User(
      {required this.name,
      this.id = 0,
      this.phone = '',
      this.email = '',
      this.password,
      this.city = '',
      this.aboutSelf = '',
      this.rating = 0,
      this.role = Role.basicUser,
      this.helper = false,
      this.diploma = false,
      this.numAnswers = 0,
      this.experienceYears = 0,
      this.photo = 'lib/data/photos/default.jpg'});

  User.testBasicUser() //тестовый юзер для верстки
      : id = 100,
        name = 'Анна Петрова',
        phone = '+79991234567',
        email = 'anna@adviser.ru',
        birthDate = DateTime(1990, 1, 1),
        city = 'Новосибирск',
        aboutSelf = 'Живу в Новосибирске, замужем, двое детей. Работаю в IT. Дети учатся в школе. Муж шеф-повар.',
        rating = 5,
        photo = 'lib/data/photos/default.jpg',
        role = Role.basicUser,
        helper = true,
        experienceYears = 0,
        numAnswers = 10,
        diploma = false;

  User.testPsychologist() //тестовый юзер психолог для верстки
      : id = 101,
        name = 'Сергей Крылов',
        phone = '+79991234568',
        email = 'sergey@adviser.ru',
        birthDate = DateTime(1995, 4, 5),
        city = 'Москва',
        aboutSelf = 'Живу в Москве, окончил университет, опыт работы психологом 10 лет',
        rating = 10,
        role = Role.psychologist,
        helper = true,
        diploma = true,
        numAnswers = 15,
        experienceYears = 4,
        photo = 'lib/data/photos/default.jpg';

  User.fromJson(Map<String, dynamic> item) //распаковка юзера из json, используется при доставании юзера из юзер префс
      : name = item['name'] ?? '',
        aboutSelf = item['aboutSelf'] ?? '',
        city = item['city'] ??'',
        diploma = item['diploma'] ?? false,
        email = item['email'] ?? '',
        helper = item['helper']?? false,
        id = item['id'] ?? 0,
        password = item['password'] ?? '',
        phone = item['phone'] ?? '',
        photo = item['photo'] != ''? item['photo']: 'lib/data/photos/default.jpg',
        rating = item['rating'] ?? 0,
        numAnswers = item['numAnswers'] ?? 0,
        experienceYears = item['experienceYears'] ?? 0,
        role = item['role'].isEmpty ? Role.values.byName(item['role']) : Role.basicUser,
        birthDate = DateTime.parse(item['birthDate']);


  Map<String, dynamic> toJson () { //запаковка юзера в json
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "birthDate": birthDate.toString(),
      "city": city,
      "aboutSelf": aboutSelf,
      "role": role.name,
      "diploma": diploma,
      "helper" : helper,
      "rating" : rating,
      "numAnswers" : numAnswers,
      "experienceYears" : experienceYears,
      "photo": photo,
      "password" : password
    };
  }

  birthDateToString() {
    return "${birthDate.day}.${birthDate.month}.${birthDate.year}";
  }
}

class Question {
  int? id;
  QuestionTheme questionTheme = QuestionTheme.family;
  User author;
  DateTime? postTime = DateTime.now();
  String text;
  int numAnswers;
  bool anonymous;

  Question({
    this.questionTheme = QuestionTheme.family,
    required this.text,
    this.numAnswers = 0,
    this.id,
    this.anonymous = false,
    required this.author,
    required this.postTime,
  });

  Question.testQuestion() //тестовый вопрос для верстки
      : id = 200,
        author = User.testBasicUser(),
        numAnswers = 2,
        text = 'Как наладить отношения с родственником, с которым я постоянно конфликтую?',
        postTime = DateTime.now(),
        anonymous = false,
        questionTheme = QuestionTheme.family;
}

class Answer {
  int? id;
  int? questionId;
  String text = '';
  User? author = User.testPsychologist();
  DateTime? postTime = DateTime.now();
  int rating;

  Answer({
    this.author,
    this.postTime,
    required this.text,
    this.id,
    this.rating =0,
    this.questionId,
  });

  Answer.testAnswer() //тестовый ответ для верстки
      : id = 300,
        questionId = 200,
        postTime = DateTime.now(),
        rating = 5,
        text =
            'Для начала стоит выяснить, что именно вызывает конфликты в отношениях с вами и вашим родственником. Попробуйте сесть и поговорить наедине, чтобы высказать свои чувства и услышать со стороны взгляд друг на друга. Важно понимать, что каждый имеет право на свою точку зрения, и попытаться найти компромиссное решение, которое будет удовлетворительно для обеих сторон.',
        author = User.testPsychologist();
}

String dateToString(DateTime dateTime) { //сначала использовали, но вообще лучше не использвать, а брать DateFormat
  return "${dateTime.day}.${dateTime.month}.${dateTime.year}";
}

String dateTimeToString(DateTime dateTime) { //лучше использовать DateFormat
  return "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year}  ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

String questionThemeRu(QuestionTheme val) {
  String ru = '';
  switch (val) {
    case QuestionTheme.family:
      ru = 'Семья';
      break;
    case QuestionTheme.work:
      ru = 'Работа';
      break;
    case QuestionTheme.relationship:
      ru = 'Отношения';
      break;
    case QuestionTheme.children:
      ru = 'Дети';
      break;
  }
  return ru;
}

String daysToString(int days) {
  if (days % 10 == 1 && days % 100 != 11) {
    return "день";
  } else if ([2, 3, 4].contains(days % 10) && ![12, 13, 14].contains(days % 100)) {
    return "дня";
  } else {
    return "дней";
  }
}

String timePassed(DateTime postTime) {
  DateTime today = DateTime.now();
  int passedDays = today.difference(postTime).inDays;
  if (passedDays > 0 && passedDays <= 7) {
    return '$passedDays ${daysToString(passedDays)} назад';
  } else if (passedDays == 0) {
    return 'Сегодня';
  } else {
    return DateFormat('dd.MM.yyyy').format(postTime);
  }
}
