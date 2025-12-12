
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

// class AgoraDoctorCallScreen extends StatelessWidget {
//   final String channelId;
//   final String token;

//   AgoraDoctorCallScreen({
//     super.key,
//     required this.channelId,
//     required this.token,
//   });

// final AgoraCallController controller = Get.put(AgoraCallController());


//   @override
//   Widget build(BuildContext context) {
//     // Join call when screen opens
//     // controller.joinCall(channelId: channelId, token: token);

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Obx(() {
//           return Stack(
//             children: [
//               // -------------------------------
//               // 📌 REMOTE VIDEO (PATIENT)
//               // -------------------------------
//               Positioned.fill(
//                 child: controller.isRemoteUserJoined.value
//                     ? AgoraVideoView(
//                         controller: VideoViewController.remote(
//                           rtcEngine: controller.engine!,
//                           canvas: VideoCanvas(
//                             uid: controller.remoteUid.value, // AUTO remote uid
//                           ),
//                           connection: RtcConnection(
//                             channelId: channelId,
//                           ),
//                         ),
//                       )
//                     : Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(color: Colors.white),
//                             SizedBox(height: 10),
//                             Text(
//                               "Waiting for patient to join...",
//                               style: TextStyle(color: Colors.white70, fontSize: 16),
//                             )
//                           ],
//                         ),
//                       ),
//               ),

//               // -------------------------------
//               // 📌 LOCAL DOCTOR PREVIEW (SMALL)
//               // -------------------------------
//               Positioned(
//                 right: 16,
//                 top: 16,
//                 child: Container(
//                   width: 120,
//                   height: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.white12),
//                   ),
//                   child: controller.isJoined.value
//                       ? AgoraVideoView(
//                           controller: VideoViewController(
//                             rtcEngine: controller.engine!,
//                             canvas: const VideoCanvas(uid: 0),
//                           ),
//                         )
//                       : Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         ),
//                 ),
//               ),

//               // -------------------------------
//               // 📌 END CALL BUTTON
//               // -------------------------------
//               Positioned(
//                 bottom: 40,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     FloatingActionButton(
//                       backgroundColor: Colors.red,
//                       child: Icon(Icons.call_end),
//                       onPressed: () => controller.endCall(),
//                     ),
//                   ],
//                 ),
//               ),

//               // -------------------------------
//               // 📌 TIMER (TOP CENTER)
//               // -------------------------------
//               Positioned(
//                 top: 20,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: Colors.white12,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Obx(() {
//                       final sec = controller.callDurationSec.value;
//                       final m = (sec ~/ 60).toString().padLeft(2, '0');
//                       final s = (sec % 60).toString().padLeft(2, '0');

//                       return Text(
//                         "$m:$s",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

// kaaammm ka ka hey
// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

// class AgoraDoctorCallScreen extends StatelessWidget {
//   AgoraDoctorCallScreen({Key? key}) : super(key: key);

//   AgoraCallController get controller => Get.find<AgoraCallController>();

//   @override
//   Widget build(BuildContext context) {
//     final appt = controller.currentAppointment;

//     if (appt == null) {
//       return Scaffold(
//         body: Center(child: Text("No appointment found")),
//       );
//     }

//     final String? imageUrl = (appt.patient?.photo != null &&
//             appt.patient!.photo!.isNotEmpty)
//         ? "${ApiConstants.imageBaseUrl}${appt.patient!.photo}"
//         : null;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Obx(() {
//           return Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 40),

//                   /// CALL STATUS
//                   Text(
//                     controller.isRemoteUserJoined.value
//                         ? "Connected"
//                         : "Calling...",
//                     style: TextStyle(fontSize: 20, color: Colors.grey),
//                   ),

//                   SizedBox(height: 10),

//                   /// PATIENT NAME
//                   Text(
//                     appt.patient?.name ?? "Unknown",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   SizedBox(height: 40),

//                   /// PATIENT IMAGE
//                   Container(
//                     width: 170,
//                     height: 170,
//                     padding: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.green, width: 4),
//                     ),
//                     child: ClipOval(
//                       child: imageUrl != null
//                           ? Image.network(imageUrl, fit: BoxFit.cover)
//                           : Icon(Icons.person, size: 80),
//                     ),
//                   ),

//                   SizedBox(height: 80),

//                   /// END CALL BUTTON
//                   CircleAvatar(
//                     radius: 32,
//                     backgroundColor: Colors.red,
//                     child: IconButton(
//                       icon: Icon(Icons.call_end, color: Colors.white),
//                       onPressed: () => controller.endCall(),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
// newwithcmra
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/views/CallsOptionBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class AgoraDoctorCallScreen extends StatelessWidget {
  AgoraDoctorCallScreen({Key? key}) : super(key: key);

  AgoraCallController get controller => Get.find<AgoraCallController>();

  @override
  Widget build(BuildContext context) {
    final appt = controller.currentAppointment;

    if (appt == null) {
      return Scaffold(
        body: Center(child: Text("No appointment found")),
      );
    }

    final String? imageUrl = (appt.patient?.photo != null &&
            appt.patient!.photo!.isNotEmpty)
        ? "${ApiConstants.imageBaseUrl}${appt.patient!.photo}"
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),

                  Text(
                    controller.isRemoteUserJoined.value
                        ? "Connected"
                        : "Calling...",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),

                  SizedBox(height: 10),

                  Text(
                    appt.patient?.name ?? "Unknown",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  /// Patient video round circle
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 4),
                    ),
                    child: ClipOval(
                      child: controller.isRemoteUserJoined.value
                          ? AgoraVideoView(
                              controller: VideoViewController.remote(
                                rtcEngine: controller.engine!,
                                canvas: VideoCanvas(
                                  uid: controller.remoteUid.value,
                                ),
                                connection: RtcConnection(
                                  channelId: controller.channelId,
                                ),
                              ),
                            )
                          : (imageUrl != null
                              ? Image.network(imageUrl, fit: BoxFit.cover)
                              : Icon(Icons.person, size: 80)),
                    ),
                  ),

                  SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: controller.isMuted.value
                            ? Colors.red
                            : Colors.grey.shade300,
                        child: IconButton(
                          icon: Icon(
                            controller.isMuted.value
                                ? Icons.mic_off
                                : Icons.mic,
                            color: Colors.white,
                          ),
                          onPressed: () => controller.toggleMute(),
                        ),
                      ),

                      SizedBox(width: 25),

                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: Icon(Icons.cameraswitch, color: Colors.white),
                          onPressed: () => controller.switchCamera(),
                        ),
                      ),

                      SizedBox(width: 25),

                      CircleAvatar(
                        radius: 28,
                        backgroundColor: controller.isSpeakerOn.value
                            ? Colors.green
                            : Colors.grey.shade300,
                        child: IconButton(
                          icon: Icon(
                            controller.isSpeakerOn.value
                                ? Icons.volume_up
                                : Icons.hearing,
                            color: Colors.white,
                          ),
                          onPressed: () => controller.toggleSpeaker(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: Icon(Icons.call_end, color: Colors.white),
                      onPressed: () => controller.endCall(),
                    ),
                  ),
                ],
              ),

              /// 🔵 Bottom Sheet Button
              Positioned(
                bottom: 120,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      CallOptionsBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 80),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Open Options",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}


