import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';
import 'package:mobile8_project1/screens/app_bar_screens/question_answers_page.dart';

import '../../classes.dart';
import '../../data/json_fetchers.dart';

class AllQuestionsPage extends StatefulWidget {
  const AllQuestionsPage({Key? key}) : super(key: key);

  @override
  State<AllQuestionsPage> createState() => _AllQuestionsPageState();
}

class _AllQuestionsPageState extends State<AllQuestionsPage> {
  Future<List<Question>>? questionList;

  //Question question = Question(text: 'sss');
  @override
  void initState() {
    questionList = fetchQuestionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDFCFF), //Color(0xFFEFEFEF),
      appBar: AppBar(
        title: const Text('Ждут помощи'),
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
                  if (questionList != null) ...[
                    FutureBuilder(
                      future: questionList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),

                                  child: _buildQuestionRow(snapshot, i),
                                ),
                              ],
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        //return const CircularProgressIndicator();
                        return const Text('');
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

  Row _buildQuestionRow(AsyncSnapshot<List<Question>> snapshot, int i) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: (){
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
          flex: 6,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QuestionAnswersPage(snapshot.data![i])),
              );
            },
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
                      _buildTopRow(snapshot, i),
                      const SizedBox(
                        height: 9,
                      ),
                      _buildQuestionText(snapshot, i),
                      const SizedBox(
                        height: 12,
                      ),
                      _buildBottomRow(snapshot, i),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopRow(AsyncSnapshot<List<Question>> snapshot, int i) {
    return Row(
      children: [
        const Icon(
          Icons.bookmark,
          size: 20,
          color: Colors.red,
        ),
        Text(' ${questionThemeRu(snapshot.data![i].questionTheme)}')
      ],
    );
  }

  Widget _buildQuestionText(AsyncSnapshot<List<Question>> snapshot, int i) {
    return Text(
      snapshot.data![i].text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        //fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBottomRow(AsyncSnapshot<List<Question>> snapshot, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.comment_outlined,
              size: 20,
              color: Color(0xFF56BE83), //Color(0xFF56CB58)
            ),
            Text('  ${snapshot.data![i].numAnswers}'),
          ],
        ),
        Text(
          '${snapshot.data![i].author.name}, ${timePassed(snapshot.data![i].postTime!)}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
