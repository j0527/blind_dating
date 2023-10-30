import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequest extends GetxController {
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  // final LoadUserData userDataController = Get.put(LoadUserData());
  final LoadUserData userDataController = Get.put(LoadUserData());   // LoadUserData 컨트롤러 가져오기
  // 사용자 로그인 정보 받아둘 리스트
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자

  // 사용자에게 채팅 요청 페이지 오도록
  final FirebaseFirestore _requestChatFirestore = FirebaseFirestore.instance;
  final RxBool chatRequested = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
    // _checkChatRequests(loginData[0]['uid']);
  }

  void getUserData() async{
    final data = await Future.wait([userDataController.getLoginData()]);

    loginData = data[0];
    // userData = data[1];
    _checkChatRequests(loginData[0]['uid']);
  }

  void _checkChatRequests(String userId) {
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //   .collection('requestChats')
    //   .where('to', isEqualTo: userId)
    //   .where('acceptState', isEqualTo: 'wait')
    //   .snapshots(), 
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       print('오류 발생: ${snapshot.error.toString()}');
    //       return Center(child: Text('오류 발생: ${snapshot.error.toString()}'),);
    //     }
    //     if(!snapshot.hasData) {
    //       return const Center(child: CircularProgressIndicator(),);
    //     }
    //   },
    // );
    _requestChatFirestore.collection('requestChats')
    .where('to', isEqualTo: userId)
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