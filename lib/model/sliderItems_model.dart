class SliderlItems {
  final String userimagePath; // 슬라이더의 이미지 정보
  final String userName; // 슬라이더에 뜰 유저 이름
  final String userAge; // 슬라이더에 뜰 유저 나이
  final String userLocation; // 슬라이더에 뜰 유저 지역
  late String userDistance; // 슬라이더에 뜰 유저와의 거리
  final String userMBTI;

  SliderlItems({
    required this.userimagePath,
    required this.userName,
    required this.userAge,
    required this.userLocation,
    required this.userDistance,
    required this.userMBTI
  });
}
