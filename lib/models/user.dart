import 'package:jumsRebootFlutter/models/semsterButtons.dart';

class User {
  final String name;
  final String course;
  final String imgUrl;
  final List<SemButtons> buttons;

  User({
    this.name,
    this.course,
    this.buttons,
    this.imgUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['buttons'] as List;
    List<SemButtons> buttonList =
        list.map((i) => SemButtons.fromJson(i)).toList();
    return User(
      name: json['name'],
      course: json['course'],
      imgUrl: json['imgUrl'],
      buttons: buttonList,
    );
  }
}
