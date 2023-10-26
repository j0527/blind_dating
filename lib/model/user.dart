class UserModel{
  String? id;
  String password;
  String phoneNo;
  String address;

  UserModel(
    {
      this.id,
      required this.password,
      required this.phoneNo,
      required this.address,
  }
  );

  toJson(){
    return{
    "password": password,
    "phone": phoneNo,
    "address": address
    };
  }

}