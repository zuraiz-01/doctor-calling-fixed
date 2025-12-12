

// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';

// class AgoraCallController extends GetxController {
//   final ApiRepo _repo = ApiRepo();

//   RtcEngine? engine;

//   var isJoined = false.obs;
//   var channelId = "".obs;
//   var doctorToken = "".obs;

//   var isLocalMicActive = true.obs;
//   var callDuration = 0.obs;

//   Appointment? currentAppointment;

//   // -----------------------------------------------------------
//   // 🔥 STEP 1 — Set Appointment Data
//   // -----------------------------------------------------------
//   void setAppointment(Appointment appt) {
//     currentAppointment = appt;

//     channelId.value = appt.id ?? "";  // channel = appointment ID
//     doctorToken.value = appt.doctorAgoraToken ?? "";

//     log("🔥 Appointment SET → Channel: ${channelId.value}, Token: ${doctorToken.value}");
//   }

//   // -----------------------------------------------------------
//   // 🔥 STEP 2 — CallNow API (Doctor Side)
//   // -----------------------------------------------------------
//   Future<void> callNow() async {
//     if (currentAppointment == null) {
//       log("❌ Appointment Not Set!");
//       return;
//     }

//     final id = currentAppointment!.id!;

//     final response = await _repo.makeAppointmentCall(
//       appointmentId: id,
//     );

//     log("📞 CallNow Response: $response");

//     if (response["status"] == "success") {
//       // Backend agar new token bhej raha ho to update kar do
//       if (response["token"] != null) {
//         doctorToken.value = response["token"];
//       }

//       await initAgoraAndJoin();

//       Get.toNamed("/AgoraDoctorCallScreen");
//     } else {
//       Get.snackbar("Error", "Unable to place call");
//     }
//   }

//   // -----------------------------------------------------------
//   // 🔥 STEP 3 — INIT Agora + Join Channel
//   // -----------------------------------------------------------
// //   Future<void> initAgoraAndJoin() async {
// //     if (channelId.isEmpty || doctorToken.isEmpty) {
// //       log("❌ Channel ID or Token Missing!");
// //       return;
// //     }

// //     engine = createAgoraRtcEngine();
// //     await engine!.initialize(const RtcEngineContext(
// //       appId: "0fb1a1ecf5a34db2b51d9896c994652a",
// //     ));
// // print("ENGINE INIT DONE");
// //     engine!.registerEventHandler(
// //       RtcEngineEventHandler(
// //         onJoinChannelSuccess: (connection, elapsed) {
// //           log("🔥 Doctor Joined Channel: ${channelId.value}");
// //           isJoined.value = true;
// //           _startTimer();
// //         },
// //         onUserJoined: (connection, remoteUid, elapsed) {
// //           log("👤 PATIENT JOINED: $remoteUid");
// //         },
// //         onUserOffline: (connection, remoteUid, reason) {
// //           log("❌ PATIENT LEFT");
// //           endCall();
// //         },
// //       ),
// //     );

// //     await engine!.enableAudio();

// //     await engine!.joinChannel(
// //       token: doctorToken.value,
// //       channelId: channelId.value,
// //       uid: 0,
// //       options: const ChannelMediaOptions(),
// //     );
// //   }
// Future<void> initAgoraAndJoin() async {
//   if (channelId.isEmpty || doctorToken.isEmpty) {
//     log("❌ Channel ID or Token Missing!");
//     return;
//   }

//   engine = createAgoraRtcEngine();

//   // 1️⃣ Initialize engine first
//   await engine!.initialize(const RtcEngineContext(
//     appId: "0fb1a1ecf5a34db2b51d9896c994652a",
//   ));

//   print("ENGINE INIT DONE");

//   // 2️⃣ Wait a small delay (Agora recommended)
//   await Future.delayed(const Duration(milliseconds: 300));

//   // 3️⃣ Register event handlers
//   engine!.registerEventHandler(
//     RtcEngineEventHandler(
//       onJoinChannelSuccess: (connection, elapsed) {
//         log("🔥 Doctor Joined Channel: ${channelId.value}");
//         isJoined.value = true;
//         _startTimer();
//       },
//       onUserJoined: (connection, remoteUid, elapsed) {
//         log("👤 PATIENT JOINED: $remoteUid");
//       },
//       onUserOffline: (connection, remoteUid, reason) {
//         log("❌ PATIENT LEFT");
//         endCall();
//       },
//     ),
//   );

//   // 4️⃣ Ab audio enable karo (ab engine ready hai)
//   await engine!.enableAudio();

