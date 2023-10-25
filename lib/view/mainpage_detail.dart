import 'package:blind_dating/components/detail_imageSlider_widget.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageDetail extends StatelessWidget {
  MainPageDetail({super.key});

  // class 아래 BuildContext 위에 유저 데이터를 관리하는 컨트롤러 인스턴스 선언
  final LoadUserData userDataController = Get.put(LoadUserData());
  @override
  Widget build(BuildContext context) {
    // Get.arguments를 통해 데이터 맵을 가져오기
    final Map<String, dynamic> data = Get.arguments;

    // 아이템과 인덱스 뽑아서 저장
    final List<SliderlItems> receivedItems = data['items'];
    final RxInt index = data['index']; // RxInt로 받음

    // RxInt를 int로 변환
    final int intIndex = index.value;

    // receivedItems와 intIndex를 사용 가능
    // 현재 아이템에 대한 정보 저장
    final SliderlItems currentItem = receivedItems[intIndex];
    final String userImagePath = currentItem.userimagePath;
    final String userName = currentItem.userName;
    final String userAge = currentItem.userAge;


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FutureBuilder(
            //   future: userDataController.getLoginData(),
            //   // 에러 처리 로직 추가 가능
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasData) {
            //         List loginData = snapshot.data!; // 로그인된 유저의 데이터
            //         // 데이터가 있다면 여기 화면이 그려짐 (원치 않을경우 이부분 없애고 그냥 전역변수에 저장시키는 용도로 써도됨)
            //         return Column(
            //           children: [
            //             Text("User ID: ${loginData[0]['uid']}"),
            //             // 여기서 불러오고 싶은거 불러오면 됨 loginData[0]['unickname'] 하면 유저 닉네임 불러와짐
            //           ],
            //         );
            //         // -----
            //       } else {
            //         return const Text("데이터 없음");
            //       }
            //     } else if (snapshot.connectionState ==
            //         ConnectionState.waiting) {
            //       return const CircularProgressIndicator();
            //     } else {
            //       return const Text("데이터 로딩 중 오류 발생");
            //     }
            //   },
            // ),
            detailImageSliderWidget(
                userImagePath: userImagePath,
                userName: userName,
                userAge: userAge),
            // Text("${loadUser()}"),
            // Text("${userData}"),
          ],
        ),
      ),
    );
  }
}// --- Functions ---

