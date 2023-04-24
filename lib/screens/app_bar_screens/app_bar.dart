import 'package:flutter/material.dart';

import 'helpers_list_page.dart';

class MyHomePage extends StatefulWidget {
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
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'Сообщения',
            icon: Icon(Icons.music_note),
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
        Container(
          alignment: Alignment.center,
          child: const Text('Сообщения'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Задать вопрос'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Ждут помощи'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Моя анкета'),
        ),
      ][_currentIndex],
    );
  }
}