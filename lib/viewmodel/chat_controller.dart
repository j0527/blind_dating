import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());   // LoadUserData 컨트롤러 가져오기
  // 사용자 로그인 정보 받아둘 리스트
  late List users = [];
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자

  // 사용자에게 채팅 요청 / 응답 데이터 실시간으로 받아올 firebase 인스턴스 생성
  // final FirebaseFirestore _requestChatFirestore = FirebaseFirestore.instance;
  final RxBool chatRequested = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
    // getUserData();
    // sendChatRequest();
    // receiveChatResponse();
  }

  void init() async{
    await getUserData();
  }

  // 유저 & 상대방 정보 가져오기
  Future<void> getUserData() async{
    users.add(await userDataController.initLocation());
    users.add(await userDataController.getUserData());
    users.add(await userDataController.getLoginData());
    // users.add(await userDataController.getLoginData());
    // users.add(await userDataController.getUserData());

    loginData = users[2];   // 현재 기기 로그인한 유저 정보
    userData = users[1];    // 상대 유저 정보

    // print("지니 컨트롤러 확인 : ${loginData[0]['uid']}");
    // print("지니 컨트롤러 닉네임 확인 : ${loginData[0]['unickname']}");

    // receiveChatResponse("${loginData[0]['uid']}");
  }

  // 상대에게 요청 보내기
  // void sendChatRequest() {
  //   // firebase - requestChat collection에  데이터 추가
  //   FirebaseFirestore.instance.collection('requestChats').add(
  //     {
  //       'from': loginData[0]['uid'],
  //       'to': userData[0]['uid'],
  //       'acceptState': 'wait',
  //       'requestedAt': FieldValue.serverTimestamp()
  //     }
  //   );
  //   // 보낸 요청 받기
  //   receiveChatResponse();
  // }

  // 나에게 요청이 들어올 때 (내가 요청 받음)
  void receiveChatResponse(String userId) async{
    await getUserData();
    // print("지니 컨트롤러 확인 : ${loginData[0]['uid']}");
    // print("지니 컨트롤러 닉네임 확인 : ${loginData[0]['unickname']}");
    FirebaseFirestore.instance.collection('requestChats')
    .where('to', isEqualTo: userId)
    .where('acceptState', isEqualTo: 'wait')
    .snapshots()
    .listen((snapshot) { 
      for (final doc in snapshot.docs) {
          _showChatRequestDialog(doc);    // 누구로 부터 요청이 왔다 보여주기
        // if (doc['acceptState'] == 'wait') {
          // _showResponseDialog(doc);     
        }
      // }
    });
  }

  // 요청 받는 사람이 보는 다이어 로그 함수 : 누구로부터 채팅이 왔는지, 수락 / 거부 / 보류 선택
  // 과정 : 각 선택에 따라 파이어베이스 필드 수정 - fromUser에게 dialog 보냄 - 다이어로그 닫음
  void _showChatRequestDialog(DocumentSnapshot requestCollection) {    // 상대에게 보여주는 다이어로그
    final fromUser = userData[0]['unickname'];    // 나로부터 상대에게 
    Get.defaultDialog(
      title: "채팅 요청",
      content: Text(
        "$fromUser 님으로부터 채팅 요청이 왔습니다."
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 요청 수락
            TextButton(
              onPressed: () {
                // 1. 확인 다이어로그 한번 더 보여주기
                Get.defaultDialog(
                  title: "정말 수락하시겠습니까?",
                  content: const Text("바로 채팅창이 개설됩니다."),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();     // 수락 확인창 닫기 -> 요청 창으로 돌아감.
                          }, 
                          child: const Text("취소"),
                        ),
                        TextButton(
                          onPressed: () {
                            // 1. firebase에 채팅방 열기 (chatRooms에 add)

                            // 2. 채팅방으로 이동할지 물어보기 (채팅방으로 이동)
                            askToMoveChatRoom();
                          }, 
                          child: const Text("확인"),
                        ),
                      ],
                    )
                  ]
                );
                // 2. firebase - requestChat_acceptState 필드 업데이트
                _updateRequest(requestCollection.reference, 'accept');
                // 3. from user에게 수정된 필드 내용으로 다이어로그 보내기
                responseToRequest('accept');
                // 4. 현재의 다이어로그 닫기
                Get.back(); 
              }, 
              child: const Text("수락하기"),
            ),
            // 요청 거절
            TextButton(
              onPressed: () {
                // 1. firebase - requestChat_acceptState 필드 업데이트
                _updateRequest(requestCollection.reference, 'reject');
                // 2. from user에게 수정된 필드 내용으로 다이어로그 보내기
                responseToRequest('reject');
                // 3. 현재 다이어로그 닫기
                Get.back();
              }, 
              child: const Text("거절하기"),
            ),
            // 수락 여부 보류
            TextButton(
              onPressed: () {
                // 1. firebase - requestChat_acceptState 필드 업데이트
                _updateRequest(requestCollection.reference, 'reject');
                // 2. from user에게 수정된 필드 내용으로 다이어로그 보내기
                responseToRequest('hold');
                // 3. 현재 다이어로그 닫기
                Get.back();
              }, 
              child: const Text("보류하기"),
            ),
          ],
        )
      ],
    );
  }

  void askToMoveChatRoom() {
    Get.defaultDialog(
      title: "채팅방 이동",
      content: const Text("지금 채팅방으로 이동하시겠습니까?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
                Get.back();
              }, 
              child: const Text("아니오")
            ),
            TextButton(
              onPressed: () {
                // 채팅방으로 이동
                // Get.to();
              }, 
              child: const Text("네")
            )
          ],
        )
      ]
    );
  }

  // firebase 필드 업데이트
  Future<void> _updateRequest(DocumentReference chatReq, String state) async {
    await chatReq.update({'acceptState' : state});
  }

  // 요청받은 사람의 응답을 요청한 사람에게 보여주는 다이어로그
  // from user에게 수정된 필드 내용으로 다이어로그 보내기
  void responseToRequest(String state) {
    FirebaseFirestore.instance.collection('requestChats')
    .where('from', isEqualTo: userData[0]['uid'])
    .where('acceptState', whereIn: ['accept', 'reject', 'hold'])
    .snapshots()
    .listen((snapshot) { 
      for (final doc in snapshot.docs) {
        if (doc['acceptState'] != 'wait') {
          _showResponseDialog(doc, loginData[0]['uid']);    // 누구로 부터 요청이 왔다 보여주기
          // _showResponseDialog(doc);     
        }
      }
    });

  }

  // 요청 받는 사람이 보는 다이어로그 선언하는 함수
  void _showResponseDialog(DocumentSnapshot responseDoc, String toUser) {
    final state = responseDoc['acceptState'];
    
    state == 'accept'
      ? Get.defaultDialog(          // 요청 결과가 수락일 때
          title: "채팅 요청 결과",
          content: Text(
            "$toUser 님에게 요청한 채팅 요청이 수락되었습니다."
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();     // 채팅요청 결과 다이어로그 창 닫기
                  }, 
                  child: const Text("확인")
                ),
                TextButton(
                  onPressed: () {
                    // 채팅방으로 이동
                    // Get.to(채팅방 페이지)
                  }, 
                  child: const Text("채팅방으로 이동하기")
                ),
              ],
            )
          ]
        )
      : state == 'reject'         // 요청 결과가 거절일 때
        ? Get.defaultDialog(
            title: "채팅 요청 결과",
            content: Text(
              "$toUser 님에게 요청한 채팅 요청이 거부되었습니다."
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  }, 
                  child: const Text("확인"),
                ),
              )              
            ]
          )
        : Get.defaultDialog(      // 요청 결과가 보류일 때
            title: "채팅 요청 결과",
            content: Text(
              "$toUser 님에게 요청한 채팅 요청이 보류되었습니다. \n"
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  }, 
                  child: const Text("확인"),
                ),
              )
            ]
        );      
  }

}