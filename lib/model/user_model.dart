class UserModel {
  String? userId;
  String? name;
  String? email;
  String? profileImage;
  int? currentIndex;
  String? currentSentence;

  UserModel(
      {this.userId,
       this.name,
       this.email,
       this.profileImage,
       this.currentIndex,
       this.currentSentence
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
    currentIndex = json['currentIndex'];
    currentSentence = json['currentSentence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['profileImage'] = profileImage ?? name![0];
    data['currentIndex'] = currentIndex;
    data['currentSentence'] = currentSentence;
    return data;
  }
}
