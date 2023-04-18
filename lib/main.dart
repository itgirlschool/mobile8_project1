import 'package:flutter/material.dart';
import 'package:mobile8_project1/profile_page.dart';
import 'package:mobile8_project1/reg_page.dart';
import 'userPreferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Хранение данных',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String passwordYou = '';
  // String? _nameYou;

  @override
  void initState() {
    super.initState();
    name = UserPreferences().getUsername() ?? '';
    passwordYou = UserPreferences().getUserpassword() ?? '';
  }

  Widget buildNameYouField() {
    return TextFormField(
        decoration:
            const InputDecoration(labelText: 'Имя', icon: Icon(Icons.person)),
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите Ваше имя';
          }
        },
        onChanged: (name) => setState(() => this.name = name));
  }

  Widget biuldContactYouField() {
    return TextFormField(
        decoration: const InputDecoration(
          labelText: 'Пароль',
          icon: Icon(Icons.key),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Введите пароль для входа';
          }
        },
        onChanged: (passwordYou) => setState(() => passwordYou = passwordYou));

    // onSaved: (value) {
    //   passwordYou = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const Text(
                    'Вход в приложение',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildNameYouField(),
                  biuldContactYouField(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await UserPreferences().setUsername(name);
                      await UserPreferences().setPassword(passwordYou);
                      if (formKey.currentState!.validate()) {
                        Color color = Colors.red;
                        String text;

                        if (name != 'Пользователь' && passwordYou != '123456') {
                          text = 'Пароль или Имя не совпадают';
                        } else {
                          text = 'Идентификация пройдена';
                          color = Colors.green;
                          // ignore: use_build_context_synchronously
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const FormScreen2()),
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

                      // setState(() {
                      //   name = '';
                      // });
                    },
                    child: const Text(
                      'Войти',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const FormScreen()),
                      );
                    },
                    child: const Text('Пройти регистрацию'),
                  )
                ],
              )),
        ));
  }
}

class FormScreen2 extends StatelessWidget {
  const FormScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: const [
            Text(
              'Привет, друг!',
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