//  follor krna essy
// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class AgoraDoctorCallScreen extends StatelessWidget {
//   late final String channelId;
//   late final String token;
//   late final Appointment appointment;

//   AgoraCallController get controller => Get.find<AgoraCallController>();

//   AgoraDoctorCallScreen({super.key, required String channelId, required String token, required Appointment appointment}) {
//     final args = Get.arguments;

//     channelId = args['channelId'];
//     token = args['token'];
//     appointment = args['appointment'];
//   }

//   // --------------------------
//   // BOTTOM SHEET
//   // --------------------------
//   void _showPatientBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade400,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Patient Details",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               Text("Name: ${appointment.patient?.name ?? "Unknown"}"),
//               const SizedBox(height: 10),
//               Text("Gender: ${appointment.patient?.gender ?? "N/A"}"),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Set appointment **after UI builds**
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.setAppointment(appointment);
//     });

//     print("appointment data agya => ${appointment.toMap()}");

//     final String? imageUrl = (appointment.patient?.photo != null &&
//             appointment.patient!.photo!.isNotEmpty)
//         ? "${ApiConstants.imageBaseUrl}${appointment.patient!.photo}"
//         : null;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Obx(() {
//           return Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 40),

//                   Text(
//                     controller.isRemoteUserJoined.value
//                         ? "Connected"
//                         : "Calling...",
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Colors.grey,
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   Text(
//                     appointment.patient?.name ?? "Unknown",
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   Container(
//                     width: 170,
//                     height: 170,
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.green, width: 4),
//                     ),
//                     child: ClipOval(
//                       child: imageUrl != null
//                           ? Image.network(imageUrl, fit: BoxFit.cover)
//                           : const Icon(Icons.person, size: 80),
//                     ),
//                   ),

//                   const SizedBox(height: 80),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () => _showPatientBottomSheet(context),
//                         child: CircleAvatar(
//                           radius: 28,
//                           backgroundColor: Colors.green.shade100,
//                           child: const Icon(Icons.article, color: Colors.green),
//                         ),
//                       ),
//                       CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.green.shade100,
//                         child:
//                             const Icon(Icons.volume_up, color: Colors.green),
//                       ),
//                       CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.green.shade100,
//                         child: const Icon(Icons.cameraswitch,
//                             color: Colors.green),
//                       ),
//                       CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.green.shade100,
//                         child: const Icon(Icons.mic, color: Colors.green),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 40),

//                   CircleAvatar(
//                     radius: 32,
//                     backgroundColor: Colors.red,
//                     child: IconButton(
//                       icon:
//                           const Icon(Icons.call_end, color: Colors.white),
//                       onPressed: () => controller.endCall(),
//                     ),
//                   ),
//                 ],
//               ),

//               Positioned(
//                 top: 20,
//                 left: 0,
//                 right: 0,
//                 child: Obx(() {
//                   final sec = controller.callDurationSec.value;
//                   final m = (sec ~/ 60).toString().padLeft(2, '0');
//                   final s = (sec % 60).toString().padLeft(2, '0');

//                   return controller.isRemoteUserJoined.value
//                       ? Text(
//                           "$m:$s",
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             color: Colors.green,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         )
//                       : const SizedBox();
//                 }),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
