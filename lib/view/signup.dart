import 'package:blind_dating/homewidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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


        //  ElevatedButton(
        //   onPressed: () {
        //     Get.to(const HomeWidget());
        //   }, 
        //   child: const Text("홈 화면으로 이동")