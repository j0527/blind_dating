import 'package:blind_dating/model/chat_rooms_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomLists extends StatefulWidget {
  const ChatRoomLists({super.key});

  @override
  State<ChatRoomLists> createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatRoomLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('chatRoomsList')
          // .orderBy(field)
          .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final documents = snapshot.data!.docs;
          print(documents);
          return ListView(
            children: documents.map((e) => _buildItemWidget(e)).toList(),
          );
        }
      ),
    );
  }   // Widget build

Widget _buildItemWidget(DocumentSnapshot doc) {
  final chatRoomLists = ChatRoomsList(
    contacter: doc['contacter'],
    receiver: doc['receiver']
  );
  return Dismissible(
    // direction: DismissDirection.endToStart,
    // background: Container(
    //   color: Colors.red,
    //   alignment: Alignment.centerRight,
    //   child: const Text("채팅방 나가기"),
    // ),
    key: ValueKey(doc),
    onDismissed: (direction) {
        FirebaseFirestore.instance
        .collection('students')
        .doc(doc.id)
        .delete();
      },     // 채팅방 나가기 (삭제)
      child: const Padding(
        padding: EdgeInsets.fromLTRB(3, 0, 3, 3),
        child: Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                'images/퍼그.png'
              ),
              radius: 50,
              
            ),
            title: Row(
              children: [
                Text(
                  "상대 닉네임",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 15, 0),
                    child: Text(
                      "마지막 채팅 시간",
                      style: TextStyle(
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
      )
    );




  }





}