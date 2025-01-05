import 'package:call_manager/module/data/contact_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CallManagerWidget extends StatefulWidget {
  const CallManagerWidget({
    super.key,
    required this.contactModel,
    required this.isVideoCall,
  });
  final ContactModel contactModel;
  final bool isVideoCall;

  @override
  State<CallManagerWidget> createState() => _AudioCallWidgetState();
}

class _AudioCallWidgetState extends State<CallManagerWidget> {
  int index = 0;
  late List<CameraDescription> _cameras;
  late CameraController controller;
  @override
  void initState() {
    videoCall = widget.isVideoCall;
    super.initState();
  }

  Future<void> getAvailableCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[index], ResolutionPreset.max);
    await controller.initialize();
  }

  BehaviorSubject<bool> micOn = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> volumeUp = BehaviorSubject.seeded(false);
  bool videoCall = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        getCallType(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    widget.contactModel.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                  const Spacer(),
                  customCircleAvatar(
                      child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )),
                ],
              ),
              cameraSwitch(),
              const Spacer(),
              Visibility(
                visible: videoCall == false,
                child: Visibility(
                  replacement: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.20),
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: theme.colorScheme.onPrimary,
                      )),
                  visible: widget.contactModel.avatar.isNotEmpty,
                  child: Image.network(widget.contactModel.avatar),
                ),
              ),
              const SizedBox(height: 10),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customCircleAvatar(
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          videoCall = !videoCall;
                          setState(() {});
                        },
                        icon: videoCall
                            ? const Icon(Icons.video_call)
                            : const Icon(Icons.videocam_off),
                      ),
                    ),
                    const SizedBox(width: 20),
                    speakerWidget(),
                    const SizedBox(width: 20),
                    micWidget(),
                    const SizedBox(width: 20),
                    customCircleAvatar(
                      child: IconButton(
                        highlightColor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.call_end),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget cameraSwitch() {
    final ThemeData theme = Theme.of(context);
    return Visibility(
      visible: videoCall == true,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        alignment: Alignment.centerRight,
        child: customCircleAvatar(
          child: IconButton(
              onPressed: () {
                if (index == 0) {
                  index = 1;
                } else {
                  index = 0;
                }
                setState(() {});
              },
              icon: Icon(
                Icons.camera_alt_outlined,
                color: theme.colorScheme.onPrimary,
              )),
        ),
      ),
    );
  }

  Widget customCircleAvatar({required Widget child}) {
    return CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.10),
      child: child,
    );
  }

  Widget getCallType() {
    if (videoCall) {
      return getCamerPreview();
    } else {
      return trasnparentBg();
    }
  }

  Widget getCamerPreview() {
    return FutureBuilder(
      future: getAvailableCamera(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(controller));
        } else {
          return trasnparentBg();
        }
      },
    );
  }

  Widget trasnparentBg() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Colors.black,
            Colors.transparent.withOpacity(0.8),
          ],
        ),
      ),
    );
  }

  Widget speakerWidget() {
    return StreamBuilder<bool>(
        stream: volumeUp.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return customCircleAvatar(
              child: IconButton(
                onPressed: () {
                  volumeUp.add(!volumeUp.value);
                },
                icon: snapshot.data!
                    ? const Icon(Icons.volume_up)
                    : const Icon(Icons.volume_down),
                color: Colors.white,
              ),
            );
          }
          return SizedBox();
        });
  }

  Widget micWidget() {
    return customCircleAvatar(
        child: StreamBuilder(
      stream: micOn.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return IconButton(
            color: snapshot.data! ? Colors.white : Colors.orange,
            onPressed: () {
              micOn.add(!micOn.value);
            },
            icon: snapshot.data!
                ? const Icon(Icons.mic)
                : const Icon(Icons.mic_off),
          );
        }
        return SizedBox();
      },
    ));
  }
}
