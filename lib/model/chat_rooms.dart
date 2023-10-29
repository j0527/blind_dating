// import 'package:blind_dating/model/chatings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatRooms{
//   // String chatRoomId;    // 각 채팅방 아이디 (chatRooms 컬렉션 documentID - contacterWITHaccepter)
//   String contacter;     // 처음 채팅 건 사람 (방 개설자)
//   String accepter;      // 채팅 수락한 사람
//   Timestamp createdAt;
//   List<Chatings> chats;

//   ChatRooms(
//     {
//       // required this.chatRoomId,
//       required this.contacter,
//       required this.accepter,
//       required this.createdAt,
//       required this.chats
//     }
//   );

//   // JSON 형태로 불러오고 저장하기
//   factory ChatRooms.fromJson(Map<dynamic, dynamic> json) {
//     return ChatRooms(
//       // chatRoomId: json['chatRoomId'],
//       contacter: json['contacter'], 
//       accepter: json['accepter'], 
//       createdAt: json['createdAt'],
//       chats: json['chats']
//         .map((chats) => Chatings.fromJson(chats))
//         .toList()
//       );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'contacter': contacter,
//       'accepter': accepter,
//       'createdAt': createdAt,
//       'chats': chats.map((chats) => chats.toJson()).toList()
//     };
//   }

//   factory ChatRooms.fromDocumentSnapshot(DocumentSnapshot snapshot) { 
//     // DocumentSnapshot data : firestore get() 수행시 오는 데이터 형식
//     final List<Chatings> chatings = [];
//     final chatSnapshot = List<Map>.from(snapshot['chats'] as List);
//     for (var e in chatSnapshot) {
//       chatings.add(Chatings.fromJson(e as Map<String, dynamic>));
//     }
//     return ChatRooms(
//       // chatRoomId: snapshot.id,
//       contacter: snapshot['contacter'], 
//       accepter: snapshot['accepter'], 
//       createdAt: snapshot['createdAt'],
//       chats: chatings);
//   }

//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'contacter': contacter,
//   //     'accepter': accepter,
//   //     'chats': chats.map((chats) => chats.toMap()).toList(),
//   //   };
//   // }

//   // factory ChatRooms.fromMap(Map<String, dynamic> map) {
//   //   final List<dynamic> messageList = map['chats'];
//   //   final List<Chats> messages = messageList
//   //     .map((messageMap) => Chats.fromMap(messageMap))
//   //     .toList();
//   //   return ChatRooms(
//   //     contacter: map['contacter'], 
//   //     accepter: map['accepter'], 
//   //     chats: messages,
//   //   );
//   // }

// }