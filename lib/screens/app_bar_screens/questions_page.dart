import 'package:flutter/material.dart';

import '../../data/userPreferences.dart';
import 'helpers_list_page.dart';
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFC0BFBF), //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/family.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Семья'),
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFABABAB), //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/work.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Работа'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFABABAB), //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/relationship.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Отношения'),
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionScreen()));
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFABABAB), //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                      child: Image.asset(
                        fit: BoxFit.cover,
                        'assets/images/kids.png',
                        width: 150,
                        height: 150,
                      ),
                    ),),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Дети',

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
    return const TextField(
      decoration: InputDecoration(labelText: 'Напишите свой вопрос', border: OutlineInputBorder()),
      keyboardType: TextInputType.multiline,
      maxLines: 4,
    );

    // TextFormField(
    //   decoration: const InputDecoration(
    //       labelText: 'Напишите свой вопрос', border: OutlineInputBorder()),
    //   keyboardType: TextInputType.text,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return 'Напишите вопрос';
    //     }
    //   },
    //   onSaved: (value) {
    //     _question = value;
    //   },
    // );
  }

  Widget biuldPsychologistField() {
    return CheckboxListTile(
        title: const Text('Хочу, чтобы на мой вопрос отвечали только специалисты'),
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
                          MaterialPageRoute(builder: (context) => const HelpersListPage()),
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
                      'Опубликовать',
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
