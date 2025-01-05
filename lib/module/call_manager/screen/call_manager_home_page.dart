import 'package:call_manager/module/call_manager/widget/audio_call_widget.dart';
import 'package:call_manager/module/data/contact_model.dart';
import 'package:call_manager/module/utils/call_manager.dart';
import 'package:call_manager/module/utils/work_manager_constant.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class CallManagerHomePage extends StatefulWidget {
  const CallManagerHomePage({super.key});

  @override
  State<CallManagerHomePage> createState() => _CallManagerHomePageState();
}

class _CallManagerHomePageState extends State<CallManagerHomePage> {
  @override
  void initState() {
    CallNotificationHandler.initializeCallKitListener(context);
    Workmanager().registerPeriodicTask(
      "registerIncomingCall",
      WorkMangerConstant.registerIncomingCall,
      initialDelay: const Duration(seconds: 10),
      frequency: Duration(minutes: 15),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Call Manager'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10),
              spreadRadius: 10,
              blurRadius: 10,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return getContactTile(
                    theme,
                    data: model()[index],
                    onAudioCall: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        enableDrag: false,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: CallManagerWidget(
                              isVideoCall: false,
                              contactModel: model()[index],
                            ),
                          );
                        },
                      );
                    },
                    onVideoCall: () {
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
                              contactModel: model()[index],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: model().length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getContactTile(
    ThemeData theme, {
    required ContactModel data,
    required VoidCallback onAudioCall,
    required VoidCallback onVideoCall,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.secondary.withOpacity(0.9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                ),
                Text(
                  data.mobileNumber,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: theme.colorScheme.onPrimary),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: onAudioCall,
            icon: Icon(
              Icons.call,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          IconButton(
              onPressed: onVideoCall,
              icon: Icon(
                Icons.video_call,
                color: theme.colorScheme.onPrimary,
              ))
        ],
      ),
    );
  }
}

List<ContactModel> model() => [
      ContactModel(
        avatar: '',
        name: "Rahul Kumar",
        mobileNumber: "+9198838828",
      ),
      ContactModel(
        avatar: '',
        name: "Kishan Kumar",
        mobileNumber: "+9198838828",
      ),
      ContactModel(
        avatar: '',
        name: "Ashutosh Kumar",
        mobileNumber: "+9198838838",
      ),
      ContactModel(
        avatar: '',
        name: "Ananad Bharti",
        mobileNumber: "+9198838333",
      ),
      ContactModel(
        avatar: '',
        name: "Tinku Tiwari",
        mobileNumber: "+9198838828",
      ),
      ContactModel(
        avatar: '',
        name: "Suresh Uncle",
        mobileNumber: "+9198842428",
      ),
      ContactModel(
        avatar: '',
        name: "Tabrej Alam",
        mobileNumber: "+9198838828",
      ),
    ];
