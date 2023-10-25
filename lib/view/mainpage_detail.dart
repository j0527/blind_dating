import 'package:blind_dating/components/detail_imageSlider_widget.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageDetail extends StatelessWidget {

  const MainPageDetail({super.key});

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
        child: detailImageSliderWidget(userImagePath: userImagePath, userName: userName, userAge: userAge),
      ),
    );
  }
}

