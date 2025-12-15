
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
    print("💡 Doctor Token set: $doctorToken"); 
    print("currentAppointment${appt}");
    print("channlid milgya${channelId}");
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

    print("💡 callNow() - Doctor Token: $doctorToken");

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

    // 3 - Join Agora
    try {
      await joinDoctorAgora();
    } catch (e) {
      log("joinDoctorAgora threw: $e");
      Get.snackbar("Error", "Unable to start Agora. ${e.toString()}");
      await _cleanupEngine();
      return;
    }

    // 4 - Wait for join success
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

Future<void> joinDoctorAgora() async {
  print("🔵 joinDoctorAgora() CALLED");

  if (channelId.isEmpty || doctorToken.isEmpty) {
    print("❌ channelId or token EMPTY");
    Get.snackbar("Error", "Agora token or channel missing");
    return;
  }

  if (_joining) {
    print("⚠️ Already joining, ignored");
    return;
  }

  _joining = true;

  try {
    // ---------------- ENGINE INIT ----------------
    try {
      print("🟡 Creating Agora Engine");
      if (engine == null) {
        engine = createAgoraRtcEngine();
        await engine!.initialize(
          const RtcEngineContext(
            appId: "0fb1a1ecf5a34db2b51d9896c994652a",
          ),
        );
        print("✅ AGORA ENGINE INITIALIZED");
      } else {
        print("ℹ️ Engine already exists");
      }
    } catch (e, st) {
      print("❌ ENGINE INIT FAILED: $e");
      print(st);
      rethrow;
    }

    // ---------------- EVENT HANDLER ----------------
    try {
      print("🟡 Registering Event Handler");
      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (connection, elapsed) {
            print("✅ DOCTOR JOINED CHANNEL");
             print("✅ DOCTOR JOINED CHANNEL");
  print("🆔 LOCAL UID (Doctor) => ${connection.localUid}");
            isJoined.value = true;
          },
          onUserJoined: (connection, uid, elapsed) {
            print("👤 PATIENT JOINED UID => $uid");
            remoteUid.value = uid;
            isRemoteUserJoined.value = true;
          },
          onUserOffline: (connection, uid, reason) {
            print("❌ PATIENT LEFT => $reason");
            isRemoteUserJoined.value = false;
            endCall();
          },
          onError: (code, msg) {
            print("🔥 AGORA ERROR => $code | $msg");
          },
        ),
      );
      print("✅ Event Handler Registered");
    } catch (e, st) {
      print("❌ EVENT HANDLER ERROR: $e");
      print(st);
    }

    // ---------------- VIDEO / AUDIO ----------------
  // ---------------- VIDEO / AUDIO ----------------

try {
  print("🟡 Enabling Video");
  await engine!.enableVideo();
  print("✅ enableVideo DONE");
} catch (e, st) {
  print("❌ enableVideo ERROR: $e");
  print(st);
}

try {
  print("🟡 Enabling Audio");
  await engine!.enableAudio();
  print("✅ enableAudio DONE");
} catch (e, st) {
  print("❌ enableAudio ERROR: $e");
  print(st);
}

try {
  print("🟡 Enabling Local Video");
  await engine!.enableLocalVideo(true);
  print("✅ enableLocalVideo DONE");
} catch (e, st) {
  print("❌ enableLocalVideo ERROR: $e");
  print(st);
}

try {
  print("🟡 Unmute Local Video");
  await engine!.muteLocalVideoStream(false);
  print("✅ muteLocalVideoStream(false) DONE");
} catch (e, st) {
  print("❌ muteLocalVideoStream ERROR: $e");
  print(st);
}


    // ---------------- ROLE ----------------
    try {
      print("🟡 Setting Client Role = BROADCASTER");
      await engine!.setClientRole(
        role: ClientRoleType.clientRoleBroadcaster,
      );
      print("✅ Client Role Set");
    } catch (e, st) {
      print("❌ ROLE SET ERROR: $e");
      print(st);
    }

    // ---------------- LOCAL VIDEO SETUP ----------------
    try {
      print("🟡 setupLocalVideo()");
      await engine!.setupLocalVideo(
        const VideoCanvas(
          uid: 0,
          sourceType: VideoSourceType.videoSourceCamera,
        ),
      );
      print("✅ setupLocalVideo DONE");
    } catch (e, st) {
      print("❌ setupLocalVideo ERROR: $e");
      print(st);
    }

    // ---------------- PREVIEW ----------------
    try {
      print("🟡 startPreview()");
      await engine!.startPreview();
      print("✅ Preview Started");
    } catch (e, st) {
      print("❌ startPreview ERROR: $e");
      print(st);
    }

    // ---------------- JOIN CHANNEL ----------------
    try {
      print("🟡 joinChannel()");
      print("➡️ channelId: $channelId");
      print("➡️ token length: ${doctorToken.length}");

      await engine!.joinChannel(
        token: doctorToken,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );

      print("✅ joinChannel API CALLED");
    } catch (e, st) {
      print("❌ joinChannel ERROR: $e");
      print(st);
    }

  } catch (e, st) {
    print("🔥 FATAL ERROR joinDoctorAgora: $e");
    print(st);
  } finally {
    _joining = false;
    print("🔵 joinDoctorAgora() FINISHED");
  }
}


  // ------------------------------------------------
  // CLEAN TOKEN
  // ------------------------------------------------
  String cleanToken(String token) {
    return token.replaceAll('\n', '').replaceAll('\r', '').trim();
  }

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
    print("💡 joinCall() with token: $token");

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
