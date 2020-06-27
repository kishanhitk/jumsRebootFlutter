import 'package:jumsRebootFlutter/models/semsterButtons.dart';
import 'package:jumsRebootFlutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  void saveToDb(User user, String uname, String pass) async {
    final String encodedData = SemButtons.encodeButtons(user.buttons);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uname', uname);
    prefs.setString('pass', pass);
    prefs.setString('buttons', encodedData);
    prefs.setString('name', user.name);
    prefs.setString('course', user.course);
    prefs.setString('imgUrl', user.imgUrl);
  }
}
