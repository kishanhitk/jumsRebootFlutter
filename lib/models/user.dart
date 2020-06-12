import 'package:jumsRebootFlutter/models/semsterButtons.dart';

class User {
  final String name;
  final String course;
  final String imgUrl;
  final List<SemButtons> buttons;
  final List<String> notices;
  User({this.name, this.course, this.buttons, this.imgUrl, this.notices});

  factory User.fromJson(Map<String, dynamic> json) {
    var noticesFromJson = json['notices'];
    List<String> noticeList = List<String>.from(noticesFromJson);
    var list = json['buttons'] as List;
    List<SemButtons> buttonList =
        list.map((i) => SemButtons.fromJson(i)).toList();
    return User(
      name: json['name'],
      course: json['course'],
      imgUrl: json['imgUrl'],
      buttons: buttonList,
      notices: noticeList,
    );
  }
}
