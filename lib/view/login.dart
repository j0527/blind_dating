import 'package:blind_dating/homewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(const HomeWidget());
          }, 
          child: const Text("로그인 후 화면으로 이동")
        ),
      ),
    );
  }
}