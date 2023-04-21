import 'package:flutter/material.dart';

import '../../data/userPreferences.dart';
import 'helpers_list_page.dart';
// import 'assets/images';

class ThemeQuestionPage extends StatelessWidget {
  const ThemeQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionScreen()));
                    },
                    child: Image.network(
                      fit: BoxFit.cover,
                      'https://avatars.dzeninfra.ru/get-zen_doc/163240/pub_5d4a8884f8a62300acfc1679_5d4be652dfdd2500ad98f831/scale_1200',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const Text('Семья', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionScreen()));
                    },
                    child: Image.network(
                      fit: BoxFit.cover,
                      'https://gas-kvas.com/uploads/posts/2023-01/1673393686_gas-kvas-com-p-anime-risunki-na-noutbuke-2.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const Text('Работа', style: TextStyle(color: Colors.white)),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuestionScreen()));
                    },
                    child: Image.network(
                      fit: BoxFit.cover,
                      'https://i.pinimg.com/originals/3f/68/8c/3f688c4b95e3b96ac4075e82f8efbd82.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const Text('Отношения',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuestionScreen()));
                      },
                      child: Image.network(
                        fit: BoxFit.cover,
                        'https://ip1.anime-pictures.net/direct-images/634/63403bf6758458943c5d453cfcbedf62.jpg?if=ANIME-PICTURES.NET_-_207771-1684x1190-original-taka+%28tsmix%29-long+hair-blush-short+hair-black+hair.jpg',
                        width: 150,
                        height: 150,
                      )),
                  const Text(
                    'Дети',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

class _QuestionScreen extends State<QuestionScreen> {
  String? _question;
  var _psychologist = false;
  var _anonymous = false;

  var text;
  var color;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget biuldQuestionField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Напишите свой вопрос', border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Напишите вопрос';
        }
      },
      onSaved: (value) {
        _question = value;
      },
    );
  }

  Widget biuldPsychologistField() {
    return CheckboxListTile(
        title:
            const Text('Хочу, чтобы на мой вопрос отвечали только специалисты'),
        value: _psychologist,
        onChanged: (bool? value) {
          setState(() => _psychologist = value!);
        });
  }

  Widget biuldAnonymousField() {
    return CheckboxListTile(
        title: const Text('Задать вопрос анонимно'),
        value: _anonymous,
        onChanged: (bool? value) {
          setState(() => _anonymous = value!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма для вопроса'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                biuldQuestionField(),
                const SizedBox(height: 20.0),
                biuldPsychologistField(),
                const SizedBox(height: 20.0),
                biuldAnonymousField(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {}

                      if (!_formkey.currentState!.validate()) {
                        text = 'Необходимо заполнить поля';
                      } else {
                        UserPreferences().setRegistrationComplete();
                        text = 'Вопрос успешно опубликован';
                        color = Colors.green;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpersListPage()),
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(text),
                          backgroundColor: color,
                        ),
                      );
                    },
                    child: const Text(
                      'Оубликовать',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
