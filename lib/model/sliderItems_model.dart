// ignore_for_file: file_names

class SliderlItems {
  final String
      userMainImagePath; // 유저 메인페이지 이미지 (구독 여부에 따라 다른 이미지로 전달됨)
  final String userFaceImagePath1; // 유저 얼굴이미지1
  final String userFaceImagePath2; // 유저 얼굴이미지2
  final String userHobbyImagePath1; // 유저 취미 이미지1
  final String userHobbyImagePath2; // 유저 취미 이미지2
  final String userHobbyImagePath3; // 유저 취미 이미지3
  final String userDogImagePath; // 유저 닮은 강아지 이미지
  final String userName; // 유저 닉네임
  final String userAge; // 유저 나이
  final String userAddress; // 유저 지역
  late String userDistance; // 유저와의 거리
  final String userMBTI; // 유저 mbti
  final String userBreed; // 유저 닮은 견종
  final String userSmoke; // 유저 흡연여부
  final String loginUid; // 로그인된 유저 id
  final int loginGrant; // 로그인된 유저 구독 여부
  final String loginName; // 로그인된 유저 닉네임
  final int loginChatCount; // 로그인된 유저 

  SliderlItems({
      required this.userMainImagePath,
      required this.userFaceImagePath1,
      required this.userFaceImagePath2,
      required this.userHobbyImagePath1,
      required this.userHobbyImagePath2,
      required this.userHobbyImagePath3,
      required this.userDogImagePath,
      required this.userName,
      required this.userAge,
      required this.userAddress,
      required this.userDistance,
      required this.userMBTI,
      required this.userBreed,
      required this.userSmoke,
      required this.loginUid,
      required this.loginGrant,
      required this.loginName,
      required this.loginChatCount
      });

}
