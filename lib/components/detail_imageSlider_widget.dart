// ignore_for_file: file_names

import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/viewmodel/indicatorCurrent_crtl.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImageSliderWidget extends StatelessWidget {
  DetailImageSliderWidget(
      {super.key,
      required this.controller,
      required this.userInfoList,
      required this.detailCurrent});

  final CarouselController controller; // CarouselController 인스턴스
  final List<SliderlItems> userInfoList; // 슬라이더에 담길 것들 가지고있는 리스트
  final RxInt detailCurrent; // 바뀌는 current를 알기위해 RxInt로 선언

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // 자식 위젯을 세로 중앙에 배치
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 각각의 위젯에 정보 넣어주기
        detailImageSliderWidget(
            controller: controller,
            userInfoList: userInfoList,
            detailCurrent: detailCurrent),
        DetailCarouselIndicator(
            controller: controller,
            userInfoList: userInfoList,
            detailCurrent: detailCurrent),
      ],
    );
  }
}

// 디테일창 이미지 슬라이더 위젯
// ignore: camel_case_types
class detailImageSliderWidget extends StatelessWidget {
  final CarouselController controller;
  final List<SliderlItems> userInfoList;
  final RxInt detailCurrent;
  // final List items = SliderlItems as List;

  detailImageSliderWidget({
    super.key,
    required this.controller,
    required this.userInfoList,
    required this.detailCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    final List<SliderlItems> receivedItems = data['items'];
    final RxInt Index = data['index']; // RxInt로 받음

    // final RxInt detailCurrent;
    // RxInt를 int로 변환
    final int intIndex = Index.value;
    final SliderlItems currentItem =
        receivedItems[intIndex]; // 유저의 정보를 index로 구분

    final String userFaceImagePath1 = currentItem.userFaceImagePath1;
    final String userFaceImagePath2 = currentItem.userFaceImagePath2;
    final String userHobbyImagePath1 = currentItem.userHobbyImagePath1;
    final String userHobbyImagePath2 = currentItem.userHobbyImagePath2;
    final int loginGrant = currentItem.loginGrant;
    final String userSmoke = currentItem.userSmoke;
    final String userName = currentItem.userName;
    final String userAge = currentItem.userAge;
    final String userAddress = currentItem.userAddress;
    final String userDistance = currentItem.userDistance;
    final String userMBTI = currentItem.userMBTI;
    final String userBreed = currentItem.userBreed;

    final List<String> images = [];

// userFaceImagePath1는 항상 추가
    images.add(userFaceImagePath1);
// userFaceImagePath2 조건에 따라 추가
    if (loginGrant == 1 && userFaceImagePath2 != null) {
      images.add(userFaceImagePath2);
    }
// userHobbyImagePath1는 항상 추가
    images.add(userHobbyImagePath1);
// userHobbyImagePath2는 항상 추가
    images.add(userHobbyImagePath2);
    return CarouselSlider(
      items: images.map(
        (imageUrl) {
          print("imageUrl: $images");
          return Stack(
            children: [
              SizedBox(
                width: 400,
                height: 600,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1.0,
        // autoPlay: true,
        // autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          detailCurrent.value = index;
        },
      ),
    );
  }
}

// indicator를 담당하는 위젯
class DetailCarouselIndicator extends StatelessWidget {
  final CarouselController controller;
  final List<SliderlItems> userInfoList;
  final RxInt detailCurrent;

  // indicator에 필요한 정보들
  DetailCarouselIndicator({
    Key? key,
    required this.controller,
    required this.userInfoList,
    required this.detailCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    final List<SliderlItems> receivedItems = data['items'];
    final RxInt Index = data['index']; // RxInt로 받음

    // final RxInt detailCurrent;
    // RxInt를 int로 변환
    final int intIndex = Index.value;
    final SliderlItems currentItem =
        receivedItems[intIndex]; // 유저의 정보를 index로 구분

    final String userFaceImagePath1 = currentItem.userFaceImagePath1;
    final String userFaceImagePath2 = currentItem.userFaceImagePath2;
    final String userHobbyImagePath1 = currentItem.userHobbyImagePath1;
    final String userHobbyImagePath2 = currentItem.userHobbyImagePath2;
    final int loginGrant = currentItem.loginGrant;

    final List<String> images = [];

// userFaceImagePath1는 항상 추가
    images.add(userFaceImagePath1);
// userFaceImagePath2 조건에 따라 추가
    if (loginGrant == 1 && userFaceImagePath2 != null) {
      images.add(userFaceImagePath2);
    }
// userHobbyImagePath1는 항상 추가
    images.add(userHobbyImagePath1);
// userHobbyImagePath2는 항상 추가
    images.add(userHobbyImagePath2);

    return GetBuilder<IndicatorCurrent>(
      builder: (indicatorCurrent) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              // entry는 슬라이더의 인덱스에 담긴 모든걸 알고있는 Map항목임
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(entry.key); // 이미지 슬라이더를 해당 페이지로 이동
                  indicatorCurrent.setDetailCurrent(
                      entry.key); // IndicatorCurrent 컨트롤러를 통해 페이지 변경
                },
                // indicator의 속성들을 정의하는 부분, Obx는 index마다 색이 바뀌기 때문에 이걸 옵져버로 알아야하기 때문에 감싸져있음
                child: Obx(() {
                  return Container(
                    width: 20,
                    height: 10,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal:
                            4.0), // 상하(vertical)로는 8.0, 좌우(horizontal)로는 4.0의 여백주기
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // 동그라미 indicator생성
                      color: Colors.black.withOpacity(
                          detailCurrent.value == entry.key
                              ? 0.9
                              : 0.4), // 투명도를 조절하기 선택되면 더 어두운색 되게해줌
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
