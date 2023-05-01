//страница верификации номера телефона. Код не отправляется, просто анимация

import 'package:mobile8_project1/screens/registration_and_login_screens/profile_edit_page.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import '../../data/userPreferences.dart';

class TelephoneCodeVerificationPage extends StatefulWidget {
  const TelephoneCodeVerificationPage({Key? key}) : super(key: key);

  @override
  State<TelephoneCodeVerificationPage> createState() =>
      _TelephoneCodeVerificationPageState();
}

class _TelephoneCodeVerificationPageState
    extends State<TelephoneCodeVerificationPage> {
  bool bottomMessageVisible = false;
  final String correctPin = '123456';
  String pin = '';
  String pinError = '';
  bool sendPinButtonDisabled = false;

  final sixDigitsPinTheme = PinTheme(
    width: 45,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFB7B6B6)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              pinController.setText('');
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text(),

                      const Text(
                        'Подтверждение номера телефона',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 50.0),
                      Pinput(
                        defaultPinTheme: sixDigitsPinTheme,
                        length: 6,
                        controller: pinController,
                        onCompleted: validateAndPush,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        pinError,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: sendPinButtonDisabled
                            ? null
                            : () {
                          setState(() {
                            bottomMessageVisible = true;
                            sendPinButtonDisabled = true;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Отправить код подтверждения\n          на указанный номер'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        pinController.setText(correctPin);
                      });
                    },
                    child: SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: AnimatedOpacity(
                          opacity: bottomMessageVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1800),
                          curve: const Interval(0.5, 0.8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffa7e799),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SizedBox(
                             // height: 70,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(right: 20, left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ваш код подтверждения: $correctPin",
                                    ),
                                    const SizedBox(height: 5.0),
                                    const Text(
                                      "Нажмите для ввода",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateAndPush(pin) async {
    //final prefs = await SharedPreferences.getInstance();
    if (pin != correctPin) {
      setState(() {
        pinError = 'Неверный код';
      });
    } else {
      UserPreferences().setTelephoneVerificationComplete(true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );

    }
  }
}

final pinController = TextEditingController();