//   // 5️⃣ Finally join channel
//   await engine!.joinChannel(
//     token: doctorToken.value,
//     channelId: channelId.value,
//     uid: 0,
//     options: const ChannelMediaOptions(),
//   );
// }

//   // -----------------------------------------------------------
//   // 🔥 Timer
//   // -----------------------------------------------------------
//   void _startTimer() {
//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 1));
//       if (isJoined.value) {
//         callDuration.value++;
//         return true;
//       }
//       return false;
//     });
//   }

//   // -----------------------------------------------------------
//   // 🔥 MIC Toggle
//   // -----------------------------------------------------------
//   void toggleMic() {
//     isLocalMicActive.value = !isLocalMicActive.value;
//     engine?.muteLocalAudioStream(!isLocalMicActive.value);
//   }

//   // -----------------------------------------------------------
//   // 🔥 End Call
//   // -----------------------------------------------------------
//   void endCall() async {
//     await engine?.leaveChannel();
//     await engine?.release();
//     Get.back();
//   }

//   @override
//   void onClose() {
//     engine?.leaveChannel();
//     engine?.release();
//     super.onClose();
//   }
// }

// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';

// class AgoraCallController extends GetxController {
//   final ApiRepo _repo = ApiRepo();

//   RtcEngine? engine;

//   var isJoined = false.obs;
//   var channelId = "".obs;
//   var doctorToken = "".obs;

//   Appointment? currentAppointment;

//   // -----------------------------------------------------------
//   // STEP 1 — Set Appointment Data from Appointment List API
//   // -----------------------------------------------------------
//   void setAppointment(Appointment appt) {
//     currentAppointment = appt;

//     channelId.value = appt.id ?? "";               // Channel = Appointment ID
//     doctorToken.value = appt.doctorAgoraToken ?? ""; // Token from appointment list

//     log("🔥 Appointment SET → Channel: ${channelId.value}, Token: ${doctorToken.value}");
//   }

//   // -----------------------------------------------------------
//   // STEP 2 — CallNow API (Notify Patient)
//   // -----------------------------------------------------------
//   Future<void> callNow() async {
//     if (currentAppointment == null) {
//       log("Patient Token: ${currentAppointment?.patientAgoraToken}");

//       log("❌ Appointment Not Set!");
//       return;
//     }

//     // Just notify the patient
//     final id = currentAppointment!.id!;
//     final response = await _repo.makeAppointmentCall(
//       appointmentId: id,
//     );

//     log("📞 CallNow API Response: $response");

//     // Backend se koi new token expect nahi → ignore
//     await initAgoraAndJoin();

//     // Move to Call Screen
//     Get.toNamed("/AgoraDoctorCallScreen");
//   }

//   // -----------------------------------------------------------
//   // STEP 3 — Initialize Agora + Join Channel
//   // -----------------------------------------------------------
//   Future<void> initAgoraAndJoin() async {
//     if (channelId.value.isEmpty || doctorToken.value.isEmpty) {
//       log("❌ Missing Channel or Token");
//       Get.snackbar("Error", "Channel or Token Missing!");
//       return;
//     }

//     engine = createAgoraRtcEngine();

//     await engine!.initialize(
//       const RtcEngineContext(
//         appId: "0fb1a1ecf5a34db2b51d9896c994652a",
//       ),
//     );

//     log("🔥 Agora Engine Initialized");

//     engine!.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (connection, elapsed) {
//           log("✅ Doctor Joined Channel: ${channelId.value}");
//           isJoined.value = true;
//         },
//         onUserJoined: (connection, remoteUid, elapsed) {
//           log("👤 Patient Joined: $remoteUid");
//         },
//         onUserOffline: (connection, remoteUid, reason) {
//           log("❌ Patient Left Call");
//           endCall();
//         },
//       ),
//     );

//     await engine!.enableAudio();

//     await engine!.joinChannel(
//       token: doctorToken.value,
//       channelId: channelId.value,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//   }

//   // -----------------------------------------------------------
//   // END CALL
//   // -----------------------------------------------------------
//   void endCall() async {
//     await engine?.leaveChannel();
//     await engine?.release();
//     isJoined.value = false;

//     Get.back();
//   }
// }

// lib/controllers/agora_call_controller.dart
// import 'dart:async';
// import 'dart:developer';

// import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';



// class AgoraCallController extends GetxController {
//   final ApiRepo _repo = ApiRepo(); // your repo class (change if necessary)

//   RtcEngine? engine;

//   var isJoined = false.obs;
//   var channelId = "".obs;
//   var doctorToken = "".obs;

//   Appointment? currentAppointment;

