import 'package:get/get.dart';

class PayMentsController extends GetxController {
  RxBool checkAll = false.obs; // 모두 선택
  RxBool electronicPay = false.obs; // 전자거래 동의
  RxBool userInfoUsage = false.obs; // 개인정보 처리동의
  RxBool userInfoThirdParties = false.obs; // 3자 정보제공동의
  RxString selectedPayment = RxString(""); // 결제수단 종류

  // 결제수단 상태관리
  void funcSelectPayment(String value) {
    selectedPayment.value = value;
  }

  void funcAllCheck(bool value) {
    checkAll.value = value;
    electronicPay.value = value;
    userInfoUsage.value = value;
    userInfoThirdParties.value = value;
  }

  void funcElectroCheck(bool? value) {
    if (value != null) {
      // 널체크 안해주면 얘는 고장남;
      electronicPay.value = value;
      updateCheckAll();
    }
  }

  void funcUserInfoCheck(bool value) {
    userInfoUsage.value = value;
    updateCheckAll();
  }

  void funcUserInfoThirdPartiesCheck(bool value) {
    userInfoThirdParties.value = value;
    updateCheckAll();
  }

  void updateCheckAll() {
    checkAll.value = electronicPay.value &&
        userInfoUsage.value &&
        userInfoThirdParties.value;
    // update();
  }

  Future purchaseAction() async {
    
  }
}
