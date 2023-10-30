import 'dart:io';
import 'package:blind_dating/homewidget.dart';
import 'package:blind_dating/view/signupthird.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSecond extends StatefulWidget {
  const SignUpSecond({Key? key}) : super(key: key);

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  XFile? _photoImage;
  XFile? _galleryImage;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      if (imageSource == ImageSource.camera) {
        setState(() {
          _photoImage = pickedFile;
        });
      } else {
        setState(() {
          _galleryImage = pickedFile;
        });
      }
    }
  }

  Widget _buildGalleryButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            style: TextButton.styleFrom(
                minimumSize: Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color.fromARGB(255, 152, 175, 250),
                foregroundColor: Color.fromARGB(255, 234, 234, 236)),
            icon: Icon(Icons.photo),
            label: Text(
              "갤러리",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(94, 88, 176, 0.945),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
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
                SizedBox(height: 35),
                _buildPhotoArea(),
                SizedBox(height: 35),
                _buildButton(),
                SizedBox(height: 25),
                _buildGalleryArea(),
                SizedBox(height: 25),
                _buildGalleryButton(),
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
    return _photoImage != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_photoImage!.path)),
          )
        : Container(
            width: 300,
            height: 300,
            color: Color.fromARGB(255, 212, 221, 247),
          );
  }

  Widget _buildGalleryArea() {
    return _galleryImage != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_galleryImage!.path)),
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
              getImage(ImageSource.camera);
            },
            style: TextButton.styleFrom(
                minimumSize: Size(130, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color.fromARGB(255, 152, 175, 250),
                foregroundColor: Color.fromARGB(255, 234, 234, 236)),
            icon: Icon(Icons.photo),
            label: Text(
              "카메라",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
