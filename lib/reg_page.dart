import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? _name;

  String? _contact;
  String? _email;

  String? _password;

  var _approve = false;

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

  Widget buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ведите адрес электнной почты';
        }
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget biuldContactField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Номер телефона'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш номер телефона';
        }
      },
      onSaved: (value) {
        _contact = value;
      },
    );
  }

  Widget biuldPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Придумайте пароль'),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите пароль из 6 символов, включая цифры, буквы и символы';
        }
      },
      onSaved: (value) {
        _password = value;
      },
    );
  }

  Widget biuldApproveField() {
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
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                buildNameField(),
                biuldContactField(),
                buildEmailField(),
                biuldPasswordField(),
                const SizedBox(height: 20.0),
                biuldApproveField(),
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
                          text =
                              'Необходимо предоствить согласие на обработку персональных данных';
                        } else {
                          text = 'Форма успешно заполнена';
                          color = Colors.green;
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
}

