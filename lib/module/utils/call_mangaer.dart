import 'package:call_manager/module/call_manager/widget/audio_call_widget.dart';
import 'package:call_manager/module/data/contact_model.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter/material.dart';

class CallNotificationHandler {
  static void initializeCallKitListener(BuildContext context) {
    FlutterCallkitIncoming.onEvent.listen(
      (CallEvent? event) {
        switch (event!.event) {
          case Event.actionCallAccept:
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              builder: (context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CallManagerWidget(
                    isVideoCall: true,
                    contactModel: ContactModel(
                      avatar: "https://i.pravatar.cc/100",
                      name: "Rahul Kumar Paswan",
                      mobileNumber: "+917717743329",
                    ),
                  ),
                );
              },
            );
            break;
          default:
        }
      },
    );
  }

  static Future<void> showCallkitIncoming(String uuid) async {
    final params = CallKitParams(
      id: uuid,
      nameCaller: 'Rahul Kumar Paswan',
      appName: 'Call Manager',
      avatar: 'https://i.pravatar.cc/100',
      handle: '0123456789',
      type: 1,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
        textColor: '#ffffff',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