//   // call duration
//   var callDurationSec = 0.obs;
//   Timer? _callTimer;

//   @override
//   void onClose() {
//     _stopTimer();
//     _cleanupEngine();
//     AgoraCallSocketHandler.instance.disposeSocket();
//     super.onClose();
//   }

//   /// Set appointment object BEFORE pressing Call
//   void setAppointment(Appointment appt) {
//     currentAppointment = appt;

//     channelId.value = appt.id ?? "";
//     doctorToken.value = appt.doctorAgoraToken ?? "";

//     log("Appointment set: channel=${channelId.value}, token=${doctorToken.value}");
//   }

//   /// Called when doctor taps Call Now
//   Future<void> callNow() async {
//     if (currentAppointment == null) {
//       Get.snackbar("Error", "Appointment not set");
//       log("Attempt to call without appointment");
//       return;
//     }

//     final apptId = currentAppointment!.id!;
//  final patientId = currentAppointment!.patient?.id ?? "";
// final doctorId = currentAppointment!.doctor?.id ?? "";


//     // init socket and listen for events (so doctor can receive joined/reject/end)
//     await AgoraCallSocketHandler.instance.initSocket(
//       appointmentId: apptId,
//       onJoinedEvent: (data) {
//         // server might send remoteUid or not — we log it
//         log("Socket Event: joinedCall -> $data");
//         // you can react: eg. show UI update that patient joined
//         // But Agora's onUserJoined will also fire when patient joins
//       },
//       onRejectedEvent: (data) {
//         log("Socket Event: rejectCall -> $data");
//         // handle UI notify
//         Get.snackbar("Info", "Patient rejected the call");
//         // optionally end call here
//         endCall();
//       },
//       onEndedEvent: (data) {
//         log("Socket Event: endCall -> $data");
//         // patient ended
//         Get.snackbar("Info", "Call ended by patient");
//         endCall();
//       },
//     );

//     // Notify backend to ring patient (your repo method)
//     try {
//       toggleCallerLoading(true);
//       final response = await _repo.makeAppointmentCall(appointmentId: apptId);
//       log("makeAppointmentCall response: $response");
//     } catch (e) {
//       log("makeAppointmentCall error: $e");
//     } finally {
//       toggleCallerLoading(false);
//     }

//     // Initialize Agora and join channel as doctor
//     await initAgoraAndJoin();

//     // start timer
//     _startTimer();

//     // Navigate to call screen
//     Get.toNamed("/AgoraDoctorCallScreen");
//   }

//   void toggleCallerLoading(bool val) {
//     // small helper in case you show loader
//     // not reactive here but you can extend this with an Rx bool
//     log("Caller loading: $val");
//   }

//   Future<void> initAgoraAndJoin() async {
//     if (channelId.value.isEmpty || doctorToken.value.isEmpty) {
//       Get.snackbar("Error", "Channel or token missing");
//       log("Missing token or channel");
//       return;
//     }

//     await _cleanupEngine(); // ensure no old engine

//     engine = createAgoraRtcEngine();
//     await engine!.initialize(const RtcEngineContext(
//       appId: "0fb1a1ecf5a34db2b51d9896c994652a",
//     ));

//     log("Agora engine initialized");

//     engine!.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           log("Agora: joined channel ${channelId.value}");
//           isJoined.value = true;
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           log("Agora: remote user joined -> $remoteUid");
//           // Optionally update UI here (we set isJoined true above on join)
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           log("Agora: remote user offline -> $remoteUid");
//           // patient left -> end call cleanup
//           endCall();
//         },
//         onError: (ErrorCodeType code, String message) {
//           log("Agora error $code -> $message");
//         },
//       ),
//     );

//     await engine!.enableAudio();

//     await engine!.joinChannel(
//       token: doctorToken.value,
//       channelId: channelId.value,
//       uid: 0, // doctor UID zero (or use your appointment-specific uid)
//       options: const ChannelMediaOptions(),
//     );
//   }

//   Future<void> endCall() async {
//     final apptId = currentAppointment?.id ?? "";

//     // Notify server via socket that doctor ended
//     try {
//       AgoraCallSocketHandler.instance.emitEndCall(appointmentId: apptId);
//     } catch (e) {
//       log("emitEndCall error: $e");
//     }

//     await _cleanupEngine();
//     _stopTimer();

//     // Go back if currently on call screen
//     if (Get.currentRoute == "/AgoraDoctorCallScreen") {
//       Get.back();
//     }
//   }

//   Future<void> _cleanupEngine() async {
//     try {
//       if (engine != null) {
//         await engine!.leaveChannel();
//         await engine!.release();
//         engine = null;
//       }
//       isJoined.value = false;
//     } catch (e) {
//       log("cleanup engine failed: $e");
//     }
//   }

