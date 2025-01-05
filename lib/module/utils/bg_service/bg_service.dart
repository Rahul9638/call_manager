import 'package:call_manager/module/utils/call_manager.dart';
import 'package:call_manager/module/utils/work_manager_constant.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    const Uuid uuid = Uuid();
    switch (task) {
      case WorkMangerConstant.registerIncomingCall:
        print("******* this *******");
        CallNotificationHandler.showCallkitIncoming(uuid.v4());
        break;
      default:
    }
    return Future.value(true);
  });
}
