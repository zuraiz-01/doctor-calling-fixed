// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

// import 'package:beh_doctor/views/PrescriptionScreen.dart';
// import 'package:beh_doctor/views/TestResultScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PatientInfoScreen extends StatelessWidget {
//   final Appointment appointment;
// final AgoraCallController agoraCallController = Get.put(AgoraCallController());
// // final controller = Get.find<AgoraCallController>();

//    PatientInfoScreen({super.key, required this.appointment});

//   @override
//   Widget build(BuildContext context) {
//     final patient = appointment.patient;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         title: const Text(
//           "Patient Information",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // ---------------------- Patient Info ----------------------
//             const Text(
//               "Patient Info",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),

//             const SizedBox(height: 8),

//             // Container(
//             //   padding: const EdgeInsets.all(16),
//             //   decoration: BoxDecoration(
//             //     color: Colors.grey.shade100,
//             //     borderRadius: BorderRadius.circular(14),
//             //     boxShadow: [
//             //       BoxShadow(
//             //         color: Colors.black12,
//             //         blurRadius: 4,
//             //         offset: const Offset(0, 2),
//             //       ),
//             //     ],
//             //   ),
//             //   child: Row(
//             //     children: [
//             //       CircleAvatar(
//             //         radius: 30,
//             //         backgroundImage: patient?.photo != null
//             //             ? NetworkImage(patient!.photo!)
//             //             : null,
//             //         child: patient?.photo == null
//             //             ? const Icon(Icons.person, size: 32)
//             //             : null,
//             //       ),

//             //       const SizedBox(width: 12),

//             //       Column(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           Text(
//             //             patient?.name ?? "Unknown",
//             //             style: const TextStyle(
//             //               fontWeight: FontWeight.w600,
//             //               fontSize: 17,
//             //             ),
//             //           ),
//             //           const SizedBox(height: 4),
//             //           Text(
//             //             "${patient?.gender ?? ''} | ${appointment.age ?? ''} Years | ${appointment.weight ?? ''} KG",
//             //             style: const TextStyle(
//             //               fontSize: 13,
//             //               color: Colors.black54,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             // ),

// Container(
//   padding: const EdgeInsets.all(16),
//   decoration: BoxDecoration(
//     color: Colors.grey.shade100,
//     borderRadius: BorderRadius.circular(14),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black12,
//         blurRadius: 4,
//         offset: Offset(0, 2),
//       ),
//     ],
//   ),
//   child: Row(
//     children: [
//       Builder(
//         builder: (_) {
//           String? photo = patient?.photo;

//           // --- FINAL CORRECT URL ---
//           String? imageUrl = (photo != null && photo.isNotEmpty)
//               ? (photo.startsWith("http")
//                     ? photo
//                     : "${ApiConstants.imageBaseUrl}$photo")
//               : null;

//           return CircleAvatar(
//             radius: 30,
//             backgroundImage:
//                 imageUrl != null ? NetworkImage(imageUrl) : null,
//             child: imageUrl == null
//                 ? const Icon(Icons.person, size: 32)
//                 : null,
//           );
//         },
//       ),

//       const SizedBox(width: 12),

//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             patient?.name ?? "Unknown",
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "${patient?.gender ?? ''} | ${appointment.age ?? ''} Years | ${appointment.weight ?? ''} KG",
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),

//             const SizedBox(height: 20),

