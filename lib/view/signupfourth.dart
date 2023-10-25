import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../homewidget.dart';

class SignUpFourth extends StatefulWidget {
  const SignUpFourth({super.key});

  @override
  State<SignUpFourth> createState() => _SignUpFourthState();
}

class _SignUpFourthState extends State<SignUpFourth> {
  late String inputValue;
  String selectedSmoke = "";
  String selectedExtroverted = "";
  String selectedSensing = "";
  String selectedThinking = "";
  String selectedJudging = "";

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
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(94, 88, 176, 0.945),
                        fontWeight: FontWeight.bold),),
        leading: IconButton(
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
                Image.asset('images/stepfourth.png'),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                      child: Text(
                        '흡연여부',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 54, 54, 58),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSmoke = "흡연";
                          });
                        },
                        style: TextButton.styleFrom(
                            minimumSize: Size(120, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: selectedSmoke == "흡연"
                                ? Color.fromARGB(255, 250, 188, 152)
                                : Color.fromARGB(255, 239, 238, 238),
                            // backgroundColor: const Color.fromARGB(255, 238, 236, 236),
                            foregroundColor: Colors.black),
                        child: Text(
                          '흡연',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSmoke = "비흡연";
                          });
                        },
                        style: TextButton.styleFrom(
                            minimumSize: Size(120, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: selectedSmoke == "비흡연"
                                ? Color.fromARGB(255, 250, 188, 152)
                                : Color.fromARGB(255, 239, 238, 238),
                            foregroundColor: Colors.black),
                        child: Text(
                          '비흡연',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 330, 0),
                  child: Text(
                    'mbti',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 54, 54, 58),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text(
                    '외향형/내향형',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedExtroverted = "E";
                          });
                        },
                        style: TextButton.styleFrom(
                            minimumSize: Size(170, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: selectedExtroverted == "E"
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                            foregroundColor: Colors.black),
                        child: Text('E'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedExtroverted = 'I';
                          });
                        },
                        style: TextButton.styleFrom(
                            minimumSize: Size(170, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: selectedExtroverted == "I"
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                            foregroundColor: Colors.black),
                        child: Text('I'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text(
                    '감각형/직관형',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                            selectedSensing = 'S';
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedSensing == 'S'
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('S')),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                            selectedSensing = 'N';
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedSensing == 'N'
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('N')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text(
                    '사고형/감정형',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                            selectedThinking = 'T';
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedThinking == 'T'
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('T')),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                            selectedThinking = "F";
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedThinking == 'F'
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('F')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 290, 0),
                  child: Text(
                    '판단형/인식형',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 54, 54, 58)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                            selectedJudging = "J";
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedJudging == 'J'
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('J')),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                          setState(() {
                            selectedJudging = "P";
                          });
                          },
                          style: TextButton.styleFrom(
                              minimumSize: Size(170, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: selectedJudging == "P"
                                ? Color.fromARGB(255, 254, 145, 145)
                                : Color.fromARGB(255, 239, 238, 238),
                              foregroundColor: Colors.black),
                          child: Text('P')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(HomeWidget());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(400, 50),
                      backgroundColor: Color.fromARGB(255, 146, 148, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "홈 화면으로 이동",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 234, 234, 236)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
