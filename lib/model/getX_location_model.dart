import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GetXLocation extends GetxController {
  Rx <Position?>  myLocation = Rx <Position?> (null);
  var isPermissionGranted = false.obs;

    // 두 지점 간의 거리 계산
  double calculateDistance() {
    if (myLocation.value == null) {
      return 0.0;
    } else{
    // 내 위치의 위도 경도 값
    double startLatitude = myLocation.value!.latitude;
    double startLongitude = myLocation.value!.longitude;

    // 더미데이터로 파파이스 강남점의 위도경도를 고정값으로 지정
    double endLatitude = 37.49327821749438; // 상대방의 위도
    double endLongitude = 127.02942893581022; // 상대방의 경도

    // 여기서 Geolocator에서 제공하는 distanceBetween함수를 통해서 거리가 계산됨
    double distanceInMeters = Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
    update();
    return distanceInMeters; // distanceBetween함수를 써서 나온 결과인 distanceInMeters를 return해줌
    }
  }

    void checkLocationPermission() async {
    final permissionGranted = await _determinePermission();
    isPermissionGranted.value = permissionGranted;
  }

  Future<bool> _determinePermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      isPermissionGranted.value = true;
    }
  }
}
  
