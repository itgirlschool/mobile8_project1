import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../classes.dart';


class UserPreferences {
  //создание переменной для сохранения preferences
  static SharedPreferences? _preferences;

  //ключ для текстового поля
  final _keyUsername = 'username';
  final _keyPassword = 'userpassword';
  final _keyTelephoneVerified = 'telephoneVerified';
  final _keyLoggedIn = 'registrationComplete';
  final bool _telephoneVerifiedDefault = false;
  final bool _registrationCompleteDefault = false;
  final _keyUserObject  = 'userObject';

  //инициализация preferences
  Future init() async => _preferences = await SharedPreferences.getInstance();

  //функция очистки сохраненных данных пользователя - вызывать если надо сбросить данные
  Future clear() async => _preferences?.clear();

  // задаем значение username нашему ключу
  Future setUsername(String username) async =>
      await _preferences?.setString(_keyUsername, username);

  Future setPassword(String userpassword) async =>
      await _preferences?.setString(_keyPassword, userpassword);

  //читаем username
  String? getUsername() => _preferences?.getString(_keyUsername);

  String? getUserpassword() => _preferences?.getString(_keyPassword);

  // удаляем username
  Future<bool>? deleteUsername() => _preferences?.remove(_keyUsername);

  Future<bool>? deleteUserpassword() => _preferences?.remove(_keyPassword);

  //сохраняем флажок, что верификация номера телефона кодом пройдена
  Future<bool>? setTelephoneVerificationComplete(bool complete) =>
      _preferences?.setBool(_keyTelephoneVerified, complete);

  //сохраняем флажок, что регистрация полностью завершена, включая обязательную анкету
  Future<bool>? setLoggedIn(bool complete) =>
      _preferences?.setBool(_keyLoggedIn, complete);

  //Проверка пройдена ли верификация номера телефона и полная регистрация
  bool getTelephoneVerificationComplete() =>
      _preferences?.getBool(_keyTelephoneVerified) ?? _telephoneVerifiedDefault;

  bool getLoggedIn() =>
      _preferences?.getBool(_keyLoggedIn) ??
      _registrationCompleteDefault;

  //сохранение объекта юзера в виде json
  Future setUserObject(User user) async {
    Map<String, dynamic> userJson = user.toJson();
    await _preferences?.setString(_keyUserObject, jsonEncode(userJson));
  }

  //получение объекта юзера из сохраненного json
  User? getUserObject() {
    String? userJson = _preferences?.getString(_keyUserObject);
    if (userJson != null) {
      User fromJson =User.fromJson(jsonDecode(userJson));
      return fromJson;
    }
      return null;

  }
}
