import 'package:flutter/material.dart';
import 'package:music_app/constant/import.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: 200.h,
        color: Colors.orange,
        child: Text(
          localize(context, LanguageKey.selectLanguage),
        ),
      )),
    );
  }
}
