import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text("소🐶팅"),
      // ),
      body: Login(),
      // body: const HomeWidget(),   // login 화면으로 바꾸고, login에서 HomeWidget으로 넘어가도록 수정해야함
    );
  }
}
