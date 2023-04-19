import 'package:flutter/material.dart';

class HelpersListPage extends StatelessWidget {
  const HelpersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: const [
            Text(
              'Экран со списком помощников',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            // buildNameYouField(),
            // biuldContactYouField(),
          ],
        ),
      ),
    );
  }
}
