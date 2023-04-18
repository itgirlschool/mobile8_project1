import 'package:flutter/material.dart';
import 'package:mobile8_project1/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String? _name;
  String? _dataBirthday;
  String? _cityName;
  String? _about;
  var _approve = false;

  var text;
  var color;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Имя'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введитие имя';
        }
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget buildDataField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Дата рождения'),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ведите дату рождения';
        }
      },
      onSaved: (value) {
        _dataBirthday = value;
      },
    );
  }

  Widget biuldCityField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Ваш город'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш город';
        }
      },
      onSaved: (value) {
        _cityName = value;
      },
    );
  }

  Widget biuldAboutField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Напишите о себе несколько предложений'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Напишите о себе ';
        }
      },
      onSaved: (value) {
        _about = value;
      },
    );
  }

  Widget biuldApproveField() {
    return CheckboxListTile(
        title: const Text('Я хочу помогать'),
        value: _approve,
        onChanged: (bool? value) {
          setState(() => _approve = value!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форма для регистрации'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                buildNameField(),
                buildDataField(),
                biuldCityField(),
                biuldAboutField(),
                const SizedBox(height: 20.0),
                biuldApproveField(),
                const SizedBox(height: 20.0),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        Color color = Colors.red;
                        String text;
                      }

                      if (!_formkey.currentState!.validate()) {
                        text = 'Необходимо заполнить поля';
                      } else {
                        text = 'Данные профиля сохранены';
                        color = Colors.green;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: 'Данные в профиле сохранены',
                                  )),
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(text),
                          backgroundColor: color,
                        ),
                      );
                    },
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
