import 'package:blind_dating/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileModify extends StatefulWidget {
  const ProfileModify({super.key});

  @override
  State<ProfileModify> createState() => _ProfileModifyState();
  
}

class _ProfileModifyState extends State<ProfileModify> {

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
                SizedBox(height: 60,),
                ElevatedButton(
                  onPressed: () {
                    Get.to(const Profile());
                  },
                  style: TextButton.styleFrom(
                        minimumSize: Size(220, 50),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color.fromARGB(255, 146, 148, 255),
                          foregroundColor: Color.fromARGB(255, 234, 234, 236)
                      ),
                  child: Text('확인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
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