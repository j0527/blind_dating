import 'dart:io';

import 'package:blind_dating/model/%08getX_location_model.dart';
import 'package:blind_dating/components/imageSlider_widget.dart';
import 'package:blind_dating/model/indicatorCurrent_model.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/view/login.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselController sliderController =
        CarouselController(); // 이미지 슬라이더를 제어하기 위한 기본적인 컨트롤러
    final IndicatorCurrent indicatorCurrent =
        Get.put(IndicatorCurrent()); // 현재 이미지 슬라이더의 상태를 관리하는 GetX 컨트롤러
    final GetXLocation locationController =
        Get.put(GetXLocation()); // 위치와 관련된 getXmodel

    String reciveUserDistance = ""; // 유저 거리를 담아놓을 변수

    // 이미지와 텍스트 가지는 더미데이터 리스트
    final List<SliderlItems> carouselItems = [
      SliderlItems(
          userimagePath: 'images/불테리어.png',
          userName: '박명수',
          userAge: '10세',
          userLocation: '내 코앞',
          userDistance: reciveUserDistance,
          userMBTI: 'LOVE'),
      SliderlItems(
          userimagePath: 'images/퍼그.png',
          userName: '크리스티아누 호날두',
          userAge: '27세',
          userLocation: '평양 직할시',
          userDistance: '100km',
          userMBTI: 'ESTJ'),
    ];

    // 유저와의 거리가 계산되는 순서 및 방식
    // 1. 앱 실행시 stateless라서 FutureBuilder를 써서 _initLocation() 함수를 쓰고 거기서 위치 권한 사용동의 창을 띄움
    // 2. 동의시에는 내 위치를 geolocator 패키지의 position이라는 변수에 저장됨 ex): Latitude: 37.49474, Longitude: 127.030034 이런식이라서 position.Latitude 하면 사용됨
    // 3. 그 다음 FutureBuilder에서는 _getPosition()이 내 위치를 가져오면 getXmodel부분의 myLocation변수에 position(내 위치)을 저장시킴
    // 4. 저장된 position값으로 calculateDistance()를 불러와서 계산하고 그걸 calcDistance 변수에 저장, (calculateDistance()에는 임의로 지정해놓은 상대방의 위도 경도가 있어서 계산됨)
    // 5. 거리가 계산되면 FutureBuilder 내부에 calculateDistance()를 인스턴스로 선언해놓은 calcDistance에 상대방과 나의 거리 값을 저장
    // 6. carouselItems의 userDistance에 거리를 업데이트
    // 7. imageSlider위젯의 userInfoList부분에 carouselItems를 넣어줘서 화면에 띄워주게됨

    return Scaffold(
      body: Center(
        child: FutureBuilder<Position?>(
          // Position타입은 Latitude: , Longitude: 이런식으로 되어있음
          future: _initLocation(), // 사용자 위치정보 권한 창을 띄우고 동의시 내 위치를 가져오게 만드는 함수
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                GetXLocation locationController =
                    Get.find(); // 위에서 선언된 Get.put을 find해서 getXmodel을 쓸 수 있게됨
                double calcDistance = locationController.calculateDistance();
                // 3항 연산자로 km로 변환하기 위해서 1000을 넘으면 1000으로 나누고 단위도 km로 바꿈
                reciveUserDistance =
                    '${calcDistance >= 1000.0 ? (calcDistance / 1000.0).toStringAsFixed(2) : calcDistance.toStringAsFixed(2)}${calcDistance >= 1000.0 ? "Km" : "m"}';
                // 여기에서 첫번째 유저의 userDistance를 업데이트
                carouselItems[0].userDistance = reciveUserDistance;

                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '오늘의 추천',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      // constraints: BoxConstraints(
                      //     maxWidth: MediaQuery.of(context).size.width, // 화면의 최대 너비로 설정
                      //     maxHeight: MediaQuery.of(context).size.height, // 화면의 최대 높이로 설정
                      //   ),
                      color: const Color.fromARGB(255, 99, 182, 203),
                      height: 400,
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
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Failed to get location: ${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
} // ---- Functions ----

// 앱 처음 위치 가져오기
Future<Position?> _initLocation() async {
  final permissionGranted = await _determinePermission();
  if (permissionGranted) {
    final position = await _getPosition();
    if (position != null) {
      GetXLocation locationController = Get.find();
      locationController.myLocation.value =
          position; // _getPosition() 함수에서 return받은걸로 위치 정보 업데이트
      // print("position: $position");
      // print("calcDistance: $calcDistance");
    } else {
      // 위치 정보를 가져오지 못한 경우에 대한 처리
      // print('못 가저오면 어쩔건데');
    }
  } else {
    // 위치 권한이 거부된 경우에 대한 처리
    // _showPermissionDeniedDialog();
  }
  return await _getPosition();
}

// 위치 권한 거부 시 다이어로그 표시
void _showPermissionDeniedDialog() {
  // GetXLocation locationController = Get.find(); // 위치와 관련된 getXmodel
  Get.defaultDialog(
    title: '권한 거부됨',
    middleText: '앱 사용을 위해 위치 권한이 필요합니다.\n 권한을 허용하지 않을 시 서비스를 이용할 수 없습니다.',
    // backgroundColor: Colors.yellowAccent,
    barrierDismissible: false,
    actions: [
      // TextButton(
      //   onPressed: () async {
      //     // 권한을 허용하는 부분 추가
      //     final permissionGranted = await locationController.requestLocationPermission();
      //     if (permissionGranted) {
      //       // 권한이 허용되었을 때 추가 동작 수행
      //       final position = await _getPosition();
      //       if (position != null) {
      //         print(position);
      //       }
      //     }
      //   },
      //   child: const Text('권한 허용'),
      // ),
      TextButton(
        onPressed: () {
          // 앱 종료 코드
          if (Platform.isIOS) {
            exit(0);
          } else {
            SystemNavigator.pop();
          }
        },
        child: const Text('앱 종료'),
      ),
    ],
  );
}

// 권한요청
Future<bool> _determinePermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return false;
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  }
  return true;
}

// GPS 정보 얻기
Future<Position?> _getPosition() async {
  try {
    LocationPermission permission =
        await Geolocator.requestPermission(); // 위치 권한 permission 띄우기
    if (permission == LocationPermission.denied) {
      // 위치 권한이 거부되었을 때
      _showPermissionDeniedDialog(); // 다이어로그 표시
      return null;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy:
            LocationAccuracy.best); // 내 위치를 가져오는 실질적인 부분으로 best한 위치를 가져옴
    return position;
  } catch (e) {
    if (e is PermissionRequestInProgressException) {
      // 위치 권한 요청이 이미 진행 중임
      return Future.error("권한 요청이 이미 진행중입니다.");
    }
    // 위치 권한이 거부됨
    _showPermissionDeniedDialog();
    return null;
  }
}







// 앱 권한 거부됐을 때 뜨는 다이어로그
// void _showPermissionDeniedDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('권한 거부됨'),
//         content:
//             const Text('앱 사용을 위해 위치 권한이 필요합니다. 권한을 허용하지 않을시 서비스를 이용할 수 없습니다.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // 앱 종료
//               if (Platform.isIOS) {
//                 exit(0);
//               } else {
//                 SystemNavigator.pop();
//               }
//             },
//             child: const Text('앱 종료'),
//           ),
//           TextButton(
//             onPressed: () {
//               // 다시 권한 요청 (이부분은 안됨 왜 그런지 죽어도 모르겠음;)
//               _determinePermission().then((permissionGranted) async {
//                 if (permissionGranted) {
//                   // 권한이 허용되었을 경우 추가 동작 수행
//                   final position = await _getPosition();
//                   if (position != null) {
//                     print(position);
//                   }
//                 }
//               });
//               Navigator.of(context).pop();
//             },
//             child: const Text('권한 다시 요청'),
//           ),
//         ],
//       );
//     },
//   );
// }
