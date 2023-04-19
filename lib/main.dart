import 'package:flutter/material.dart';
import 'data/userPreferences.dart';
import 'screens/registration_and_login_screens/profile_page.dart';
import 'screens/registration_and_login_screens/login_page.dart';
import 'screens/app_bar_screens/helpers_list_page.dart';

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
        title: 'Экран помощники',
        home: HelpersListPage(),
      );
    } else if (goToProfilePage) {
      return const MaterialApp(
        title: 'Экран анкеты',
        home: ProfileScreen(),
      );
    } else {
      return const MaterialApp(
        title: 'Вход',
        home: LoginPage(),
      );
    }
  }
}

