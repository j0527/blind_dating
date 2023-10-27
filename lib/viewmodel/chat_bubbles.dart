// import 'package:blind_dating/model/chat_messages.dart';
// import 'package:flutter/material.dart';

// class ChatBubbles extends StatelessWidget {
//   const ChatBubbles({super.key});

//   final List<ChatMessages> chatMessages;
//   final String usereId;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//         reverse: true,
//         itemCount: chatMessages.length,
//         itemBuilder: (context, index) {
//           return ChatBubbles(
//             chatMessages[index], chatMessages[index].sender == userId);
//           )
//         },
//       ),
//     );
//   }
// }