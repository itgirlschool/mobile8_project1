import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferenses.dart';

class UserPreferences {
  //создание переменной для сохранения preferences
  static SharedPreferences? _preferences;

  //ключ для текстового поля
  final _keyUsername = 'username';
  final _keyPassword = 'userpassword';
  final _keyTelephoneVerified = 'telephoneVerified';
  final _keyRegistrationComplete = 'registrationComplete';
  final bool _telephoneVerifiedDefault = false;
  final bool _registrationCompleteDefault = false;

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
  Future<bool>? setTelephoneVerificationComplete() =>
      _preferences?.setBool(_keyTelephoneVerified, true);

  //сохраняем флажок, что регистрация полностью завершена, включая обязательную анкету
  Future<bool>? setRegistrationComplete() =>
      _preferences?.setBool(_keyRegistrationComplete, true);

  //Проверка пройдена ли верификация номера телефона и полная регистрация
  bool getTelephoneVerificationComplete() =>
      _preferences?.getBool(_keyTelephoneVerified) ?? _telephoneVerifiedDefault;

  bool getRegistrationComplete() =>
      _preferences?.getBool(_keyRegistrationComplete) ??
      _registrationCompleteDefault;
}
