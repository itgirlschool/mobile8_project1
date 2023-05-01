//страница профиля пользователя
//есть кнопка редактировать, если это "мой профиль". Изменения сохранятся в объект юзера в префс
//еще должна быть кнопка "Написать", если это чужой профиль, там должен открываться чат
//и еще кнопку "Выйти" надо добавить

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/registration_and_login_screens/login_page.dart';
import '../../classes.dart';
import '../../data/userPreferences.dart';
import '../registration_and_login_screens/profile_edit_page.dart';

class ProfileUserPage extends StatelessWidget {
  User? user;
  bool myPage = false;

  ProfileUserPage({super.key, this.user}) {
    myPage = user != null ? false : true;
    user = user ?? UserPreferences().getUserObject(); //если не передан пользователь в качестве аргумента, то открывается страница текущего пользователя приложения
  }

  @override
  Widget build(BuildContext context) {
    return PersonWidget(user: user!, myPage: myPage);
  }
}

class FavoriteWidget extends StatefulWidget {
  User user;

  FavoriteWidget({super.key, required this.user});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState(user);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  User user;

  _FavoriteWidgetState(this.user);

  bool _isFavorited = false;

  //_FavoriteWidgetState(user);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: _toggleFavorite,
            color: Colors.red[500],
            icon: (_isFavorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border)),
          ),
        ),
        SizedBox(
          width: 40,
          child: Container(
            //child: Text('$_favoriteCount'),
            child: Text(user.rating.toString()),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        user.rating -= 1;
      } else {
        _isFavorited = true;
        user.rating += 1;
      }
    });
  }
}

class PersonWidget extends StatefulWidget {
  User user;
  bool myPage;

  PersonWidget({super.key, required this.user, required this.myPage});

  @override
  State<PersonWidget> createState() => _PersonWidgetState(user, myPage);
}

class _PersonWidgetState extends State<PersonWidget> {
  User user;
  bool myPage;
  String text = '11';

  _PersonWidgetState(this.user, this.myPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        child: _buildMainColumn(context),
      ),
    );
  }

  Widget _buildMainColumn(BuildContext context) => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (myPage) ...[
                  ElevatedButton(
                    // onPressed: () async {
                    //   final data = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const ProfileScreen(),
                    //     ),
                    //   );
                    //   setState(() {
                    //     user = data;
                    //   });
                    // },
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const ProfileScreen(),
                      //   ),
                      // );
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileScreen()), (Route<dynamic> route) => false);
                    },
                    child: Text("Редактировать"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                    },
                    child: Text("Выйти"),
                  ),
                ]
              ],
            ),
          ),
          _builTopImage(),
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: _buildRaiting(),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: _buildAction(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: _buildDesc(),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget _builTopImage() => Card(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      elevation: 5,
      child: ClipRRect(child: AspectRatio(aspectRatio: 1, child: user.buildPhotoImage())));

  Widget _buildRaiting() => ListTile(
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text(user.city),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FavoriteWidget(user: user),
          ],
        ),
      );

  Widget _buildAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('${user.numAnswers} ${_getAnswersTitle(user.numAnswers)}', Icons.star, Colors.black),
          if (user.diploma) ...[
            _buildButton('Диплом', Icons.topic, Colors.black),
          ],
          if (user.experienceYears > 0) ...[
            _buildButton('Стаж ${user.experienceYears} ${_getYearsTitle(user.experienceYears)}', Icons.auto_graph, Colors.black),
          ]
        ],
      );

  Widget _buildButton(String label, IconData icon, Color color) => Column(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Container(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );

  Widget _buildDesc() => Text(
        user.aboutSelf,
        softWrap: true,
        style: const TextStyle(fontSize: 16),
      );
}

String _getAnswersTitle(int numAnswers) {
  int lastDigit = numAnswers % 10;
  int lastTwoDigits = numAnswers % 100;

  if (lastDigit == 1 && lastTwoDigits != 11) {
    return "совет";
  } else if (lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 10 || lastTwoDigits > 20)) {
    return "совета";
  } else {
    return "советов";
  }
}

String _getYearsTitle(int numYears) {
  int lastDigit = numYears % 10;
  int lastTwoDigits = numYears % 100;

  if (lastDigit == 1 && lastTwoDigits != 11) {
    return "год";
  } else if (lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 10 || lastTwoDigits > 20)) {
    return "года";
  } else {
    return "лет";
  }
}
