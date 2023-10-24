class ChatMessages{
  String chatRoomId;      // 채팅방 번호 (P.K - 자동 생성)
  String content;         // 메시지 내용
  String sender;          // 메시지 작성자
  String sendingTime;     // 메시지 보낸 시각

  ChatMessages(
    {
      required this.chatRoomId,
      required this.content,
      required this.sender,
      required this.sendingTime 
    }
  );
}