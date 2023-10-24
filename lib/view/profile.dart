import 'package:blind_dating/view/profilemodify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              CircleAvatar(
                backgroundImage: AssetImage('images/퍼그.png'),
                radius: 100,
                  ),
                SizedBox(height: 40,),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const ProfileModify());
                  },
                  style: TextButton.styleFrom(
                        minimumSize: Size(170, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 146, 148, 255),
                          foregroundColor: Color.fromARGB(255, 234, 234, 236)
                      ),
                  child: Text('프로필 수정', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}