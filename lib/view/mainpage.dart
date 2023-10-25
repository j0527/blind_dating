import 'dart:convert';
import 'dart:io';

import 'package:blind_dating/components/imageSlider_widget.dart';
import 'package:blind_dating/model/sliderItems_model.dart';
import 'package:blind_dating/view/mainpage_detail.dart';
import 'package:blind_dating/viewmodel/%08getX_location_%08ctrl.dart';
import 'package:blind_dating/viewmodel/getX_indicatorCurrent_crtl.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
// 이미지 슬라이더를 제어하기 위한 기본적인 컨트롤러
  final CarouselController sliderController = CarouselController();
  // 현재 이미지 슬라이더의 상태를 관리하는 GetX 컨트롤러
  final IndicatorCurrent indicatorCurrent = Get.put(IndicatorCurrent());
  // 위치와 관련된 getXmodel
  final GetXLocation locationController = Get.put(GetXLocation());
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

  Future<String> initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? " ";
    upw = prefs.getString('upw') ?? " ";
    print("send uid: $uid");
    print("send upw: $upw");
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    Future<List> getLoginData() async {
      // initSharedPreferences에서 uid만 가져와서 요청 보내기
      String getUid = await initSharedPreferences();
      print("getLoginData uid:$uid");
      var url = Uri.parse(
          'http://localhost:8080/Flutter/dateapp_login_quary_flutter.jsp?uid=$getUid');
      print(url);
      var response = await http.get(url); // 데이터가 불러오기 전까지 화면을 구성하기 위해 기다려야됨
      loginData.clear(); // then해주면 계속 쌓일 수 있으니 클리어해주기
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results'];
      loginData.addAll(result);
      // print("Login result: $result");
      return result;
    }

    Future<List> getUserData() async {

      var url =
          Uri.parse('http://localhost:8080/Flutter/dateapp_quary_flutter.jsp');

      var response = await http.get(url); // 데이터가 불러오기 전까지 화면을 구성하기 위해 기다려야됨
      userData.clear(); // then해주면 계속 쌓일 수 있으니 클리어해주기
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      List result = dataConvertedJSON['results'];
      userData.addAll(result);
      // print(result);
      return await result;
    }

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
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([_initLocation(), getUserData(), getLoginData()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if (snapshot.hasData && snapshot.data?.length == 2) {
              if (snapshot.hasData) {
                Position? userPosition = snapshot.data?[0]; // 현재 내 위치
                List? userList = snapshot.data?[1]; // db에서 불러온 유저 정보 리스트
                List? loginData = snapshot.data?[2]; // 로그인된 유저의 데이터

                // print("Future Login Data: $loginData");
                if (userList != null) {
                  locationController.userList(
                      userList); // 컨트롤러의 userList 변수에 불러온 snapshot.data?[1] 넘겨주기
                }

                // print("userList: $userList");

                // 이미지와 텍스트 가지는 더미데이터 리스트
                final List<SliderlItems> carouselItems = [
                  SliderlItems(
                    userimagePath: userList![0]['udogimg'],
                    userName: userList[0]['unickname'],
                    userAge: "${locationController.ageCalc()[0]} 세",
                    userLocation: userList[0]['uaddress'],
                    userDistance: reciveUserDistance,
                    userMBTI: userList[0]['umbti'],
                  ),
                  SliderlItems(
                    userimagePath: userList[1]['udogimg'],
                    userName: userList[1]['unickname'],
                    userAge: "${locationController.ageCalc()[1]} 세",
                    userLocation: userList[1]['uaddress'],
                    userDistance: '20km',
                    userMBTI: userList[1]['umbti'],
                  ),
                ];

                if (userPosition != null) {
                  // GetXLocation locationController = Get.find();
                  double calcDistance = locationController.calculateDistance();
                  reciveUserDistance =
                      '${calcDistance >= 1000.0 ? (calcDistance / 1000.0).toStringAsFixed(2) : calcDistance.toStringAsFixed(2)}${calcDistance >= 1000.0 ? "Km" : "m"}';
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            const MainPageDetail(),
                            arguments: {
                              'items': carouselItems,
                              'index': indicatorCurrent.current,
                            },
                          );
                          print("carouselItems: $carouselItems");
                        },
                        child: Container(
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
                      ),
                      // Text(data[1]['unickname']),
                      // Text("${userList[0]['unickname']}"),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return Text('위치 가져오는 중에 오류가 발생했습니다: ${snapshot.error}');
              }
            }
            // }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

// ---- Functions ----

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
