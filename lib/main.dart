import 'package:flutter/material.dart';
import 'package:mobile8_project1/screens/app_bar_screens/app_bar.dart';
import 'data/userPreferences.dart';
import 'screens/registration_and_login_screens/login_page.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  ///await UserPreferences().clear(); //если раскомментить эту строчку, то сбросятся все сохраненные данные пользователя - если надо для тестов
  runApp(AdvisersApp());
}

class AdvisersApp extends StatelessWidget {
  AdvisersApp({super.key});

  final bool goToMainPage = UserPreferences().getRegistrationComplete();
  final bool goToProfilePage =
      UserPreferences().getTelephoneVerificationComplete();

  @override
  Widget build(BuildContext context) {
    if (goToMainPage) {
      return const MaterialApp(
        //title: 'Вход',
        home: MyHomePage(),
      );
    } else {
      return const MaterialApp(
        title: 'Вход',
        home: LoginPage(),
      );
    }
  }
}

