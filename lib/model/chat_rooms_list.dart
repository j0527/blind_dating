import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomsList{
  String contacter;     // 처음 채팅 건 사람 (방 개설자)
  String accepter;      // 채팅 수락한 사람
  Timestamp createdAt;

  ChatRoomsList(
    {
      required this.contacter,
      required this.accepter,
      required this.createdAt
    }
  );

  // JSON 형태로 받아오고 저장
  factory ChatRoomsList.fromJson(Map<String, dynamic> json) {
    return ChatRoomsList(
      contacter: json['contacter'],
      accepter: json['accepter'],
      createdAt: json['created_at'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contacter': contacter,
      'accepter': accepter,
      'created_at': Timestamp.now()   // 채팅방이 생성된 (가장 첫 메시지 전송) 시각
    };
  }
}
