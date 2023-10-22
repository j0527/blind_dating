import 'package:get/get.dart';

class IndicatorCurrent extends GetxController{
  RxInt current = 0.obs; // RxInt는 상태변화를 알 수 있게해주는 타입으로, .obs는 옵져버로 변경되는 current값을 알 수 있게됨

  setCurrent(int value) {
    current.value = value;
    update();
  }

}