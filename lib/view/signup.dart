import 'package:blind_dating/homewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String inputValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      inputValue = "";
  }
  TextEditingController IDController = TextEditingController();
  TextEditingController PWController = TextEditingController();
  TextEditingController PWCheckController = TextEditingController();


  DateTime dateTime = DateTime(2000, 1, 1);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 80, 50, 0),
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
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      inputValue = PWController.text;
                    },
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
                SizedBox(height: 30,),
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
                SizedBox(height: 25,),
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
                SizedBox(height: 25,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                      child: Text('주소', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                      child: Text('흡연여부', style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton(
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
                      child: Text('흡연', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextButton(
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
                      child: Text('비흡연', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
                  ),
                  ],
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 330, 0),
                  child: Text('mbti', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text('외향형/내향형', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color.fromARGB(255, 239, 238, 238),
                        foregroundColor: Colors.black
                      ),
                      child: Text('E')),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color.fromARGB(255, 239, 238, 238),
                        foregroundColor: Colors.black
                      ),
                      child: Text('I')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text('감각형/직관형', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('S')),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('N')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text('사고형/감정형', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('T')),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('F')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text('판단형/인식형', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('J')),
                      SizedBox(width: 10,),
                      TextButton(onPressed: () {
                        //
                      }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 239, 238, 238),
                          foregroundColor: Colors.black
                      ),
                      child: Text('P')),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 330, 0),
                        child: Text('카메라', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 54, 54, 58),fontWeight: FontWeight.bold),),
                          ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                    child: ElevatedButton(
                            onPressed: () {
                              Get.to(const HomeWidget());
                            },
                            style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50),
                            backgroundColor: Color.fromARGB(255, 169, 170, 230),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                            child: const Text("홈 화면으로 이동", style: TextStyle(fontSize:16 ,color: Color.fromARGB(255, 65, 61, 156)),),),
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