import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile8_project1/screens/app_bar_screens/app_bar.dart';
import 'package:mobile8_project1/screens/registration_and_login_screens/profile_edit_page.dart';
import 'classes.dart';
import 'data/userPreferences.dart';
import 'screens/registration_and_login_screens/login_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  User? user = UserPreferences().getUserObject();
  if (user == null || user.name.isEmpty) { //это нужно, чтобы разлогинить, если не заполнен и не сохранен профиль (так было в начале разработки)
    await UserPreferences().clear();
  }

 // await UserPreferences().clear(); //если раскомментить эту строчку, то сбросятся все сохраненные данные пользователя - если надо для тестов
  runApp(AdvisersApp());
}

class AdvisersApp extends StatelessWidget {
  AdvisersApp({super.key});

  final bool goToMainPage = UserPreferences().getLoggedIn(); //идти на главную страницу ("Ждут помощи"), если регистрация полностью завершена
  final bool goToProfilePage = UserPreferences().getTelephoneVerificationComplete(); //идти на страницу заполнения профиля при регистрации, если она не была заполнена
  // здесь еще нужно обрабатывать если юзер зареган, но не залогинен
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [ //локализация нужна, чтобы в виджете календаря в поле дата рождения был русифицированный календарь
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ru'),
      debugShowCheckedModeBanner: false,
      home: buildHomePage(),
    );
  }

  Widget buildHomePage() {
    if (goToMainPage) {
      return MyHomePage();
    } else if (goToProfilePage) {
      return ProfileScreen();
    } else {
      return LoginPage();
    }
  }
}
