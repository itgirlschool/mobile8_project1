import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';
import 'package:mobile8_project1/screens/app_bar_screens/questions_page.dart';
import '../../classes.dart';
import '../../data/json_fetchers.dart';

class HelpersListPage extends StatefulWidget {
  const HelpersListPage({Key? key}) : super(key: key);

  @override
  State<HelpersListPage> createState() => _HelpersListPageState();
}

class _HelpersListPageState extends State<HelpersListPage> {
  Future<List<User>>? userList;
  String searchName = '';
  bool searchDiploma = false;
  final nameController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userList = fetchSearchUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Помощники'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ThemeQuestionPage()),
                      );
                    },
                    child: const Text('Задать вопрос -  кнопка для теста для перехода а пункт меню в будущем'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileUserPage()),
                      );
                    },
                    child: const Text('Профиль -  кнопка для теста для перехода а пункт меню в будущем'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildSearchHelper(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (userList != null) ...[
                    FutureBuilder(
                      future: userList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++) ...[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ProfileUserPage(user: snapshot.data![i])),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: _buildUserRow(snapshot, i),
                                  ),
                                ),
                              ],
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                  // buildNameYouField(),
                  // biuldContactYouField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Поиск',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          //controller: TextEditingController()..text = searchName,
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Имя',
          ),
          keyboardType: TextInputType.text,
          onSubmitted: (String search) {
            setState(() {
              userList = fetchSearchUserList(nameQuery: search);
              nameController.text = search;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          //width: 150,
          child: TextField(
            //controller: TextEditingController()..text = searchName,
            controller: ratingController,

            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Рейтинг ❤️ от',
            ),
            keyboardType: TextInputType.number,
            onSubmitted: (String search) {
              setState(() {
                int searchRating = search == '' ? 0 : int.parse(search);

                userList = fetchSearchUserList(ratingQuery: searchRating);

                ratingController.text = search;
              });
            },
          ),
        ),
        CheckboxListTile(
          value: searchDiploma,
          contentPadding: EdgeInsets.only(left: 0),
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('Дипломированный психолог'),
          onChanged: (bool? value) => setState(
            () {
              userList = fetchSearchUserList(diplomaQuery: value);
              searchDiploma = value!;
            },
          ),
        ),
      ],
    );
  }

  Row _buildUserRow(AsyncSnapshot<List<User>> snapshot, int i) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
              radius: 40, // Image radius
              backgroundImage: AssetImage(snapshot.data![i].photo)),
        ),
        Expanded(
          flex: 3,
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
                //border: Border.all(color: const Color(0xFF71DEFF), width: 3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data![i].name,
                      style: const TextStyle(fontSize: 18), //!TODO изменять размер шрифта в зависимости от длины имени
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        Text('❤️ ${snapshot.data![i].rating}'),
                        const SizedBox(
                          width: 10,
                        ),
                        if (snapshot.data![i].diploma == true) ...[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: const Color(0xFF4AA9FC),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                              child: Text(
                                'психолог',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
