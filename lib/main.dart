import 'package:blind_dating/firebase_options.dart';
import 'package:blind_dating/home.dart';
import 'package:blind_dating/view/test_login.dart';
import 'package:blind_dating/viewmodel/chat_request.dart';
import 'package:blind_dating/viewmodel/firebase_messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(ChatRequest());     // 채팅요청 컨트롤러 (채팅 요청시 다이어로그 뜨도록) GetX에 등록
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final firebaseMessages = FirebaseMessages();
    // firebaseMessages.initNotifications();   // firebase messaging - 알림 수신 허용 요청
    
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestLogin(),
    );
  }
}
