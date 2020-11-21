import 'package:in_app_update/in_app_update.dart';

class Updater {
  static Future<void> performInAppUpdate() async {
    print("CHECKING FOR UPDATES");
    AppUpdateInfo updateInfo;

    try {
      updateInfo = await InAppUpdate.checkForUpdate();
    } catch (e) {
      print(e);
    }
    print("UPDATE INFO IS $updateInfo");
    if (updateInfo.updateAvailable) {
      if (updateInfo.flexibleUpdateAllowed) {
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      } else if (updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      }
    } else {
      print("No Update available");
    }
  }
}
