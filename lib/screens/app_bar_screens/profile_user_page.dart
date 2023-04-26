import 'package:flutter/material.dart';
import '../../classes.dart';

class ProfileUserPage extends StatelessWidget {
  User? user;

  //ProfileUserPage({super.key, this.user});
  ProfileUserPage({super.key, this.user}) {
    user = user ?? User.testBasicUser();
  }

  @override
  Widget build(BuildContext context) {
    return PersonWidget(user: user!);
  }
}

class FavoriteWidget extends StatefulWidget {

  User? user;

  FavoriteWidget({super.key, this.user});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState(user!);
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
            icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
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

class PersonWidget extends StatelessWidget {
  User? user;

  PersonWidget({super.key, this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),

      ),
      body: Container(
        child: _buildMainColumn(),
      ),
    );
  }

  Widget _buildMainColumn() => ListView(
        children: [
          _builTopImage(),
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
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
                  SizedBox(
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
        child: Image.asset(
          user!.photo,

          fit: BoxFit.cover,
        ),
      );

  Widget _buildRaiting() => ListTile(

        title: Text(
          user!.name,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text(user!.city),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FavoriteWidget(user: user!),
          ],
        ),
      );

  Widget _buildAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('${user!.numAnswers} ${_getAnswersTitle(user!.numAnswers)}', Icons.star, Colors.black),
          if (user!.diploma) ...[
            _buildButton('Диплом', Icons.topic, Colors.black),
          ],
          if (user!.experienceYears >0) ...[
            _buildButton('Стаж ${user!.experienceYears} ${_getYearsTitle(user!.experienceYears)}', Icons.auto_graph, Colors.black),
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
        user!.aboutSelf,

        softWrap: true,
        style: TextStyle(fontSize: 16),
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