//   void _startTimer() {
//     _callTimer?.cancel();
//     callDurationSec.value = 0;
//     _callTimer = Timer.periodic(Duration(seconds: 1), (_) {
//       callDurationSec.value++;
//     });
//   }

//   void _stopTimer() {
//     _callTimer?.cancel();
//     _callTimer = null;
//   }
// }


// sammmmm

import 'dart:async';

import 'dart:developer';
import 'package:beh_doctor/Handler/AgoraCallSocketHandler.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class AgoraCallController extends GetxController {
  final ApiRepo _repo = ApiRepo();

  RtcEngine? engine;

  var isJoined = false.obs;
  var isRemoteUserJoined = false.obs;

  // Remote user UID
  var remoteUid = 0.obs;
RxBool isMuted = false.obs;
RxBool isSpeakerOn = false.obs;
  /// Channel ID = Appointment ID
  String channelId = "";

  /// Doctor token from appointment
  String doctorToken = "";

  Appointment? currentAppointment;

  var callDurationSec = 0.obs;
  Timer? _callTimer;

  // Prevent concurrent join attempts
  bool _joining = false;

  @override
  void onClose() {
    _stopTimer();
    _cleanupEngine();
    try {
      AgoraCallSocketHandler.instance.disposeSocket();
    } catch (_) {}
    super.onClose();
  }

  // ------------------------------------------------
  // SET APPOINTMENT
  // ------------------------------------------------
  void setAppointment(Appointment appt) {
    currentAppointment = appt;

    channelId = appt.id ?? "";
    doctorToken = appt.doctorAgoraToken ?? "";

    log("SET APPT => channel: $channelId | token: ${doctorToken.isNotEmpty ? '***' : 'EMPTY'}");
    print("💡 Doctor Token set: $doctorToken"); // <-- Added log
    print("currentAppointment${appt}");
  
  }

  // ------------------------------------------------
  // DOCTOR PRESS CALL NOW
  // ------------------------------------------------
  Future<void> callNow() async {
    if (currentAppointment == null) {
      Get.snackbar("Error", "Appointment not found");
      log("callNow aborted: appointment null");
      return;
    }

    print("💡 callNow() - Doctor Token: $doctorToken"); // <-- Added log

    // 1 - Notify Server / Patient
    try {
      log("Calling API to notify patient...");
      final res = await _repo.makeAppointmentCall(
        appointmentId: currentAppointment!.id!,
      );
      log("CallNow API => $res");

      if (res == null) {
        Get.snackbar("Error", "Call API returned null");
        return;
      }
      if (res is Map && res["status"] != "success") {
        Get.snackbar("Error", res["message"] ?? "Failed to notify patient");
        return;
      }
    } catch (e, st) {
      log("CallNow API ERROR => $e\n$st");
      Get.snackbar("Error", "Failed to notify patient. Check network.");
      return;
    }

    // 2 - Init socket for patient events
    try {
      await AgoraCallSocketHandler.instance.initSocket(
        appointmentId: channelId,
        onJoinedEvent: (data) {
          log("🔥 Socket => PATIENT JOINED (socket event) -> $data");
          isRemoteUserJoined.value = true;
        },
        onRejectedEvent: (data) {
          log("❌ PATIENT REJECTED (socket event) -> $data");
          Get.snackbar("Rejected", "Patient rejected the call");
          endCall();
        },
        onEndedEvent: (data) {
          log("⚠ PATIENT ENDED CALL (socket event) -> $data");
          endCall();
        },
      );
    } catch (e) {
      log("Socket init failed: $e");
      Get.snackbar("Warning", "Socket init failed, continuing with call...");
    }

    // 3 - Join Agora (asynchronously start)
    try {
      await joinDoctorAgora();
    } catch (e) {
      log("joinDoctorAgora threw: $e");
      Get.snackbar("Error", "Unable to start Agora. ${e.toString()}");
      await _cleanupEngine();
      return;
    }

    // 4 - Wait for Agora join success before navigating / starting timer
    try {
      await isJoined.stream.firstWhere((v) => v == true).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          throw TimeoutException("Agora join timed out");
        },
      );

      _startTimer();

      Get.toNamed("/AgoraDoctorCallScreen");
    } on TimeoutException catch (te) {
      log("Agora join timeout: $te");
      Get.snackbar("Error", "Unable to join call (timeout).");
      await _cleanupEngine();
    } catch (e) {
      log("Error waiting for join: $e");
      Get.snackbar("Error", "Unable to start call.");
      await _cleanupEngine();
    }
  }

  // ------------------------------------------------
  // JOIN AGORA (DOCTOR)
  // ------------------------------------------------
  Future<void> joinDoctorAgora() async {
    if (channelId.isEmpty || doctorToken.isEmpty) {
      Get.snackbar("Error", "Agora token or channel missing");
      log("joinDoctorAgora aborted: token or channel missing");
      return;
    }

   

    if (_joining) {
      log("Already joining, ignoring duplicate call");
      return;
    }
    _joining = true;

    try {
      // DON'T cleanup engine here, just initialize if null
      if (engine == null) {
        engine = createAgoraRtcEngine();
        await engine!.initialize(
          const RtcEngineContext(
            appId: "0fb1a1ecf5a34db2b51d9896c994652a",
          ),
        );
        log("AGORA INIT ✔");
      } else {
        log("Engine already initialized");
      }

      // Register event handler
      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            log("✔ DOCTOR JOINED CHANNEL");
            isJoined.value = true;
          },
          onUserJoined: (connection, uid, elapsed) {
            log("👤 PATIENT JOINED => $uid");
            remoteUid.value = uid;
            isRemoteUserJoined.value = true;
          },
          onUserOffline: (connection, uid, reason) {
            log("❌ PATIENT LEFT => $reason");
            isRemoteUserJoined.value = false;
            endCall();
          },
          onError: (code, msg) {
            log("🔥 AGORA ERROR => $code | $msg");
            Get.snackbar("Agora Error", "$code: $msg");
          },
        ),
      );

      // Enable devices
      await engine!.enableVideo();
      await engine!.enableAudio();

      log("💡 Joining with token: $doctorToken");
      try {
        await engine!.joinChannel(
          token: doctorToken,
          channelId: channelId,
          uid: 0,
          options: const ChannelMediaOptions(),
        );
        log("joinChannel success");
      } catch (e) {
        log("joinChannel failed: $e");
        rethrow;
      }
    } finally {
      _joining = false;
    }
  }

  // ------------------------------------------------
  // CLEAN TOKEN (REMOVE NEWLINES/WHITESPACE)
  // ------------------------------------------------
  String cleanToken(String token) {
    return token.replaceAll('\n', '').replaceAll('\r', '').trim();
  }

  // ------------------------------------------------
  

  // ------------------------------------------------
  // END CALL
  // ------------------------------------------------
  Future<void> endCall() async {
    try {
      AgoraCallSocketHandler.instance.emitEndCall(
        appointmentId: channelId,
      );
    } catch (_) {}

    await _cleanupEngine();
    _stopTimer();

    if (Get.currentRoute == "/AgoraDoctorCallScreen") {
      try {
        Get.back();
      } catch (_) {}
    }
  }

  // ------------------------------------------------
  // CLEANUP
  // ------------------------------------------------
  Future<void> _cleanupEngine() async {
    try {
      if (engine != null) {
        try {
          await engine!.leaveChannel();
        } catch (_) {}
        try {
          await engine!.stopPreview();
        } catch (_) {}
        try {
          await engine!.release();
        } catch (_) {}
        engine = null;
      }
      isJoined.value = false;
      isRemoteUserJoined.value = false;
      remoteUid.value = 0;
    } catch (e) {
      log("CLEANUP ERROR => $e");
    }
  }

  // ------------------------------------------------
  // TIMER
  // ------------------------------------------------
  void _startTimer() {
    _callTimer?.cancel();
    callDurationSec.value = 0;

    _callTimer = Timer.periodic(Duration(seconds: 30), (_) {
      callDurationSec.value++;
    });
  }

  void _stopTimer() {
    _callTimer?.cancel();
    _callTimer = null;
  }

  /// UI compatible method
  Future<void> joinCall({
    required String channelId,
    required String token,
  }) async {
    log("joinCall() UI Triggered");
    print("💡 joinCall() with token: $token"); // <-- Added log

    this.channelId = channelId;
    this.doctorToken = token;

    if (this.channelId.isEmpty || this.doctorToken.isEmpty) {
      Get.snackbar("Error", "Missing channel or token");
      return;
    }

    await joinDoctorAgora();
  }
  
void toggleMute() {
  isMuted.value = !isMuted.value;
  engine?.muteLocalAudioStream(isMuted.value);
}

void switchCamera() {
  engine?.switchCamera();
}

void toggleSpeaker() async {
  isSpeakerOn.value = !isSpeakerOn.value;
  await engine?.setEnableSpeakerphone(isSpeakerOn.value);
}
}
