import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/signupthird.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpSecond extends StatefulWidget {
  const SignUpSecond({super.key});

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  late String inputValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  DateTime dateTime = DateTime(2000, 1, 1);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
                  Get.back(); // Get 패키지를 사용하여 이전 페이지로 이동합니다.
                  },
                ),
              ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('images/stepsecond.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Text('Sign Up', style: TextStyle(fontSize: 20, color: Color.fromRGBO(94, 88, 176, 0.945), fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 25,),
                Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 330, 0),
                        child: Text('카메라', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                          ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 50),
                    child: ElevatedButton(
                            onPressed: () {
                              Get.to(SignUpThird());
                            },
                            style: ElevatedButton.styleFrom(
                            minimumSize: Size(400, 50),
                            backgroundColor: Color.fromARGB(255, 169, 170, 230),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                            child: const Text("다음", style: TextStyle(fontSize:16 ,color: Color.fromARGB(255, 65, 61, 156)),),),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}