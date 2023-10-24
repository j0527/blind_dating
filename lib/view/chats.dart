// import 'package:flutter/material.dart';

// class Chats extends StatelessWidget {
//   const Chats({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//           .collection('ChatRooms')
//           .doc()
//           .collection('chatMessages')
//           .orderBy('sendingTime', descending: true)
//           .snapshots(),
//         builder: (context, snapshot) {
//           if(!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator(),);
//           }
//           final documents = snapshot.data!.docs;
//           print(documents);
//           return ListView(
//             children: documents.map((e) => _buildItemWidget(e)).toList(),
//           );
//         }
//       ),
//     );
//   }
// }