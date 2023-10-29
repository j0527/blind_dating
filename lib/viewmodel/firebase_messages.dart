// firebase messaging과 관련된 모든 클래스

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessages {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user (will prompt user) - 사용자에게 권한 요청 (알림 허용 메시지)
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token for this device - 현재 기기에 대한 FCM 토큰 가져오기
    final fcmToken = await _firebaseMessaging.getToken();

    // print the token (normally send this to the server) - 개개의 디바이스 별 토큰 출력 (보통 서버에 전송)
    print("Token :$fcmToken");
  }

  // function to handle received messages

  // function to initialize foreground and background settings


}