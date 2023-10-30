// firebase messaging과 관련된 모든 클래스

import 'package:blind_dating/view/alarm.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

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

    // initialize further settings for push notification
    initPushNotigications();
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? messages) {
    // if message is null, do nothing
    if (messages == null) return;

    // navigate to new screen when message is received and user taps notifications
    else {
      // 알림내역 창으로 보내기
      // Get.to(const AlarmPage());
      Get.toNamed('/alarm', arguments: messages);
    }
  }

  // function to initialize foreground and background settings
  Future initPushNotigications() async{
    // handle notification if the app was terminated and now opend
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for then a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }


}