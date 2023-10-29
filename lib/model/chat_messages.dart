// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatMessages{   // collection 이름은 message임
//   String chatRoomId;
//   String content;         // 메시지 내용
//   String sender;          // 메시지 작성자
//   Timestamp createdAt;     // 메시지 보낸 시각

//   ChatMessages(
//     {
//       required this.chatRoomId,
//       required this.content,
//       required this.sender,
//       required this.createdAt 
//     }
//   );
//   // JSON 형태로 받아오고 저장
//   factory ChatMessages.fromJson(Map<String, dynamic> json) {
//     return ChatMessages(
//       chatRoomId: json['chatRoomId'],
//       content: json['content'],
//       sender: json['sender'],
//       createdAt: json['created_at'],
//     );
//   }
  
//   Map<String, dynamic> toJson() {
//     return {
//       'chatRoomId': chatRoomId,
//       'content': content,
//       'sender': sender,
//       'created_at': Timestamp.now()
//     };
//   }

//   //// Map 형태로 받아오고 저장
//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'content': content,
//   //     'sender': sender,
//   //     'sendingTime': sendingTime,
//   //   };
//   // }

//   // factory ChatMessages.fromMap(Map<String, dynamic> map) {
//   //   return ChatMessages(
//   //     content: map['content'], 
//   //     sender: map['sender'], 
//   //     sendingTime: map['sendingTime'],
//   //   );
//   // }

//   // factory ChatMessages.fromInput(String content, String sender) {
//   //   return ChatMessages(
//   //     content: content, 
//   //     sender: sender, 
//   //     sendingTime: Timestamp.now(),
//   //   );
//   // }

// }