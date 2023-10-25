import 'dart:io';

import 'package:blind_dating/view/signupfourth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpThird extends StatefulWidget {
  const SignUpThird({super.key});

  @override
  State<SignUpThird> createState() => _SignUpThirdState();
}

class _SignUpThirdState extends State<SignUpThird> {
  List<XFile?> _imageprofile = List.generate(2, (_) => null); // 이미지를 담을 변수 선언
  List<XFile?> _imagehobby = List.generate(3, (_) => null); // 이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); // ImagePicker 초기화

  // 이미지를 가져오는 함수
  Future getImage(int index, ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        if (index < _imageprofile.length) {
          _imageprofile[index] = pickedFile; // 가져온 이미지를 _imageprofile 리스트에 저장
        } else if (index < _imageprofile.length + _imagehobby.length) {
          _imagehobby[index - _imageprofile.length] =
              pickedFile; // 가져온 이미지를 _imagehobby 리스트에 저장
        }
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
                Image.asset('images/stepthird.png'),
                                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
                  child: Text(
                    '프로필 사진을 등록해 주세요',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 54, 54, 58),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 0, width: double.infinity),
                _buildPhotoArea(),
                SizedBox(height: 10), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child: ElevatedButton(onPressed: () {
                    //
                  }, 
                        style: TextButton.styleFrom(
                          minimumSize: Size(100, 40),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromARGB(255, 152, 175, 250),
                            foregroundColor: Color.fromARGB(255, 234, 234, 236)
                        ),
                  child: Text('프로필 사진 저장', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 190, 0),
                  child: Text(
                    '취미 사진을 등록해 주세요',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 54, 54, 58),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPhotoHobbyArea(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child: ElevatedButton(onPressed: () {
                    //
                  }, 
                      style: TextButton.styleFrom(
                        minimumSize: Size(100, 40),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 152, 175, 250),
                          foregroundColor: Color.fromARGB(255, 234, 234, 236)
                      ),
                  child: Text('취미 사진 저장', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 80),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SignUpFourth());
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(400, 50),
                      backgroundColor: Color.fromARGB(255, 146, 148, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "다음",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 234, 234, 236),
                      ),
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

  Widget _buildPhotoArea() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          for (int i = 0; i < _imageprofile.length; i++)
            Row(
              children: [
                _buildImagePicker(i, _imageprofile),
                SizedBox(width: 10), // 이미지 간의 간격 조절
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoHobbyArea() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          for (int j = 0;
              j < _imagehobby.length;
              j++) // 변경된 부분: _imagehobby.length 사용
            Row(
              children: [
                _buildImagePicker(j, _imagehobby), // 변경된 부분: _imagehobby 사용
                SizedBox(width: 10), // 이미지 간의 간격 조절
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(int index, List<XFile?> imageList) {
    return GestureDetector(
      onTap: () {
        if (imageList == _imageprofile) {
          getImage(index, ImageSource.gallery);
        } else if (imageList == _imagehobby) {
          getImage(index + _imageprofile.length, ImageSource.gallery);
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 212, 221, 247),
          image: imageList[index] != null
              ? DecorationImage(
                  image: FileImage(File(imageList[index]!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageList[index] == null
            ? Icon(
                Icons.add_a_photo,
                size: 48,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }
}
