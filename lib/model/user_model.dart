class UserModel {
  int? userId;
  String? username;
  String? email;
  String? password;
  String? profileImage;
  int? isLoggedIn;
  int? doNotShowAgain;

  UserModel(
      {this.userId,
      required this.username,
      required this.email,
      required this.password,
      this.profileImage,
      this.isLoggedIn = 0,
      this.doNotShowAgain = 0});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    profileImage = json['profileImage'];
    isLoggedIn = json['isLoggedIn'];
    doNotShowAgain = json['doNotShowAgain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['password'] = password;
    data['email'] =  email;
    data['profileImage'] = profileImage ?? username![0];
    data['isLoggedIn'] = isLoggedIn;
    data['doNotShowAgain'] = doNotShowAgain;
    return data;
  }
}
