import 'package:blind_dating/model/chat_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRooms{
  // String chatRoomId;    // 각 채팅방 아이디 (P.K - firebase 자동 생성)
  String contacter;     // 처음 채팅 건 사람 (방 개설자)
  String receiver;      // 채팅 당한 사람 
  List<ChatMessages> chatMessages;

  ChatRooms(
    {
      // required this.chatRoomId,
      required this.contacter,
      required this.receiver,
      required this.chatMessages
    }
  );

  //// JSON 형태로 불러오고 저장하기
  // factory ChatRooms.fromJson(Map<dynamic, dynamic> json) {
  //   return ChatRooms(
  //     // chatRoomId: json['chatRoomId'],
  //     contacter: json['contacter'], 
  //     receiver: json['receiver'], 
  //     chatMessages: json['chatMessages']
  //       .map((chatMessages) => ChatMessages.fromJson(chatMessages))
  //       .toList()
  //     );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'contacter': contacter,
  //     'receiver': receiver,
  //     'chatMessages': chatMessages.map((chatMessages) => chatMessages.toJson()).toList()
  //   };
  // }

  // factory ChatRooms.fromDocumentSnapshot(DocumentSnapshot snapshot) { 
  //   // DocumentSnapshot data : firestore get() 수행시 오는 데이터 형식
  //   final List<ChatMessages> chatMessages = [];
  //   final List<Map<String, dynamic>> messageSnapshot = List<Map<String, dynamic>>.from(snapshot['chatMessages'] as List);
  //   for (var e in messageSnapshot) {
  //     chatMessages.add(ChatMessages.fromJson(e));
  //   }
  //   return ChatRooms(
  //     // chatRoomId: snapshot.id,
  //     contacter: snapshot['contacter'], 
  //     receiver: snapshot['receiver'], 
  //     chatMessages: chatMessages);
  // }

  Map<String, dynamic> toMap() {
    return {
      'contacter': contacter,
      'receiver': receiver,
      'chatMessages': chatMessages.map((chatMessages) => chatMessages.toMap()).toList(),
    };
  }

  factory ChatRooms.fromMap(Map<String, dynamic> map) {
    final List<dynamic> messageList = map['chatMessages'];
    final List<ChatMessages> messages = messageList
      .map((messageMap) => ChatMessages.fromMap(messageMap))
      .toList();
    return ChatRooms(
      contacter: map['contacter'], 
      receiver: map['receiver'], 
      chatMessages: messages,
    );
  }

}