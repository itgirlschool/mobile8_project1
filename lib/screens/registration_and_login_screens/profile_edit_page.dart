//страница редактирования профиля. Во время регистрации показывается меньше полей.
//При открытии через "Редактировать" на странице профиля, открывается больше полей.
//Данные сохраняются в юзер префс через объект User, запакованный в json.
//Кнопка "Загрузить диплом психолога" не обрабатывается. По логике после загрузки и подтверждения диплома
//модератором должно открываться дополнительное поле стаж

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../classes.dart';
import '../../data/userPreferences.dart';
import '../app_bar_screens/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  User? user;
  TextEditingController dateInput = TextEditingController();
  final bool registrationComplete = UserPreferences().getLoggedIn();
  var text;
  var color;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    user = UserPreferences().getUserObject(); //юзер берется из юзер префс
    super.initState();
    if (registrationComplete) {
      dateInput.text = DateFormat('dd.MM.yyyy').format(user!.birthDate);
    }
  }

  Widget buildNameField() {
    return TextFormField(
      initialValue: user!.name,
      decoration: const InputDecoration(labelText: 'Имя'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введитие имя';
        }
      },
      onSaved: (value) {
        user!.name = value!;
      },
    );
  }

  Widget buildDateTimeField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введитие дату рождения';
        }
      },
      controller: dateInput,
      //editing controller of this TextField
      decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Дата рождения" //label text of field
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          //initialDate: user!.birthDate,
          initialDate: DateTime.now(),
          firstDate: DateTime(1940),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          user!.birthDate = pickedDate;
          //pickedDate output format => 2021-03-10 00:00:00.000
          //String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16
          setState(() {
            dateInput.text = formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    );
  }


  Widget buildCityField() {
    return TextFormField(
      initialValue: user!.city,
      decoration: const InputDecoration(labelText: 'Ваш город'),
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш город';
        }
      },
      onSaved: (value) {
        user!.city = value!;
      },
    );
  }

  Widget buildAboutField() {
    return TextFormField(
      initialValue: user!.aboutSelf,
      decoration: const InputDecoration(labelText: 'Напишите о себе несколько предложений'),
      keyboardType: TextInputType.text,
      maxLines: 3,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Напишите о себе ';
        }
      },
      onSaved: (value) {
        user!.aboutSelf = value!;
      },
    );
  }

  Widget buildPhotoField() {
    return TextFormField(
      initialValue: user!.photo == 'lib/data/photos/default.jpg' ? '' : user!.photo,
      decoration: const InputDecoration(labelText: 'Ваше фото (URL ссылка)'),
      keyboardType: TextInputType.multiline,
      validator: validateImageUrl,
      onSaved: (value) {
        user!.photo = value!;
      },
    );
  }

  Widget buildApproveField() {
    return CheckboxListTile(
        title: const Text('Я хочу помогать'),
        value: user!.helper,
        onChanged: (bool? value) {
          setState(() => user!.helper = value!);
        });
  }

  Widget buildAdditionalFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContactField(),
        buildEmailField(),
        // buildPasswordField(),
        //  buildPhotoField()
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildPsycho() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Загрузить диплом психолога'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFA036),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      initialValue: user!.email,
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        user!.email = value!;
      },
    );
  }

  Widget buildContactField() {
    return TextFormField(
      initialValue: user!.phone,
      decoration: const InputDecoration(labelText: 'Номер телефона'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите ваш номер телефона';
        } else if (value.length != 12) {
          return 'Неккоректная длина номера';
        }
      },
      onSaved: (value) {
        user!.phone = value!;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      initialValue: user!.password,
      decoration: const InputDecoration(labelText: 'Ваш пароль'),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Введите пароль из 6 символов, включая цифры, буквы и символы';
        }
      },
      onSaved: (value) {
        user!.password = value!;
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return buildUserProfile(context);
  // }
  //оставила закоммеченным как пример использования WillPopScope.
  //Убрала, потому что навигация стала более сложной из-за возможности разлогиниться.
  //Эта же форма используется во время регистрации, поэтому willpop усложняет всё.
  //Делаю прямой пуш с расчисткой истории навигации
  // Widget buildUserProfile(BuildContext context) {
  //   if (registrationComplete) {
  //     return WillPopScope( //
  //         onWillPop: () async {
  //           Navigator.pop(context, user);
  //           return false;
  //         },
  //         child: buildScaffold(context));
  //   } else {
  //     return buildScaffold(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formkey,
            child: ListView(
              children: [
                buildNameField(),
                // buildDataField(),
                buildDateTimeField(),
                buildCityField(),
                buildAboutField(),
                // buildPhotoField(),
                if (registrationComplete) buildAdditionalFields(),
                const SizedBox(height: 20.0),
                buildApproveField(),
                if (registrationComplete) buildPsycho(),
                const SizedBox(height: 20.0),
                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                    onPressed: () {
                      Color color = Colors.red;
                      String text;

                      if (!_formkey.currentState!.validate()) {
                        text = 'Необходимо заполнить поля';
                      } else {
                        _formkey.currentState!.save();
                        UserPreferences().setUserObject(user!);


                        text = 'Данные профиля сохранены';
                        color = Colors.green;
                        if (registrationComplete) {
                          //Navigator.pop(context, user);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => MyHomePage(index: 4,)),
                          // );
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              MyHomePage(index: 4,)), (Route<dynamic> route) => false);
                        } else {
                          UserPreferences().setLoggedIn(true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        }
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

  String? validateImageUrl(String? value) {
    String pattern = r'^https?:\/\/.*\.(jpeg|jpg|gif|png)$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!) && value.isNotEmpty) {
      return 'Неверный формат ссылки';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Укажите адрес элекронной почты';
    } else if (!regex.hasMatch(value)) {
      return 'Неверный формат адреса почты';
    } else {
      return null;
    }
  }
}
