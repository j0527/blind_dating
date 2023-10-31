import 'package:blind_dating/view/chats.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {

    // get the notification message and display on screen
    // final messages = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    // final messages = Get.arguments as RemoteMessage;

    // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
    final LoadUserData userDataController = Get.put(LoadUserData());
    // 사용자 로그인 정보 받아둘 리스트
    late List loginData = [];     // 현재 사용자
    late List userData = [];      // 상대 사용자

    return Scaffold(
      // body: Column(
      //   children: [
      //     Text(messages.notification!.title.toString()),
      //     Text(messages.notification!.body.toString()),
      //     Text(messages.data.toString()),
      //   ],
      // ),// streambuilder로 리스트 뷰?
      body: FutureBuilder(
        future: Future.wait([userDataController.getLoginData(), userDataController.getUserData()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              loginData = snapshot.data![0];
              userData = snapshot.data![1];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('requestChats')
                  .where('acceptState', isEqualTo: 'wait')
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('오류 발생: ${snapshot.error.toString()}');
                    return Center(child: Text('오류 발생: ${snapshot.error.toString()}'),);
                  }
                  if(!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  final chatReqestDocs = snapshot.data!.docs;
                  print("지니 알람창 확인 :$chatReqestDocs");
                  return ListView.builder(
                    itemCount: chatReqestDocs.length,
                    itemBuilder: (context, index) {
                      // firebase 불러오기
                          final chatRequest = chatReqestDocs[index];
                          final from = chatRequest['from'];
                          final to = chatRequest['to'];
                          final acceptState = chatRequest['acceptState'];
                          final requestedAt = chatRequest['requestedAt'].toDate();

                      return GestureDetector(
                        onTap: () {
                          // print("chatRoomName : $chatRoomName - 지니 확인용 (넘기기 전)");
                          // showDialog(context: context, builder: builder)    // 수락, 보류, 거절 버튼 만들기
                          acceptState == 'accept'  
                            ? Get.to(const Chats()/*, arguments: [chatRoomId.id, chatRoomName]*/) 
                            : print("");    // acceptState == 'hold' ||  acceptState == 'reject' 일때 채팅요청 거절 시키기 (or 안보이게 하기)
                        },
                        child: Visibility(
                          visible: (loginData[0]['uid'] == from) || (loginData[0]['uid'] == to) && (acceptState != 'reject'),
                          child: _listViewTile(loginData, userData, chatRequest)
                        ),
                      );
                    },
                  );
                }
              );
            } else {
              return const Text("데이터 없음");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("데이터 로딩 중 오류 발생");
          }
        }
      ),
    );
  }

  Widget _listViewTile(List loginData, List userData, DocumentSnapshot doc) {
    final chatRequest = doc.data() as Map<String, dynamic>;
    final from = chatRequest['from'];
    final to = chatRequest['to'];
    final acceptState = chatRequest['acceptState'];
    final requestedAt = chatRequest['requestedAt'].toDate();
    
    // 시간 형식 계산
    DateTime now = DateTime.now();
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
    }
    String requestedTime(DateTime dateTime) {
      int dateTime = requestedAt.hour;
      // DateFormat을 사용하여 12시간 형식(AM/PM)으로 시간 변환
      String requestedTime = dateTime > 12 
        ? '${(dateTime - 12).toString().padLeft(2, '0')}:${requestedAt.minute.toString().padLeft(2, '0')} PM'
        : '${dateTime.toString().padLeft(2, '0')}:${requestedAt.minute.toString().padLeft(2, '0')} ${dateTime < 12 ? 'AM' : 'PM'}';
      // 0 AM을 12 AM으로 표시
      requestedTime = (requestedTime.startsWith('00')) ? '12${requestedTime.substring(2)}' : requestedTime;
      return requestedTime;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          // 'images/퍼그.png'
          userData[0]['ufaceimg1'],
        ),
        radius: 50,
      ),
      title: Row(
        children: [
          Text(
            "${loginData[0]['uid'] == from ? userData[0]['unickname'] : loginData[0]['unickname']} 님께서 \n채팅을 요청하셨습니다.",    // 상대 닉네임으로 바꾸기
            style: const TextStyle(
              fontSize: 20
            ),
          ),
          Text(
            isSameDay(requestedAt, now) ? requestedTime(requestedAt)
            : isSameDay(requestedAt, now.subtract(const Duration(days: 1))) ? "어제"
            : (requestedAt.year != now.year) ? "${requestedAt.year}년 ${requestedAt.month}월 ${requestedAt.day}일" 
            : '${requestedAt.month}월 ${requestedAt.day}일',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13
            ),
          textAlign: TextAlign.right,
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              // 파베 상태 업데이트
            }, 
            child: const Text("거부"),
          ),
          TextButton(
            onPressed: () {
              
            }, 
            child: const Text("보류"),
          ),
          TextButton(
            onPressed: () {
              
            }, 
            child: const Text("수락"),
          ),
        ],
      ),
    );
  }


}