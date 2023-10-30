import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRequest extends GetxController {
  final FirebaseFirestore _requestChatFirestore = FirebaseFirestore.instance;

  final RxBool chatRequested = false.obs;

  @override
  void onInit() {
    super.onInit();
    _requestChatFirestore.collection('requestChats').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // 새로운 요청이 있을 때 showDialog
        chatRequested.value = true;
        showChatRequestDialog();
      }
    });
  }

  void showChatRequestDialog() {
    Get.defaultDialog(
      title: "채팅 요청",
      content: Text(
        "누구누구 님으로부터 채팅 요청이 왔습니다."
      ),
      textConfirm: 'Accept',
      textCancel: 'Reject',
      onConfirm: () {
        // 수락버튼 눌렀을 때
      },
      onCancel: () {
        // 거절 버튼 눌렀을 때
      },
    );
  }


}