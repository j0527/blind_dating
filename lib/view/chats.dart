import 'package:blind_dating/model/chat_messages.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  //// property
  // 채팅방 목록에서 넘겨받은 arguments: [chatRoomId, chatRoomName]
  var value = Get.arguments ?? '__';    
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());
  // 사용자 로그인 정보 받아둘 리스트
  late List loginData = [];   
  // 사용자와 메시지 전송자 일치 여부
  late bool isSender;

  final FirebaseFirestore chatRoomsRef = FirebaseFirestore.instance;
  // final chatMessages = chatRoomsRef;
  
  @override
  Widget build(BuildContext context) {
    // print("chatRoomId : ${value[0]}, chatRoomName : ${value[1]} - 지니 확인용");
    print("chatRoomId : ${value[0]}, chatRoomName : ${value[1]} - 지니 확인용 (넘긴 후)");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${value[1]}'
        ),
      ),
      body: FutureBuilder(
        future: userDataController.getLoginData(),
        // 에러 처리 로직 추가 가능
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              loginData = snapshot.data!; // 로그인된 유저의 데이터
              // 데이터가 있다면 여기 화면이 그려짐 (원치 않을경우 이부분 없애고 그냥 전역변수에 저장시키는 용도로 써도됨)
              // return Text("User ID: ${loginData[0]['uid']}");
              // return loginData;
              // print("loginData : ${loginData}");
              // -----
              print(value[1]);
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .doc(value[0])
                  .collection('chats')
                  // .where('chatRoomId', isEqualTo: '${value[0]}')
                  .orderBy('chatedAt', descending: false)
                  .snapshots(), 
                builder: (context, snapshot) {
                  // print('chatRoomId는 바로! ${value[0]} 이다!!');
                  // print("userData: ${userData[0]['unickname']}");
                  // print("User Id: ${loginData[0]['uid']} 이거 되는거 맞냐");
                  if (snapshot.hasError) {
                    print('오류 발생: ${snapshot.error.toString()}');
                    return Center(child: Text('오류 발생: ${snapshot.error.toString()}'),);
                  }
                  if(!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  } 
                  final chats = snapshot.data!.docs;
                  // print(documents);
                  // return ListView.builder(
                  //   itemCount: chats.length,
                  //   itemBuilder: (context, index) {
                  //     final chating = chats[index];
                  //     final content = chating['content'];
                  //     final sender = chating['sender'];
                  //     final chatedAt = chating['chatedAt'].toDate();

                  //     // return ListTile(
                  //     //   title: Text(content),
                  //     // );

                  //     return BubbleSpecialThree(
                  //       text: content,
                  //       color: Colors.blue[200],
                  //     );
                  //   },
                  // );
                  
                  return Column(
                    // mainAxisAlignment: ,
                    children: chats.map((e) => _buildItemWidget(e)).toList()
                  );

                  // return build(context, index) {
                  //   final chating = chats[index];
                  //   final content = chating['content'];
                  //   final sender = chating['sender'];
                  //   final chatedAt = chating['chatedAt'].toDate();
                  //   return Column(
                  //     children: [
                  //       // ProfileButton
                  //       BubbleSpecialThree(
                  //         text: content
                  //       )
                  //     ],
                  //   );
                  // }
                }
              );
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
      ),      
    );
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final content = doc['content'];
    final sender = doc['sender'];

    return loginData[0]['uid'] == sender 
    ? Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BubbleSpecialThree(
          text: content,
          color: Colors.blue,
          isSender: true,
        ),
      ],
    )
    : Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/퍼그.png"
          ),
        ),
        BubbleSpecialThree(
          text: content,
          color: Colors.grey,
          isSender: false,
        ),
      ],
    ); 
    // isSender = (chats.sender == loginData[0]['uid']);
    // return Dismissible(
    //   direction: DismissDirection.endToStart,
    //   background: Container(
    //     color: Colors.red,
    //     alignment: Alignment.centerRight,
    //     child: const Icon(Icons.delete_forever),
    //   ),
    //   key: ValueKey(doc), 
    //   onDismissed: (direction) {
    //     // FirebaseFirestore.instance
    //     // .collection('message')
    //     // .doc(doc.id)
    //     // .delete();
    //   },
    //   child: Column(
    //     crossAxisAlignment: 
    //       isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           chats.content,
    //           style: TextStyle(
    //             fontSize: 15
    //           ),
    //         )
    //       ],
    //   ),
      
    // );


  }

  // 채팅말풍선 꾸미기
  // Widget chatings(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment
  //       chats.sender == loginData[0]['uid'] ? MainAxisAlignment.end : MainAxisAlignment,
  //   )
  // }

}
