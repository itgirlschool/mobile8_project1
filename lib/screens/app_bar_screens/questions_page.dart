import 'package:flutter/material.dart';
// import 'assets/images';

class ThemeQuestionPage extends StatelessWidget {
  const ThemeQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите тему вопроса'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/angel.jpg',
                    width: 150,
                  ),
                  const Text('Family'),
                ],
              ),
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/angel.jpg',
                    width: 150,
                  ),
                  const Text('Health'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/angel.jpg',
                    width: 150,
                  ),
                  const Text('Family'),
                ],
              ),
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/angel.jpg',
                    width: 150,
                  ),
                  const Text('Health'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
