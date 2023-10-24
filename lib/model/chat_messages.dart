import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages{
  String content;         // 메시지 내용
  String sender;          // 메시지 작성자
  Timestamp sendingTime;     // 메시지 보낸 시각

  ChatMessages(
    {
      required this.content,
      required this.sender,
      required this.sendingTime 
    }
  );
  //// JSON 형태로 받아오고 저장
  // factory ChatMessages.fromJson(Map<String, dynamic> json) {
  //   return ChatMessages(
  //     content: json['content'],
  //     sender: json['sender'],
  //     sendingTime: json['sending_time'].toDate(),
  //   );
  // }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'content': content,
  //     'sender': sender,
  //     'sending_time': Timestamp.now()
  //   };
  // }

  //// Map 형태로 받아오고 저장
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'sender': sender,
      'sendingTime': sendingTime,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      content: map['content'], 
      sender: map['sender'], 
      sendingTime: map['sendingTime'],
    );
  }

  factory ChatMessages.fromInput(String content, String sender) {
    return ChatMessages(
      content: content, 
      sender: sender, 
      sendingTime: Timestamp.now(),
    );
  }

}