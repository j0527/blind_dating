import 'dart:io';

import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModify extends StatefulWidget {
  const ProfileModify({super.key});

  @override
  State<ProfileModify> createState() => _ProfileModifyState();
  
}

class _ProfileModifyState extends State<ProfileModify> {

  late TextEditingController IDController;
  late TextEditingController PWController;
  late TextEditingController PWCheckController;
  late TextEditingController AddressController;
  late String inputValue;


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
  void initState() {
    super.initState();
      IDController = TextEditingController();
      PWController = TextEditingController();
      PWCheckController = TextEditingController();
      AddressController = TextEditingController();
      inputValue = "";
  }


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
                SizedBox(height: 5, width: double.infinity),
                  _buildPhotoArea(),
                SizedBox(height: 15),
                _buildButton(),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
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
                  padding: const EdgeInsets.all(5.0),
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
                  padding: const EdgeInsets.all(5.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
                  child: TextField(style: TextStyle(fontSize: 16),
                    controller: AddressController,
                    decoration: const InputDecoration(
                    hintText: '주소',
                    prefixIcon: Icon(Icons.home, color: Color.fromARGB(255, 88, 104, 126),)
                        ),
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                    inputValue = AddressController.text;}
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                      "수정완료",
                      "변경된 사항이 저장되었습니다.",
                      snackPosition: SnackPosition.BOTTOM, //스낵바 위치설정
                      duration: Duration(seconds: 2),
                      backgroundColor: Color.fromARGB(255, 59, 160, 237),
                      );
                      Get.to(() => HomeWidget());
                    },
                    style: TextButton.styleFrom(
                          minimumSize: Size(170, 50),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromARGB(255, 146, 148, 255),
                            foregroundColor: Color.fromARGB(255, 234, 234, 236)
                        ),
                    child: Text('확인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                )
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
            width: 200,
            height: 200,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 200,
            height: 200,
            color: Color.fromARGB(255, 212, 221, 247),
          );
  }


  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          style: TextButton.styleFrom(
                        minimumSize: Size(130, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 152, 175, 250),
                          foregroundColor: Color.fromARGB(255, 234, 234, 236)
                      ),
          icon: Icon(Icons.photo), 
          label: Text("갤러리", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
      ],
    );
  }
}