//             // ---------------------- Patient Records ----------------------
//             const Text(
//               "Patient Records",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: _recordButton(
//                     title: "Previous Prescriptions",
//                     icon: Icons.arrow_forward_ios,
//                     onTap: () {
//                       Get.to(
//                         () => PrescriptionListScreen(
//                           patientId: patient?.id ?? "",
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: _recordButton(
//                     title: "Test Results",
//                     icon: Icons.arrow_forward_ios,
//                 onTap: () {
//   Get.to(() => TestResultScreen(
//     appointmentId: appointment.id ?? "",
//     appointment: appointment,
//   ));
// },

//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 25),

//             // ---------------------- Appointment Reason Box ----------------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: Colors.green.shade200, width: 1),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Appointment Reason",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   Text(
//                     appointment.reason ?? "No reason provided",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Text(
//                     appointment.description ?? "No description provided",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             // ---------------------- Additional Attachments ----------------------
//             const Text(
//               "Additional Attachments",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),

//             const SizedBox(height: 12),

//             appointment.additionalFiles != null &&
//                     appointment.additionalFiles!.isNotEmpty
//                 ? Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: appointment.additionalFiles!.map((filePath) {
//                       final fullUrl = "${ApiConstants.imageBaseUrl}$filePath";

//                       return Container(
//                         width: 105,
//                         height: 105,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14),
//                           color: Colors.grey.shade200,
//                           image: DecorationImage(
//                             image: NetworkImage(fullUrl),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   )
//                 : Container(
//                     height: 120,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "No attachments found",
//                         style: TextStyle(color: Colors.black45),
//                       ),
//                     ),
//                   ),

//             const SizedBox(height: 30),

//             // ---------------------- CALL NOW BUTTON ----------------------

// // ---------------------- CALL NOW BUTTON ----------------------

// // ---------------------- CALL NOW BUTTON ----------------------
// ElevatedButton(
//   onPressed: () {
//     final controller = Get.find<AgoraCallController>();
//     controller.setAppointment(appointment);
//     controller.callNow();
//   },
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.green,
//     padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//   ),
//   child: Text(
//     "Call Now",
//     style: TextStyle(fontSize: 16, color: Colors.white),
//   ),
// ),

// // InkWell(
// //   onTap: () async {
// //     print("==== CALL NOW BUTTON PRESSED ====");
// //     print("Appointment ID: ${agoraCallController.appointmentId.value}");
// //     print("Calling controller.callNow() ...");

// //     // Appointment set karo
// //     agoraCallController.setAppointment(appointment);

// //     await agoraCallController.callNow();

// //     print("CALL NOW Completed.");
// //     print("Channel ID after callNow: ${agoraCallController.channelId.value}");
// //     print("Doctor Token after callNow: ${agoraCallController.doctorToken.value}");
// //     print("Is Caller Loading: ${agoraCallController.isCallerLoading.value}");
// //     print("==================================");

// //     // OPTIONAL: Call screen open
// //     Get.to(() => AgoraCallScreen());
// //   },
// //   child: Container(
// //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //     decoration: BoxDecoration(
// //       color: Colors.green,
// //       borderRadius: BorderRadius.circular(10),
// //     ),
// //     child: Text(
// //       "Call Now",
// //       style: TextStyle(color: Colors.white, fontSize: 16),
// //     ),
// //   ),

// // )

// // SizedBox(
// //   width: double.infinity,
// //   height: 52,
// //   child: GestureDetector(
// //     onTap: () async {
// // //  final apptController = Get.find<AppointmentDetailsController>();
// // // AppointmentDetailsData? appt = apptController.appointmentDetails.value;

// // // if (appt == null) {
// // //   Get.snackbar("Error", "Appointment details not loaded");
// // //   return;
// // // }

// // // String doctorToken = appt.appointment?.doctorAgoraToken ?? "";
// // // String channelId = appt.appointment?.channelId ?? "";
// // // String appointmentId = appt.appointment?.id ?? "";

// // //       if (doctorToken.isEmpty) {
// // //         Get.snackbar("Error", "Doctor token not available");
// // //         return;
// // //       }

// // //       final agora = Get.put(AgoraCallController());

// // //       await agora.initAgora(
// // //         token: doctorToken,
// // //         channelId: channelId,
// // //         uid: 1, // Doctor UID
// // //       );

// // //       Get.to(() => AgoraDoctorCallScreen());
// // //     },
// //     },
// //     child: Container(
// //       height: 55,
// //       color: Colors.green,
// //       child: const Center(
// //         child: Text(
// //           "Call Now",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ),
// //     ),
// //   ),
// // ),

//             const SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------------- Custom Record Button ----------------------
//   Widget _recordButton({
//     required String title,
//     required IconData icon,
//     required Function() onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: Colors.green.shade300, width: 1),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.green.shade100.withOpacity(0.4),
//               blurRadius: 6,
//               spreadRadius: 1,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Icon(icon, size: 16, color: Colors.black54),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';

// or where ApiRepo is defined

import 'package:beh_doctor/views/AgoraDoctorCallScreen.dart';

import 'package:beh_doctor/views/PrescriptionScreen.dart';
import 'package:beh_doctor/views/TestResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/shareprefs.dart';

class PatientInfoScreen extends StatelessWidget {
  final Appointment appointment;
  final AgoraCallController agoraCallController = Get.put(
    AgoraCallController(),
  );

  PatientInfoScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final patient = appointment.patient;

    // Final Correct Image URL
    String? imageUrl = (patient?.photo != null && patient!.photo!.isNotEmpty)
        ? (patient.photo!.startsWith("http")
              ? patient.photo!
              : "${ApiConstants.imageBaseUrl}${patient.photo}")
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Patient Information",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------- PATIENT INFO TITLE ----------------------
            const Text(
              "Patient Info",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // ---------------------- TOP CARD (Small Like Screenshot) ----------------------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 33,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl == null
                        ? const Icon(Icons.person, size: 32)
                        : null,
                  ),
                  const SizedBox(width: 14),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient?.name ?? "Unknown",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${patient?.gender ?? ''} • ${appointment.age ?? ''} Years • ${appointment.weight ?? ''} KG",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------------- PATIENT RECORDS ----------------------
            // ---------------------- PATIENT RECORDS ----------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Patient Records",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _recordBox(
                          title: "Previous\nPrescriptions",
                          onTap: () {
                            Get.to(
                              () => PrescriptionListScreen(
                                patientId: patient?.id ?? "",
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _recordBox(
                          title: "Test\nResults",
                          onTap: () {
                            Get.to(
                              () => TestResultScreen(
                                appointmentId: appointment.id ?? "",
                                appointment: appointment,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- REASON BOX (Same Rounded Box) ----------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Appointment Reason",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    appointment.reason ?? "No reason provided",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    appointment.description ?? "No description provided",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------------- ATTACHMENTS ----------------------
            const Text(
              "Additional Attachments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            appointment.additionalFiles != null &&
                    appointment.additionalFiles!.isNotEmpty
                ? Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: appointment.additionalFiles!.map((filePath) {
                      String fullUrl = "${ApiConstants.imageBaseUrl}$filePath";
                      return Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            image: NetworkImage(fullUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(
                      child: Text(
                        "No attachments found",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),

            const SizedBox(height: 30),

            // ---------------------- CALL NOW BUTTON ----------------------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final controller = Get.put(AgoraCallController());

                  await SharedPrefs.saveAgoraChannelId(appointment.id ?? "");
                  await SharedPrefs.saveDoctorAgoraToken(
                    appointment.doctorAgoraToken ?? "",
                  );

                  controller.setAppointment(appointment);

                  await controller.callNow();

                  // Get.toNamed(Routes.AgoraDoctorCallScreen);

                  print("APPOINTMENT lodoo DEBUG ---> ${appointment.toMap()}");

                  // ❌ DO NOT Navigate manually
                  // callNow() already sends user to call screen
                },
                child: const Text("Call Now"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------------- RECORD BOX WIDGET ----------------------
  Widget _recordBox({required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade100.withOpacity(0.25), // very soft
              blurRadius: 3, // 🔥 small blur
              spreadRadius: 0.5, // small spread
              offset: Offset(0, 1), // small downward shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
