// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'callend.dart';

// class AgoraDoctorCallScreen extends StatefulWidget {
//   final String channelId;
//   final String token;

//   const AgoraDoctorCallScreen({
//     super.key,
//     required this.channelId,
//     required this.token,
//   });

//   @override
//   State<AgoraDoctorCallScreen> createState() => _AgoraDoctorCallScreenState();
// }

// class _AgoraDoctorCallScreenState extends State<AgoraDoctorCallScreen> {
//   late final RtcEngine engine;
//   final RxBool isJoined = false.obs;
//   final RxBool isRemoteJoined = false.obs;
//   final RxInt remoteUid = 0.obs;
//   final RxBool isMuted = false.obs;
//   final RxBool isSpeakerOn = true.obs;

//   Timer? _timer;
//   final RxInt callDuration = 0.obs;

//   @override
//   void initState() {
//     super.initState();
//     _initAgora();
//   }

//   Future<void> _initAgora() async {
//     await [Permission.camera, Permission.microphone].request();

//     engine = createAgoraRtcEngine();
//     await engine.initialize(
//       RtcEngineContext(
//         appId: 'YOUR_AGORA_APP_ID',
//         channelProfile: ChannelProfileType.channelProfileCommunication,
//       ),
//     );

//     await engine.enableVideo();
//     await engine.startPreview();

//     _registerEvents();
//     await _joinChannel();

//   }

//   void _registerEvents() {
//     engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (connection, elapsed) {
//           log('DOCTOR JOINED');
//           isJoined.value = true;
//           _startTimer();
//         },
//         onUserJoined: (connection, uid, elapsed) {
//           log('PATIENT JOINED uid=$uid');
//           remoteUid.value = uid;
//           isRemoteJoined.value = true;
//         },
//         onUserOffline: (connection, uid, reason) {
//           log('PATIENT LEFT uid=$uid');
//           remoteUid.value = 0;
//           isRemoteJoined.value = false;
//         },
//         onLeaveChannel: (connection, stats) {
//           log('DOCTOR LEFT');
//           _stopTimer();
//           _goToCallEndScreen();
//         },
//         onError: (err, msg) => log('AGORA ERROR $err -> $msg'),
//       ),
//     );
//   }

//   Future<void> _joinChannel() async {
//     await engine.joinChannel(
//       token: widget.token,
//       channelId: widget.channelId,
//       uid: 0,
//       options: const ChannelMediaOptions(
//         autoSubscribeAudio: true,
//         autoSubscribeVideo: true,
//         publishCameraTrack: true,
//         publishMicrophoneTrack: true,
//         clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       ),
//     );
//   }

//   void _startTimer() {
//     _timer?.cancel();
//     callDuration.value = 0;
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       callDuration.value++;
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   Future<void> _endCall() async {
//     try {
//       _stopTimer();
//       await engine.leaveChannel();
//       await engine.stopPreview();
//       await engine.release();

//       if (mounted) {
//         _goToCallEndScreen();
//       }
//     } catch (e) {
//       log("END CALL ERROR: $e");
//     }
//   }

//   void _goToCallEndScreen() {
//     if (mounted) Get.off(() => const CallEndScreen());
//   }

//   @override
//   void dispose() {
//     _stopTimer();
//     engine.leaveChannel();
//     engine.stopPreview();
//     engine.release();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         return Stack(
//           children: [
//             // Remote video
//             Center(
//               child: isRemoteJoined.value
//                   ? AgoraVideoView(
//                       controller: VideoViewController.remote(
//                         rtcEngine: engine,
//                         canvas: VideoCanvas(uid: remoteUid.value),
//                         connection: RtcConnection(channelId: widget.channelId),
//                       ),
//                     )
//                   : const Icon(Icons.person, size: 120),
//             ),
//             // Local video small preview
//             Positioned(
//               top: 40,
//               right: 20,
//               child: SizedBox(
//                 width: 120,
//                 height: 160,
//                 child: AgoraVideoView(
//                   controller: VideoViewController(
//                     rtcEngine: engine,
//                     canvas: const VideoCanvas(uid: 0),
//                   ),
//                 ),
//               ),
//             ),
//             // Call controls
//             Positioned(
//               bottom: 40,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Mute
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: isMuted.value ? Colors.red : Colors.grey,
//                     child: IconButton(
//                       icon: Icon(
//                         isMuted.value ? Icons.mic_off : Icons.mic,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         isMuted.value = !isMuted.value;
//                         engine.muteLocalAudioStream(isMuted.value);
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   // Speaker
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: isSpeakerOn.value
//                         ? Colors.green
//                         : Colors.grey,
//                     child: IconButton(
//                       icon: Icon(
//                         isSpeakerOn.value ? Icons.volume_up : Icons.hearing,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         isSpeakerOn.value = !isSpeakerOn.value;
//                         engine.setEnableSpeakerphone(isSpeakerOn.value);
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   // End Call
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundColor: Colors.red,
//                     child: IconButton(
//                       icon: const Icon(Icons.call_end, color: Colors.white),
//                       onPressed: _endCall,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

class AgoraDoctorCallScreen extends StatefulWidget {
  final String channelId;
  final String token;

  const AgoraDoctorCallScreen({
    Key? key,
    required this.channelId,
    required this.token,
  }) : super(key: key);

  @override
  State<AgoraDoctorCallScreen> createState() => _AgoraDoctorCallScreenState();
}

class _AgoraDoctorCallScreenState extends State<AgoraDoctorCallScreen> {
  final AgoraCallController controller = Get.put(AgoraCallController());

  @override
  void initState() {
    super.initState();
    _prepareAndJoin();
  }

  Future<void> _prepareAndJoin() async {
    await [Permission.camera, Permission.microphone].request();

    if (controller.isJoined.value == true) {
      return;
    }

    try {
      await controller.joinCall(
        channelId: widget.channelId,
        token: widget.token,
      );
    } catch (e) {
      log('❌ joinCall failed: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Video Call')),
      body: Obx(() {
        final isJoined = controller.isJoined.value;
        final engine = controller.engine;
        final remoteUid = controller.remoteUid.value;
        final isRemoteJoined = controller.isRemoteUserJoined.value;

        if (!isJoined || engine == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Stack(
            children: [
              // Remote video (patient)
              Positioned.fill(
                child: isRemoteJoined && remoteUid != 0
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: engine,
                          canvas: VideoCanvas(uid: remoteUid),
                          connection: RtcConnection(
                            channelId: widget.channelId,
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: const Text(
                          'Waiting for patient to join...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),

              // Local video (doctor) - small overlay
              Positioned(
                top: 12,
                right: 12,
                width: 120,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.black,
                    child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom controls
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.toggleMute();
                        },
                        icon: Icon(
                          controller.isMuted.value ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.switchCamera();
                        },
                        icon: const Icon(
                          Icons.cameraswitch,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        onPressed: () async {
                          await controller.endCall();
                        },
                        child: const Text('End'),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.toggleSpeaker();
                        },
                        icon: Icon(
                          controller.isSpeakerOn.value
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
