import 'package:jums_reboot/models/semsterButtons.dart';

class User {
  String name;
  String course;
  String imgUrl;
  List<SemButtons> buttons;

  User(this.name, this.course, this.imgUrl, this.buttons);

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['buttons'] as List;
    List<SemButtons> buttonList =
        list.map((i) => SemButtons.fromJson(i)).toList();
    return User(
      json['name'],
      json['course'],
      json['imgUrl'],
      buttonList,
    );
  }
}
