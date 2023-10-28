import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  //// property
  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());
  // 사용자 로그인 정보 받아둘 리스트
  late List loginData = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userDataController.getLoginData(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              loginData = snapshot.data!;
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('오류 발생: ${snapshot.error.toString()}');
                    return Center(child: Text('오류 발생: ${snapshot.error.toString()}'),);
                  }
                  if(!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  final favoritesDocs = snapshot.data!.docs;
                  print(favoritesDocs);
                  // print("User ID: ${loginData[0]['uid']} 이거 되는거 맞냐");
                  // return Column(
                  //   children: favoritesDocs.map((e) => _buildItemWidget(e)).toList()
                  // );
                  return Column(
                    children: [
                      Text("나에게 관심이 있는"),
                      GridView.builder(
                        itemCount: favoritesDocs.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20
                        ), 
                        itemBuilder: (context, index) {
                          final favorites = favoritesDocs[index];
                          final fromUid = favorites['from'];
                          final toUid = favorites['to'];
                          final likeable = favorites['likeable'];
                          return Column(
                            children: [
                              Image.asset(
                                "images/퍼그.png"
                              ),
                              Row(
                                children: [
                                  Text(
                                    // "상대 닉네임"
                                    fromUid
                                  ),
                                  Text(
                                    "상대 거주 지역"
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                      Text("내가 관심이 있는")
                    ]
                  );
                }
              );
            } else {
              return const Text("데이터 없음");
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const Text("데이터 로딩 중 오류 발생");
          }
        }
      )
    );
  }

  // Widget _buildItemWidget(DocumentSnapshot doc) {

  //   return GestureDetector(
  //     onTap: () {
  //       // Get.to(해당 사용자 프로필 상세 페이지)
  //     },
  //     child: Column(
  //       children: [
  //         Text(
  //           "나에게 관심이 있는"
  //         ),
  //         GridView.builder(
  //           gridDelegate: gridDelegate, 
  //           itemBuilder: itemBuilder)
  //         Text(
  //           "내가 관심이 있는"
  //         ),
  //       ],
  //     ),
  //   );
  // }


  // Widget _gridViewWidget() {
  //   return Card(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Image.asset(
  //           // 상대방 프로필 사진
  //           "images/퍼그.png"
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               "상대방 닉네임"
  //             ),
  //             Text(
  //               "상대방 사는 지역"
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
    





}