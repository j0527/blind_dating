import 'dart:io';

import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/signupthird.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSecond extends StatefulWidget {
  const SignUpSecond({super.key});

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }


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
                Image.asset('images/stepsecond.png'),
                SizedBox(height: 35, width: double.infinity),
                      _buildPhotoArea(),
                SizedBox(height: 35),
                        _buildButton(),
          
                          
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 75, 15, 80),
                    child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => SignUpThird());
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


  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Color.fromARGB(255, 212, 221, 247),
          );
  }


  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            getImage(ImageSource.camera); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          style: TextButton.styleFrom(
                        minimumSize: Size(130, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 152, 175, 250),
                          foregroundColor: Color.fromARGB(255, 234, 234, 236)
                      ),
          icon: Icon(Icons.camera_alt_outlined), 
          label: Text("카메라", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
      ],
    );
  }
}