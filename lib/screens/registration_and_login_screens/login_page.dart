//страница логина, отображается при первом открытии приложения и если пользователь при регистрации не прошел проверку тел. номера
// и если пользователь разлогинен (эта обратотка пока не сделана)

import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/registration_and_login_screens/reg_page.dart';
import '../../data/userPreferences.dart';
import '../app_bar_screens/helpers_list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String password = '';
  String correctName = '';
  String correctPassword = '';
  @override
  void initState() {
    super.initState();
    correctName = UserPreferences().getUsername() ?? '';
    correctPassword = UserPreferences().getUserpassword() ?? '';
  }

  Widget buildNameField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Имя',
          icon: Icon(Icons.person),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1, //<-- SEE HERE
              color: Colors.white,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите Ваше имя';
          }
        },
        onChanged: (name) => setState(() => this.name = name));
  }

  Widget biuldPasswordField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Пароль',
          icon: Icon(Icons.key),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1, //
              color: Colors.white,
            ),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите пароль для входа';
          }
        },
        onChanged: (password) => setState(() => this.password = password));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        const Text(
                          'Вход в приложение',
                          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildNameField(),
                        const SizedBox(
                          height: 10,
                        ),
                        biuldPasswordField(),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC3E6FF),
                          ),
                          onPressed: _validateLogin,
                          child: const Text(
                            'Войти',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF007FE3),
                          ),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const FormScreen()),
                            );
                          },
                          child: const Text('Пройти регистрацию'),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  void _validateLogin() {

    if (formKey.currentState!.validate()) {
      Color color = Colors.red;
      String text;

      if (name != correctName && password != correctPassword) {
        text = 'Пароль или Имя не совпадают';
      } else {
        text = 'Идентификация пройдена';
        color = Colors.green;
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HelpersListPage()),
        );
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: color,
        ),
      );
    }
  }
}
