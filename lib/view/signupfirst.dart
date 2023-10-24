import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/signupsecond.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class SignUpFirst extends StatefulWidget {
  const SignUpFirst({super.key});

  @override
  State<SignUpFirst> createState() => _SignUpFirstState();
}

class _SignUpFirstState extends State<SignUpFirst> {
  late TextEditingController IDController;
  late TextEditingController PWController;
  late TextEditingController PWCheckController;
  late String inputValue;

  @override
  void initState() {
    super.initState();
      IDController = TextEditingController();
      PWController = TextEditingController();
      PWCheckController = TextEditingController();
      inputValue = "";
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
                Image.asset('images/stepfirst.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Text('Sign Up', style: TextStyle(fontSize: 20, color: Color.fromRGBO(94, 88, 176, 0.945), fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(style: TextStyle(fontSize: 16),
                    controller: IDController,
                    decoration: const InputDecoration(
                    hintText: '아이디',
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 88, 104, 126),)
                        ),
                        readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(style: TextStyle(fontSize: 18),
                    controller: PWController,
                    decoration: const InputDecoration(
                    labelText: "비밀번호",
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 88, 114, 126),)
                    ),
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      inputValue = PWController.text;
                    },
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(style: TextStyle(fontSize: 18),
                    controller: PWCheckController,
                    decoration: const InputDecoration(
                    labelText: "비밀번호 확인",
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 88, 114, 126),)
                    ),
                    keyboardType: TextInputType.text,
                      onSubmitted: (value) {
                      inputValue = PWCheckController.text;
                    },
                    obscureText: true,
                  ),
                ),
                Text('비밀번호는 영문 대소문자, 숫자를 혼합하여 8~15자로 입력해 주세요.', style: TextStyle(fontSize: 12),),
                SizedBox(height: 40,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 30, 0),
                      child: Text('성별', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 54, 58), fontWeight: FontWeight.bold),),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton.icon(
                      onPressed: () {
                        //
                      },
                      style: TextButton.styleFrom(
                      minimumSize: Size(120, 50),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 238, 236, 236),
                      foregroundColor: Color.fromARGB(255, 80, 100, 144)
                    ),
                      icon: Icon(Icons.man), 
                      label: Text('Male', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextButton.icon(
                      onPressed: () {
                        //
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size(120, 50),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 238, 236, 236),
                      foregroundColor: Color.fromARGB(255, 80, 100, 144)
                    ),
                      icon: Icon(Icons.woman), 
                      label: Text('Female', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
                  ),
                  ],
                ),
                SizedBox(height: 35,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 15, 0),
                      child: Text('생년월일', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                    ),
                    CupertinoButton(
                      color: Color.fromARGB(255, 150, 170, 189),
                      child: Text('${dateTime.year}-${dateTime.month}-${dateTime.day}'),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                            height: 550,
                            child: CupertinoDatePicker(
                              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                              initialDateTime: dateTime,
                              onDateTimeChanged: (DateTime newTime) {
                                setState(() => dateTime = newTime);
                              },
                              use24hFormat: true,
                              mode: CupertinoDatePickerMode.date,
                              ),
                              )
                              );
                      },
                      ),
                  ],
                ),
                SizedBox(height: 35,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                      child: Text('주소', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                SizedBox(height: 35,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 50),
                    child: ElevatedButton(
                            onPressed: () {
                              Get.to(SignUpSecond());
                            },
                            style: ElevatedButton.styleFrom(
                            minimumSize: Size(400, 50),
                            backgroundColor: Color.fromARGB(255, 146, 148, 255),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                            child: const Text("다음", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold ,color:Color.fromARGB(255, 234, 234, 236)),),),
                  ),
              ],
            ),
          ),
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