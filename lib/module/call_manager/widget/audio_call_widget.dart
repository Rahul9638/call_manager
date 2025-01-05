import 'package:call_manager/module/data/contact_model.dart';
import 'package:flutter/material.dart';

class AudioCallWidget extends StatefulWidget {
  const AudioCallWidget({super.key, required this.contactModel});
  final ContactModel contactModel;

  @override
  State<AudioCallWidget> createState() => _AudioCallWidgetState();
}

class _AudioCallWidgetState extends State<AudioCallWidget> {
  bool micOn = true;
  bool videoCall = false;
  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Container(
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
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.contactModel.name,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.colorScheme.onPrimary),
                  )
                ],
              ),
              Visibility(
                visible: videoCall == true,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.20),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: theme.colorScheme.onPrimary,
                      )),
                ),
              ),
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
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.20),
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
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.20),
                      child: IconButton(
                        color: micOn ? Colors.white : Colors.orange,
                        onPressed: () {
                          micOn = !micOn;
                          setState(() {});
                        },
                        icon: micOn
                            ? const Icon(Icons.mic)
                            : const Icon(Icons.mic_off),
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.20),
                      child: IconButton(
                        highlightColor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.call_end),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
