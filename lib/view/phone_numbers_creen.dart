import 'package:blind_dating/homewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class phoneNumberScreen extends StatefulWidget {
  const phoneNumberScreen({super.key});

  @override
  State<phoneNumberScreen> createState() => _phoneNumberScreenState();
}

class _phoneNumberScreenState extends State<phoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIDReceived = "";

  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF3F9),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(height: 150,),
                  IconButton(
                    onPressed: () {
                      //
                    },
                    // onPressed: () => Get.back(),
                              icon: Icon(Icons.arrow_back_ios)),

                  Text('',),
                ],
              ),
              
                SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 45, 0),
                                  child: Text('전화번호를 입력해 주세요.',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)
                            ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Text('가입 여부 확인에만 활용되며, 절대 노출되지 않아요.',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey),
                        ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "+821012345678",
                  ),
                  keyboardType: TextInputType.phone,),
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: otpCodeVisible,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: otpController,
                    decoration: InputDecoration(labelText: "code")),
                ),
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: () {
                if(otpCodeVisible){
                  verifyCode();
                }else{
                  verifyNumber();
                }
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: Size(350, 50),
                backgroundColor: Color.fromARGB(255, 141, 148, 244),
                foregroundColor:  Color.fromARGB(255, 245, 245, 245)
              ),
              child: Text(otpCodeVisible? "로그인" : "인증번호 요청", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) {
          auth
              .signInWithCredential(credential)
              .then((value) => {print("you are logged in successfully")});
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
          otpCodeVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Get.to(const HomeWidget());
    });
  }
}

