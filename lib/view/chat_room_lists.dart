import 'package:blind_dating/model/chat_messages.dart';
import 'package:blind_dating/model/chat_rooms.dart';
import 'package:blind_dating/model/chat_rooms_list.dart';
import 'package:blind_dating/view/chats.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatRoomLists extends StatefulWidget {
  const ChatRoomLists({super.key});

  @override
  State<ChatRoomLists> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatRoomLists> {
  //// property
  late String chatRoomId;
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());
  // 사용자 로그인 정보 받아둘 리스트
  late List loginData = [];     // 현재 사용자
  late List userData = [];      // 상대 사용자
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([userDataController.getLoginData(), userDataController.getUserData()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              loginData = snapshot.data![0];
              userData = snapshot.data![1];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('chatRooms')
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('오류 발생: ${snapshot.error.toString()}');
                    return Center(child: Text('오류 발생: ${snapshot.error.toString()}'),);
                  }
                  if(!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  final chatRoomsDocs = snapshot.data!.docs;
                  print(chatRoomsDocs);
                  // 메시지 컬렉션 받아와서 마지막 메시지 보여주기
                  // chatRoomId = snapshot.data!.docs;
                  // return StreamBuilder<QuerySnapshot>(
                  //   stream: stream, 
                  //   builder: builder,
                  // );
                  // print("User 닉넴: ${loginData[0]['unickname']} _ 지니 확인용!");
                  return ListView.builder(
                    itemCount: chatRoomsDocs.length,
                    itemBuilder: (context, index) {
                      final chatRoomId = chatRoomsDocs[index];
                      final contacter = chatRoomId['contacter'];
                      final accepter = chatRoomId['accepter'];
                      final createdAt = chatRoomId['createdAt'];
                      final chatRoomName = (loginData[0]['unickname'] == contacter ? accepter : contacter); // 상대방 닉네임
                      final chats = FirebaseFirestore.instance.collection('chatRooms').doc().collection('chats');
                      
                      return GestureDetector(
                        onTap: () {
                          // print("chatRoomName : $chatRoomName - 지니 확인용 (넘기기 전)");
                          Get.to(const Chats(), arguments: [chatRoomId.id, chatRoomName]);
                        },
                        child: Visibility(
                          visible: (loginData[0]['unickname'] == accepter) || (loginData[0]['unickname'] == contacter),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                'images/퍼그.png'
                                // loginData[0]['ufaceimg1'],
                              ),
                              radius: 50,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  chatRoomName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                                    child: Text(
                                      // 하루 지나면 어제, 어제 지나면 월일, 한 해 지나면 년월일 보여주도록 삼항연산자 적기
                                      '${createdAt.toDate().year}년 ${createdAt.toDate().month}월 ${createdAt.toDate().day}일',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13
                                      ),
                                    textAlign: TextAlign.right,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Text(
                              "마지막 채팅 메시지",
                              style: TextStyle(
                                fontSize: 17
                              ),
                            ),
                          ),
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
      )
    );
  }   // Widget build

// Widget _buildItemWidget(DocumentSnapshot doc) {
//   final chatRoom = doc.data() as Map<String, dynamic>;
//   final chatRoomId = doc.id;
//   final contacter = chatRoom['contacter'];
//   final accepter = chatRoom['accepter'];
//   final createdAt = chatRoom['createdAt'];
//   final chatMessage = FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).collection('chats');

//   //// model 파일에 작성한 내용 사용시
//   // final chatRoomLists = ChatRooms(
//   //   contacter: doc['contacter'], 
//   //   accepter: doc['accepter'], 
//   //   createdAt: doc['createdAt'], 
//   //   chats: doc['chats']
//   // );
//   return Dismissible(
//     // direction: DismissDirection.endToStart,
//     // background: Container(
//     //   color: Colors.red,
//     //   alignment: Alignment.centerRight,
//     //   child: const Text("채팅방 나가기"),
//     // ),
//     key: ValueKey(doc),
//     onDismissed: (direction) {
//         // FirebaseFirestore.instance
//         // .collection('students')
//         // .doc(doc.id)
//         // .delete();
//     },     // 채팅방 나가기 (삭제)
//     child: GestureDetector(
//       onTap: () async{
//         // print(doc.id);
//         // contacter와 accepter중 사용자 id와 다른 사람 id 넘겨줌 (다음 페이지 앱바 타이틀)
//         // await Get.to(const Chats(), arguments: [doc.id, chatRoomLists.contacter]);    
//         await Get.to(const Chats(), arguments: doc.id);    
//       },
//       // child: Padding(
//       //   padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
//       //     child: Visibility(
//       //       visible: (loginData[0]['uid'] == accepter) || (loginData[0]['uid'] == contacter),
//       //         child: ListTile(
                
//       //           title: Row(
//       //             children: [
//       //               Text(
//       //                 // loginData[0]['uid'],    // 로그인한 사람이랑 다른 아이디(의 닉네임) 보여주기
//       //                 contacter,
//       //                 style: const TextStyle(
//       //                   fontWeight: FontWeight.bold,
//       //                   fontSize: 20
//       //                 ),
//       //               ),
//       //               Expanded(
//       //                 child: Padding(
//       //                   padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
//       //                   child: Text(
//       //                     // 하루 지나면 어제, 어제 지나면 월일, 한 해 지나면 년월일 보여주도록 삼항연산자 적기
//       //                     '${createdAt.toDate().year}년 ${createdAt.toDate().month}월 ${createdAt.toDate().day}일',
//       //                     style: const TextStyle(
//       //                       color: Colors.grey,
//       //                       fontSize: 13
//       //                     ),
//       //                   textAlign: TextAlign.right,
//       //                   ),
//       //                 ),
//       //               )
//       //             ],
//       //           ),
//       //           subtitle: Text(
//       //             "마지막 채팅 메시지",
//       //             style: TextStyle(
//       //               fontSize: 17
//       //             ),
//       //           ),
//       //         ),
//       //       )
//       //     ),
//         ),
//     );
    
  // }

  // ------ functions -----
  // Future<ChatRooms> getChatMessages(String chatRoomId) async{
  //   final chatMessages = await FirebaseFirestore.instance
  //     .collection('chatMessages')
  //     .snapshots();
  //   // final chatMessages = <ChatMessages>[];

  //   final chats = ChatMessages(
  //     content: content, 
  //     sender: sender, 
  //     sendingTime: sendingTime,
  //   );
  //   for (var messageDoc in chatMessagesQuery.docs) {
  //     final messageData = messageDoc.data();
  //     final chatMessage = ChatMessages.fromJson(messageData);
  //     chatMessage.add(chatMessage);
  //   }

    // return chatMessages;
  // }




}