//экран ввода данных для регистрации, сохраняется в юзер префс. Имя юзера и логин на данный момент это одно и тоже поле
import 'package:flutter/material.dart';
import 'package:mobile8_project1/data/userPreferences.dart';
import 'package:mobile8_project1/screens/registration_and_login_screens/telephone_verification_code_page.dart';

import '../../classes.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? name;
  String? phone;
  String? email;
  String? password;
  var _approve = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Имя'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите имя';
        } else {
          name = value;
        }
      },
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
    );
  }

  Widget buildContactField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Номер телефона'),
      keyboardType: TextInputType.phone,
      initialValue: '+7',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш номер телефона';
        } else if (value.length != 12) {
          return 'Неккоректная длина номера';
        } else {
          phone = value;
        }
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Придумайте пароль'),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите пароль из 6 символов, включая цифры, буквы и символы';
        } else {
          password = value;
        }
      },
    );
  }

  Widget buildApproveField() {
    return CheckboxListTile(
        title: const Text('Я даю согласие на обработку персональных данных'),
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
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                buildNameField(),
                buildContactField(),
                buildEmailField(),
                buildPasswordField(),
                const SizedBox(height: 20.0),
                buildApproveField(),
                const SizedBox(height: 20.0),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Color color = Colors.red;
                        String text;

                        if (_approve == false) {
                          text = 'Необходимо предоствить согласие на обработку персональных данных';
                        } else {
                          text = 'Форма успешно заполнена';
                          color = Colors.green;
                          User user = User(
                            name: name!,
                            phone: phone!,
                            email: email!,
                            password: password,
                          );
                          UserPreferences().setUserObject(user);
                          UserPreferences().setPassword(user.password!);
                          UserPreferences().setUsername(user.name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TelephoneCodeVerificationPage()));
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(text),
                            backgroundColor: color,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Зарегистрироваться',
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

  String? validateEmail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Укажите адрес элекронной почты';
    } else if (!regex.hasMatch(value)) {
      return 'Неверный формат адреса почты';
    } else {
      email = value;

      return null;
    }
  }
}
