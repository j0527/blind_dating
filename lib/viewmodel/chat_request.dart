import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequest extends GetxController {
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  // final LoadUserData userDataController = Get.put(LoadUserData());
  final LoadUserData userDataController = Get.find();   // LoadUserData 컨트롤러 가져오기
  // 사용자 로그인 정보 받아둘 리스트
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자

  // 사용자에게 채팅 요청 페이지 오도록
  final FirebaseFirestore _requestChatFirestore = FirebaseFirestore.instance;
  final RxBool chatRequested = false.obs;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: FutureBuilder(
  //       future: Future.wait([userDataController.getLoginData()]),
  //       // 에러 처리 로직 추가 가능
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           if (snapshot.hasData) {
  //             List loginData = snapshot.data!; // 로그인된 유저의 데이터
  //             // 데이터가 있다면 여기 화면이 그려짐 (원치 않을경우 이부분 없애고 그냥 전역변수에 저장시키는 용도로 써도됨)
  //             return Column(
  //               children: [
  //                 Text("User ID: ${loginData[0]['uid']}"),
  //                 // 여기서 불러오고 싶은거 불러오면 됨 loginData[0]['unickname'] 하면 유저 닉네임 불러와짐
  //               ],
  //             );
  //             // -----
  //           } else {
  //             return const Text("데이터 없음");
  //           }
  //         } else if (snapshot.connectionState ==
  //             ConnectionState.waiting) {
  //           return const CircularProgressIndicator();
  //         } else {
  //           return const Text("데이터 로딩 중 오류 발생");
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void onInit() {
    super.onInit();
    _listenForChatRequests();
  }

  void _listenForChatRequests() {
    // 사용자 데이터 가져오기 위한 함수 호출
    Future.delayed(Duration.zero, () {
      _getUserData();
    });

  }

  void _getUserData() {
    // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());
  FutureBuilder(
      future: userDataController.getLoginData(),
      // 에러 처리 로직 추가 가능
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            loginData = snapshot.data!; // 로그인된 유저의 데이터
            _checkChatRequests(loginData);
            return Column(
              children: [
                Text("User ID: ${loginData[0]['uid']}"),
                // 여기서 불러오고 싶은거 불러오면 됨 loginData[0]['unickname'] 하면 유저 닉네임 불러와짐
              ],
            );
            // -----
          } else {
            return const Text("데이터 없음");
          }
        } else if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return const Text("데이터 로딩 중 오류 발생");
        }
      },
    );
  }

  void _checkChatRequests(loginData) {
    _requestChatFirestore.collection('requestChats')
    .where('to', isEqualTo: '${loginData[0]['uid']}')
    .where('acceptState', isEqualTo: 'wait')
    .snapshots()
    .listen((snapshot) {
      for (final doc in snapshot.docs) {
        _showChatRequestDialog(doc);
      }
    });
  }


  void _showChatRequestDialog(DocumentSnapshot requestDoc) {
    final from = requestDoc['from'];
    Get.defaultDialog(
      title: "채팅 요청",
      content: Text(
        "$from님으로부터 채팅 요청이 왔습니다."
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                _updateRequest(requestDoc.reference, 'accept');
              }, 
              child: const Text("Accept"),
            ),
            TextButton(
              onPressed: () {
                _updateRequest(requestDoc.reference, 'reject');
              }, 
              child: const Text("Reject"),
            ),
            TextButton(
              onPressed: () {
                _updateRequest(requestDoc.reference, 'hold');
              }, 
              child: const Text("Hold"),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _updateRequest(DocumentReference chatReq, String state) {
    return chatReq.update({'acceptState' : state});
  }


}