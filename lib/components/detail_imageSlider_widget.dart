// ignore_for_file: file_names

import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/viewmodel/indicatorCurrent_crtl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailImageSliderWidget extends StatelessWidget {
  const DetailImageSliderWidget(
      {super.key,
      required this.controller,
      required this.userInfoList,
      required this.detailCurrent});

  final CarouselController controller; // CarouselController 인스턴스
  final List<SliderlItems> userInfoList; // 슬라이더에 담길 것들 가지고있는 리스트
  final RxInt detailCurrent; // 바뀌는 current를 알기위해 RxInt로 선언

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 자식 위젯을 세로 중앙에 배치
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 각각의 위젯에 정보 넣어주기
          detailImageSliderWidget(
              controller: controller,
              userInfoList: userInfoList,
              detailCurrent: detailCurrent),
          DetailCarouselIndicatorWidget(
              controller: controller,
              userInfoList: userInfoList,
              detailCurrent: detailCurrent),
          const DetailUserInfoWidget(),
        ],
      ),
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

  const detailImageSliderWidget({
    super.key,
    required this.controller,
    required this.userInfoList,
    required this.detailCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    final List<SliderlItems> receivedItems = data['items'];
    // ignore: non_constant_identifier_names
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
    final String userName = currentItem.userName;
    final String userBreed = currentItem.userBreed;

    final String detailInfoName =
        loginGrant == 1 ? "$userName님" : "이 $userBreed";

    final List<String> images = [];

// userFaceImagePath1는 항상 추가
    images.add(userFaceImagePath1);
// userFaceImagePath2 조건에 따라 추가
    if (loginGrant == 1) {
      images.add(userFaceImagePath2);
    }
// userHobbyImagePath1는 항상 추가
    images.add(userHobbyImagePath1);
// userHobbyImagePath2는 항상 추가
    images.add(userHobbyImagePath2);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        //   child: Text(
        //     "$detailInfoName의 은밀한 정보",
        //     style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //   ),
        // ),
        CarouselSlider(
          items: images.map(
            (imageUrl) {
              // print("imageUrl: $images");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width, // 화면 최대 넓이
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      // child: imageUrl,
                    ),
                  ),
                ],
              );
            },
          ).toList(),
          options: CarouselOptions(
            height: 600,
            viewportFraction: 1.0,
            // autoPlay: true,
            // autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              detailCurrent.value = index;
            },
          ),
        ),
      ],
    );
  }
}

// 디테일창 유저 정보 위젯
class DetailUserInfoWidget extends StatelessWidget {
  const DetailUserInfoWidget({super.key});

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

    final int loginGrant = currentItem.loginGrant;
    final String loginUName = currentItem.loginName;
    final String userSmoke = currentItem.userSmoke;
    final String userName = currentItem.userName;
    final String userAge = currentItem.userAge;
    final String userAddress = currentItem.userAddress;
    final String userDistance = currentItem.userDistance;
    final String userMBTI = currentItem.userMBTI;
    final String userBreed = currentItem.userBreed;

    final String detailInfoName = loginGrant == 1 ? "사람" : "강아지";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(userAge),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  // Text(
                  //   userName,
                  //   style: const TextStyle(fontSize: 20),
                  // ),
                  Text("$loginUName님과 마음의 거리 ❤️ $userDistance"),
                ],
              ),
            ),
          ],
        ),
        // 디테일 정보 시작
        Container(
          height: 2.0,
          width: MediaQuery.of(context).size.width, // 화면 최대 넓이
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "지역",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "MBTI",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "흡연여부",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userAddress),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userMBTI),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userSmoke),
                  ],
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 40), // 버튼 사이즈 조절해서 통일성주기
                shape: RoundedRectangleBorder(
                  // 버튼 모양 다듬기
                  borderRadius: BorderRadius.circular(10),
                )),
            child: const Text('대화 걸기',
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            ),
      ],
    );
  }
}

// Widget 

// indicator를 담당하는 위젯
class DetailCarouselIndicatorWidget extends StatelessWidget {
  final CarouselController controller;
  final List<SliderlItems> userInfoList;
  final RxInt detailCurrent;

  // indicator에 필요한 정보들
  const DetailCarouselIndicatorWidget({
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
    if (loginGrant == 1) {
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
