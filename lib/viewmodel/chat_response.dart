import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatResponse extends GetxController {
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());   // LoadUserData 컨트롤러 가져오기
  // 사용자 로그인 정보 받아둘 리스트
  late List users = [];
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자

  // 사용자에게 채팅 요청 페이지 오도록
  final FirebaseFirestore _responseChatFirestore = FirebaseFirestore.instance;
  final RxBool chatRequested = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() async{
    users.add(await userDataController.getLoginData());
    users.add(await userDataController.getUserData());

    loginData = users[0];   // 현재 기기 로그인한 유저 정보
    userData = users[1];    // 상대 유저 정보
    _checkChatResponse(loginData[0]['uid']);
    // _checkChatRequests(userData[0]['uid']);
    // _checkResponse(userData[0]['uid']);
  }

  void _checkChatResponse(String userId) {      
    _responseChatFirestore.collection('requestChats')
    .where('from', isEqualTo: userId)
    .where('acceptState', whereIn: ['accept', 'reject', 'hold'])
    .snapshots()
    .listen((snapshot) { 
      for (final doc in snapshot.docs) {
        _showChatResponseDialog(doc);
      }
    });
  }

  void _showChatResponseDialog(DocumentSnapshot responseDoc) {
    final to = loginData[0]['unickname'];       // 채팅 요청한 사람 닉네임
    final state = responseDoc['acceptState'];

    state == 'accept' 
    ? Get.defaultDialog(
      title: '채팅 요청 수락',
      content: Text(
        "$to 님께서 요청을 수락하셨습니다. \n바로 채팅방으로 이동하시겠습니까?"
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // 채팅 화면으로 보내기 
              }, 
              child: const Text("확인")
            ),
            TextButton(
              onPressed: () {
                Get.back();
              }, 
              child: const Text("나중에")
            ),
          ],
        )
      ]
    )
    : state == 'reject'
      ? Get.defaultDialog(
        title: '채팅 요청 거절',
        content: Text(
          "$to 님께서 요청을 거절하셨습니다. "
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Get.back(), 
              child: const Text("확인"),
            ),
          )
        ]
      )
      : Get.defaultDialog(
        title: '채팅 요청 보류',
        content: Text(
          "$to 님께서 요청 수락을 보류하셨습니다. "
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Get.back(), 
              child: const Text("확인"),
            ),
          )
        ]
      );
  
  }








}