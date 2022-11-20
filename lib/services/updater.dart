import 'package:in_app_update/in_app_update.dart';

class Updater {
  static Future<void> performInAppUpdate() async {
    AppUpdateInfo updateInfo;

    try {
      updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        } else if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
