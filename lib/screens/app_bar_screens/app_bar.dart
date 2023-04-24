import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';
import 'package:mobile8_project1/screens/app_bar_screens/questions_page.dart';

import 'helpers_list_page.dart';

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
           // icon: Image.asset(
           // "images/people_black_24dp.svg"),
            //label: 'Сообщения',
            // child: Image(
            // image: AssetImage("assets/images/people_black_24dp.svg")),
            icon: ImageIcon(
            AssetImage("images/helpers.svg"),
          ),
          ),
            //label: 'Помощники',
            //child: Image(
           // image: AssetImage("assets/images/people"),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/helpers.svg"),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Вопрос',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'Помощь',
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            label: 'Моя анкета',
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
      body: <Widget>[
        HelpersListPage(),
        HelpersListPage(),
        ThemeQuestionPage(),
        ThemeQuestionPage(),
        ProfileUserPage(),
      ][_currentIndex],
    );
  }
}