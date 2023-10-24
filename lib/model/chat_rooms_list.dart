class ChatRoomsList{
  String contacter;     // 처음 채팅 건 사람 (방 개설자)
  String receiver;      // 채팅 당한 사람

  ChatRoomsList(
    {
      required this.contacter,
      required this.receiver
    }
  );
}
