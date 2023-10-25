// ignore_for_file: file_names

import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImageSliderWidget extends StatelessWidget {
  DetailImageSliderWidget({super.key});

    // 유저와 관련된 getX
  final LoadUserData userDataController = Get.put(LoadUserData());


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}

// 디테일창 이미지 슬라이더 위젯
// ignore: camel_case_types
class detailImageSliderWidget extends StatelessWidget {
  const detailImageSliderWidget({
    super.key,
    required this.userImagePath,
    required this.userName,
    required this.userAge,
  });

  final String userImagePath;
  final String userName;
  final String userAge;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
      ],
    );
  }
}







        // SizedBox(
        //   width: 400,
        //   height: 400,
        //   child: Image.network(userImagePath, fit: BoxFit.fill)
        //   ),
        // Row(
        //   children: [
        //     Text(userName),
        //     Text(userAge),
        //   ],
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: ElevatedButton(
        //     onPressed: () {
        //       // 채팅 연결, 결제 관련해서 다이어로그 띄워주기도 해야함
        //     },
        //     style: ElevatedButton.styleFrom(
        //         backgroundColor: Colors.orangeAccent,
        //         foregroundColor: Colors.white,
        //         minimumSize: const Size(80, 40), // 버튼 사이즈 조절해서 통일성주기
        //         shape: RoundedRectangleBorder(    // 버튼 모양 다듬기
        //           borderRadius: BorderRadius.circular(6),
        //         ),
        //     ), 
        //     child: const Text('이 강아지와 진솔한 대화하기 ❤️',
        //     style: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold),
        //     ),
        //     ),
        // ),



