import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainPageDetail extends StatelessWidget {

  const MainPageDetail({super.key});

  @override
  Widget build(BuildContext context) {

    // userimagePath: 'images/불테리어.png',
    // userName: '박명수',
    // userAge: '10세',
    // userLocation: '내 코앞',
    // userDistance: reciveUserDistance,
    // userMBTI: 'LOVE'),

     // Get.arguments를 통해 데이터 맵을 가져옵니다.
    final Map<String, dynamic> data = Get.arguments;

    // 아이템과 인덱스를 추출합니다.
    final List<SliderlItems> receivedItems = data['items'];
    final RxInt index = data['index']; // RxInt로 받음

    // RxInt를 int로 변환
    final int intIndex = index.value;

    // 이제 receivedItems와 intIndex를 사용할 수 있습니다.
    // 현재 아이템에 대한 정보를 추출합니다.
    final SliderlItems currentItem = receivedItems[intIndex];
    final String userImagePath = currentItem.userimagePath;
    final String userName = currentItem.userName;
    final String userAge = currentItem.userAge;


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Image.network(userImagePath, fit: BoxFit.fill)
              ),
            Row(
              children: [
                Text(userName),
                Text(userAge),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // 채팅 연결, 결제 관련해서 다이어로그 띄워주기도 해야함
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(80, 40), // 버튼 사이즈 조절해서 통일성주기
                    shape: RoundedRectangleBorder(    // 버튼 모양 다듬기
                      borderRadius: BorderRadius.circular(6),
                    ),
                ), 
                child: const Text('이 강아지와 진솔한 대화하기 ❤️',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
