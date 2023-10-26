// ignore_for_file: avoid_print

import 'package:blind_dating/components/main_imageSlider_widget.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/util/theme.dart';
import 'package:blind_dating/view/mainpage_detail.dart';
import 'package:blind_dating/viewmodel/loadUserData_ctrl.dart';
import 'package:blind_dating/viewmodel/location_ctrl.dart';
import 'package:blind_dating/viewmodel/indicatorCurrent_crtl.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
// 이미지 슬라이더를 제어하기 위한 기본적인 컨트롤러
  final CarouselController sliderController = CarouselController();
  // 현재 이미지 슬라이더의 상태를 관리하는 GetX 컨트롤러
  final IndicatorCurrent indicatorCurrent = Get.put(IndicatorCurrent());
  // 위치와 관련된 getXmodel
  final GetXLocation locationController = Get.put(GetXLocation());
  // 유저와 관련된 getX
  final LoadUserData userDataController = Get.put(LoadUserData());
  // 유저 거리를 담아놓을 변수
  String reciveUserDistance = "";
  // 유저 정보 JSON으로 받아올 리스트
  List userData = [];
  // 로그인된 유저 받아올 리스트
  List loginData = [];
  // 유저의 계산된 나이를 담을 리스트
  List userAge = [];
  // 유저 id
  String uid = "";
  // 유저 password
  String upw = "";
  // 권한에 따라 다른 이미지를 담기위한 변수
  String userImagepath1 = "";
  String userImagepath2 = "";

  // 유저 취미사진 리스트
  // List userHoppy

  /*
  saveSharedPreferences로 저장된 로그인 정보 받기
  Future<String> initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? " ";
    upw = prefs.getString('upw') ?? " ";
    print("send uid: $uid");
    print("send upw: $upw");
    return uid;
  }
  */

  @override
  Widget build(BuildContext context) {
    /*
    유저와의 거리가 계산되는 순서 및 방식
    1. 앱 실행시 stateless라서 FutureBuilder를 써서 _initLocation() 함수를 쓰고 거기서 위치 권한 사용동의 창을 띄움
    2. 동의시에는 내 위치를 geolocator 패키지의 position이라는 변수에 저장됨 ex): Latitude: 37.49474, Longitude: 127.030034 이런식이라서 position.Latitude 하면 사용됨
    3. 그 다음 FutureBuilder에서는 _getPosition()이 내 위치를 가져오면 getXmodel부분의 myLocation변수에 position(내 위치)을 저장시킴
    4. 저장된 position값으로 calculateDistance()를 불러와서 계산하고 그걸 calcDistance 변수에 저장, (calculateDistance()에는 임의로 지정해놓은 상대방의 위도 경도가 있어서 계산됨)
    5. 거리가 계산되면 FutureBuilder 내부에 calculateDistance()를 인스턴스로 선언해놓은 calcDistance에 상대방과 나의 거리 값을 저장
    6. carouselItems의 userDistance에 거리를 업데이트
    7. imageSlider위젯의 userInfoList부분에 carouselItems를 넣어줘서 화면에 띄워주게됨
    */

    return Scaffold(
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            userDataController.initLocation(), // 내 위치 가져오기
            userDataController.getUserData(), // 추천받을 유저 띄우기
            userDataController.getLoginData() // 로그인된 유저 정보 가져오기
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if (snapshot.hasData && snapshot.data?.length == 2) {
              if (snapshot.hasData) {
                // ================== 조건부 Select ==================
                Position? userPosition = snapshot.data?[0]; // 현재 내 위치
                List? userList = snapshot.data?[1]; // db에서 불러온 유저 정보 리스트
                List? loginData = snapshot.data?[2]; // 로그인된 유저의 데이터

                print("로그인된 유저닉네임: ${loginData![0]['unickname']}");
                print(
                    "로그인된 유저권한: ${loginData[0]['ugender'] == "1" ? "남성" : "여성"}");
                print(
                    "로그인된 유저권한: ${loginData[0]['ugrant'] == "1" ? "구독자" : "무료 사용자"}");
                print("로그인된 유저 채팅카운트: ${loginData[0]['uchatcount']}");

                if (loginData != null) {
                  // 유저에게 결제해서 권한이 있을경우 얼굴 이미지 띄워줌
                  if (loginData[0]['ugrant'] == "1") {
                    userImagepath1 = userList![0]['ufaceimg1'];
                    userImagepath2 = userList[1]['ufaceimg1'];
                  } else {
                    userImagepath1 = userList![0]['udogimg'];
                    userImagepath2 = userList[1]['udogimg'];
                  }
                }
                //
                if (userList != null) {
                  userDataController.userList(
                      userList); // 컨트롤러의 userList 변수에 불러온 snapshot.data?[1] 넘겨주기
                }

                // 이미지와 텍스트 가지는 데이터 리스트
                final List<SliderlItems> carouselItems = [
                  // 첫번째 유저
                  SliderlItems(
                    // userID: userList![0]['uid'],
                    userimagePath: userImagepath1,
                    userName: userList![0]['unickname'],
                    userAge: "${userDataController.ageCalc()[0]}세",
                    userLocation: userList[0]['uaddress'],
                    userDistance: reciveUserDistance,
                    userMBTI: userList[0]['umbti'],
                  ),
                  // 두번째 유저
                  SliderlItems(
                    userimagePath: userImagepath2,
                    userName: userList[1]['unickname'],
                    userAge: "${userDataController.ageCalc()[1]}세",
                    userLocation: userList[1]['uaddress'],
                    userDistance: reciveUserDistance,
                    userMBTI: userList[1]['umbti'],
                  ),
                ];

                // 유저의 위치를 가져와서 거리랑 단위 변환하는 과정
                if (userPosition != null) {
                  List<double> distances =
                      userDataController.calculateDistances(); // 거리 계산하는 인스턴스

                  if (distances.length >= 2) {
                    double distanceWithUser1 = distances[0]; // 첫 번째 사용자와의 거리
                    double distanceWithUser2 = distances[1]; // 두 번째 사용자와의 거리
                    String user1DistanceText =
                        getFormattedDistance(distanceWithUser1);
                    String user2DistanceText =
                        getFormattedDistance(distanceWithUser2);

                    carouselItems[0].userDistance = user1DistanceText;
                    carouselItems[1].userDistance = user2DistanceText;
                  }

                  // 이미지 슬라이더 컬러값 함수
                  // Color genderColors() {
                  //   switch (userList[0]['ugnbder']) {
                  //     case '1':
                  //       switch (userList[1]['ugnbder']) {
                  //         case '1':
                  //           return const Color.fromARGB(255, 25, 107, 95); // 둘 다 1인 경우
                  //         case '0':
                  //           return const Color.fromARGB(255, 25, 107, 95); // 첫 번째 사용자만 1인 경우
                  //         default:
                  //           return Colors.black; // 그 외의 경우
                  //       break;
                  //       }
                  //     case '0':
                  //       switch (userList[1]['ugnbder']) {
                  //         case '1':
                  //           return const Color.fromARGB(255, 25, 107, 95); // 두 번째 사용자만 1인 경우
                  //         case '0':
                  //           return const Color.fromARGB(255, 154, 47, 187); // 둘 다 0인 경우
                  //         default:
                  //           return Colors.black; // 그 외의 경우
                  //       }
                  //       break;
                  //     default:
                  //       return Colors.black; // 그 외의 경우
                  //   }
                  // }

                  Color genderColors() {
                    if (userList[0]['ugnbder'] == '1' &&
                        userList[1]['ugnbder'] == '1') {
                      return Color.fromARGB(255, 25, 107, 95); // 둘 다 1인 경우
                    } else if (userList[0]['ugnbder'] == '0' &&
                        userList[1]['ugnbder'] == '0') {
                      return Color.fromARGB(255, 154, 47, 187); // 둘 다 0인 경우
                    } else if (userList[0]['ugnbder'] == '1' ||
                        userList[1]['ugnbder'] == '1') {
                      return Color.fromARGB(255, 25, 107, 95); // 둘 중 하나만 1인 경우
                    } else {
                      return Colors.black; // 그 외의 경우
                    }
                  }

                  // ================== 조건부 Select ==================

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // const SizedBox(
                        //   height: 50,
                        // ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '오늘의 추천',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              MainPageDetail(),
                              arguments: {
                                'items': carouselItems,
                                'index': indicatorCurrent.current,
                              },
                            );
                            print("carouselItems: $carouselItems");
                          },
                          child: Container(
                            // 여기가 전체 슬라이더 크기를 담당
                            color:
                                genderColors(), //userList[0]['ugnbder'] == '1' ? Color.fromARGB(255, 25, 107, 95) : Color.fromARGB(255, 154, 47, 187),
                            width: MediaQuery.of(context).size.width < 500
                                ? 500
                                : MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height > 800
                                ? 500
                                : MediaQuery.of(context).size.height,
                            child: Stack(
                              children: [
                                GetBuilder<IndicatorCurrent>(
                                  builder: (controller) {
                                    return CarouselSliderWidget(
                                      controller: sliderController,
                                      userInfoList: carouselItems,
                                      current: controller.current,
                                    );
                                  },
                                ),
                                CarouselIndicator(
                                  userInfoList: carouselItems,
                                  current: indicatorCurrent.current,
                                  controller: sliderController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Text(data[1]['unickname']),
                        // Text("${userList[0]['unickname']}"),
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('위치를 가져오는 중에 오류가 발생했습니다: ${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
} // ---- Functions ----

// 거리 단위 함수
String getFormattedDistance(double distance) {
  return '${distance >= 1000.0 ? (distance / 1000.0).toStringAsFixed(2) : distance.toStringAsFixed(2)}${distance >= 1000.0 ? "Km" : "m"}';
}
