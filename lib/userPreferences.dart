import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferenses.dart';

class UserPreferences {
  //создание переменной для сохранения preferences
  static SharedPreferences? _preferences;

  //ключ для текстового поля
  final _keyUsername = 'username';
  final _keyPassword = 'userpassword';

  //инициализация preferences
  Future init() async => _preferences = await SharedPreferences.getInstance();

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
}
