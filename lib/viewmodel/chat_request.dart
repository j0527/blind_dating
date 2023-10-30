import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequest extends GetxController {
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());   // LoadUserData 컨트롤러 가져오기
  // 사용자 로그인 정보 받아둘 리스트
  late List users = [];
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자

  // 사용자에게 채팅 요청 페이지 오도록
  final FirebaseFirestore _requestChatFirestore = FirebaseFirestore.instance;
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
    _checkChatRequests(loginData[0]['uid']);
    // _checkChatRequests(userData[0]['uid']);
    // _checkResponse(userData[0]['uid']);
  }

  void _checkChatRequests(String userId) {      
    _requestChatFirestore.collection('requestChats')
    .where('to', isEqualTo: userId)
    .where('acceptState', isEqualTo: 'wait')
    .snapshots()
    .listen((snapshot) { 
      for (final doc in snapshot.docs) {
        _showChatRequestDialog(doc);
      }
    });
  }   // 누가 나한테 요청을 보냈을 때 나에게 요청 다이어로그 보여주기 ('나 - 로그인한 사용자' 기준)


  void _showChatRequestDialog(DocumentSnapshot requestDoc) {    // 나에게 보여주는 다이어로그
    // final from = requestDoc['from'];
    final from = userData[0]['unickname'];      // 상대 닉네임
    // final userId = userData
    
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
                _checkResponse(userData[0]['uid']);
              }, 
              child: const Text("수락하기"),
            ),
            TextButton(
              onPressed: () {
                _updateRequest(requestDoc.reference, 'reject');
                _checkResponse(userData[0]['uid']);
              }, 
              child: const Text("거절하기"),
            ),
            TextButton(
              onPressed: () {
                _updateRequest(requestDoc.reference, 'hold');
                _checkResponse(userData[0]['uid']);
              }, 
              child: const Text("보류하기"),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _updateRequest(DocumentReference chatReq, String state) {
    return chatReq.update({'acceptState' : state});
  }

  void _checkResponse(String userId) {
    _requestChatFirestore.collection('requestChats')
    .where('from', isEqualTo: userId)
    .where('acceptState', isNotEqualTo: 'wait')
    .snapshots()
    .listen((snapshot) { 
      for (final doc in snapshot.docs) {
        showResponseDialog(doc);
      }
    });
  }

  void showResponseDialog(DocumentSnapshot requestDoc) {
    final acceptState = requestDoc['acceptState'];

    acceptState == 'accept' 
      ? Get.defaultDialog(
        title: '채팅 요청 수락',
        content: Text(
          "${userData[0]['unickname']} 님께서 요청을 수락하셨습니다. \n바로 채팅방으로 이동하시겠습니까?"
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
      : acceptState == 'reject'
        ? Get.defaultDialog(
          title: '채팅 요청 거절',
          content: Text(
            "${userData[0]['unickname']} 님께서 요청을 거절하셨습니다. "
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
            "${userData[0]['unickname']} 님께서 요청 수락을 보류하셨습니다. "
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