//страница ответов на конкретный вопрос. Берутся из файла answers.json
//Можно добавить ответ, но он не сохраняется никуда, поэтому исчезнет
//после того, как страница будет закрыта. Лайки после нажатия не сохраняются, просто анимация

import 'package:flutter/material.dart';
import 'package:mobile8_project1/data/userPreferences.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';

import '../../classes.dart';
import '../../data/json_fetchers.dart';

class QuestionAnswersPage extends StatefulWidget {
  Question question;

  QuestionAnswersPage(this.question, {super.key}); //required this.question

  @override
  State<QuestionAnswersPage> createState() => _QuestionAnswersPageState(question);
}

class _QuestionAnswersPageState extends State<QuestionAnswersPage> {
  Future<List<Answer>>? answerList;
  Question question;
  bool _addAnswerVisible = false;
  bool _buttonAnswerVisible = true;
  String _newAnswerText = '';
  User? user = UserPreferences().getUserObject();

  _QuestionAnswersPageState(this.question);

  @override
  void initState() {
    answerList = fetchAnswerList(question.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDFCFF), //Color(0xFFEFEFEF),
      appBar: AppBar(
        title: const Text('Советы'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionTitle(),
                  if (_addAnswerVisible) _buildAddAnswer(),
                  if (answerList != null) ...[
                    FutureBuilder(
                      future: answerList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          if (snapshot.data!.isEmpty) {
                            return _buildEmptyAnswers();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(left: 25, top: 10, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < snapshot.data!.length; i++) ...[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      //child: Text(snapshot.data![i].author.name),
                                      child: _buildAnswerRow(snapshot, i),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAnswer() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Введите ваш совет',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFB6B6B6)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.text,
            maxLines: 3,
            onChanged: (value) {
              setState(() {
                _newAnswerText = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _addAnswerVisible = false;
                  _buttonAnswerVisible = true;
                  if (_newAnswerText.isNotEmpty) {
                    Answer newAnswer = Answer(text: _newAnswerText, author: user!, postTime: DateTime.now());
                    appendElements(answerList!, newAnswer);
                  }
                });
              },
              child: Text('Отправить'))
        ],
      ),
    );
  }

  Widget _buildEmptyAnswers() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Ответов пока нет',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget _buildQuestionTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileUserPage(user: question.author)),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0), // Image radius
              child: Image.asset(question.author.photo),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.author.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  question.text,
                  style: const TextStyle(
                    fontSize: 20,

                    //color: Colors.blue[900]
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                _buildBottomRow(),
                const SizedBox(
                  height: 5,
                ),
                if (_buttonAnswerVisible)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _addAnswerVisible = true;
                        _buttonAnswerVisible = false;
                      });
                    },
                    child: Text('Ответить'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      children: [
        const Icon(
          Icons.bookmark,
          size: 20,
          color: Colors.red,
        ),
        Text(' ${questionThemeRu(question.questionTheme)}'),
        Text(
          '   ${timePassed(question.postTime!)}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildAnswerRow(AsyncSnapshot<List<Answer>> snapshot, int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileUserPage(user: snapshot.data![i].author)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0), // Image radius
                  child: Image.asset(snapshot.data![i].author.photo)),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnswerTopRow(snapshot, i),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildAnswerText(snapshot, i),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildAnserBottomeRow(snapshot, i),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerTopRow(AsyncSnapshot<List<Answer>> snapshot, int i) {
    return Row(
      children: [
        Text(
          snapshot.data![i].author.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        if (snapshot.data![i].author.diploma == true) ...[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color(0xFF4AA9FC),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Text(
                'психолог',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildAnserBottomeRow(AsyncSnapshot<List<Answer>> snapshot, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FavoriteWidget(snapshot.data![i].rating),
        Text(timePassed(snapshot.data![i].postTime!)),
      ],
    );
  }

  Widget _buildAnswerText(AsyncSnapshot<List<Answer>> snapshot, int i) {
    return Text(
      snapshot.data![i].text,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.black,
        //fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<List<Answer>> appendElements(Future<List<Answer>> listFuture, Answer elementToAdd) async {
    final list = await listFuture;
    list.add(elementToAdd);
    return list;
  }
}

class FavoriteWidget extends StatefulWidget {
  int rating;

  FavoriteWidget(
    this.rating, {
    super.key,
  });

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState(rating);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  int rating;

  _FavoriteWidgetState(this.rating);

  bool _isFavorited = false;

  //_FavoriteWidgetState(user);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _toggleFavorite,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          color: Colors.red[500],
          icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
        ),
        Text('  ' + rating.toString()),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        rating -= 1;
      } else {
        _isFavorited = true;
        rating += 1;
      }
    });
  }
}
