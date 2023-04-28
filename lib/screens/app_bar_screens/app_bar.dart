import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';
import 'package:mobile8_project1/screens/app_bar_screens/questions_page.dart';
import 'all_questions_list_page.dart';
import 'helpers_list_page.dart';
import 'messages_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: Colors.blue,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.40),
        //selectedLabelStyle: textTheme.caption,
        //unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Помощники',
            icon: Icon(Icons.people),
          ),
          BottomNavigationBarItem(label: 'Ждут помощи', icon: Icon(Icons.comment)),
          BottomNavigationBarItem(
            label: 'Задать вопрос',
            icon: Icon(Icons.question_mark),
          ),
          BottomNavigationBarItem(
            label: 'Сообщения',
            icon: Icon(Icons.email),
          ),
          BottomNavigationBarItem(
            label: 'Моя анкета',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: <Widget>[
        HelpersListPage(),
        AllQuestionsPage(),
        ThemeQuestionPage(),
        MessagesPage(),
        ProfileUserPage(),
      ][_currentIndex],
    );
  }
}
