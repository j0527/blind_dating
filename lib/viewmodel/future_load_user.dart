// import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FutureLoadUser extends StatelessWidget {
//   final LoadUserData userDataController = Get.put(LoadUserData());

//   FutureLoadUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//         future: userDataController.getLoginData(),
//         // 에러 처리 로직 추가 가능
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               List loginData = snapshot.data!; // 로그인된 유저의 데이터
//               // 데이터가 있다면 여기 화면이 그려짐 (원치 않을경우 이부분 없애고 그냥 전역변수에 저장시키는 용도로 써도됨)
//               return Column(
//                 children: [
//                   Text("User ID: ${loginData[0]['uid']}"),
//                   // 여기서 불러오고 싶은거 불러오면 됨 loginData[0]['unickname'] 하면 유저 닉네임 불러와짐
//                 ],
//               );
//               // -----
//             } else {
//               return const Text("데이터 없음");
//             }
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else {
//             return const Text("데이터 로딩 중 오류 발생");
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FutureLoadUser {
  final LoadUserData userDataController = Get.put(LoadUserData());

  userDataLoad() async {
    FutureBuilder(
      future: userDataController.getLoginData(),
      // 에러 처리 로직 추가 가능
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List loginData = snapshot.data!; // 로그인된 유저의 데이터
            // 데이터가 있다면 여기 화면이 그려짐 (원치 않을경우 이부분 없애고 그냥 전역변수에 저장시키는 용도로 써도됨)
            // return Column(
            //   children: [
            //     Text("User ID: ${loginData[0]['uid']}"),
            //     // 여기서 불러오고 싶은거 불러오면 됨 loginData[0]['unickname'] 하면 유저 닉네임 불러와짐
            //   ],
            // );
            print("loginData[0]: ${loginData[0]}");
            return loginData[0];
            // -----
          } else {
            return const Text("데이터 없음");
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return const Text("데이터 로딩 중 오류 발생");
        }
      },
    );
  }
}
