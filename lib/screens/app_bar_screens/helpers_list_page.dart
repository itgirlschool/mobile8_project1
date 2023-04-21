import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/profile_user_page.dart';
import 'package:mobile8_project1/screens/app_bar_screens/questions_page.dart';

class HelpersListPage extends StatelessWidget {
  const HelpersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const Text(
              'Экран со списком помощников',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ThemeQuestionPage()),
                );
              },
              child: const Text(
                  'Задать вопрос -  кнопка для теста для перехода а пункт меню в будущем'),
            ),

            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ProfileUserPage()),
                );
              },
              child: const Text(
                  'Профиль -  кнопка для теста для перехода а пункт меню в будущем'),
            ),

            // buildNameYouField(),
            // biuldContactYouField(),
          ],
        ),
      ),
    );
  }
}
