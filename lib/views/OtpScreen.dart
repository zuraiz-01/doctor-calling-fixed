// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

// class OtpScreen extends StatelessWidget {
//   final String traceId;
//   final String bottomNavRoute;

//   OtpScreen({super.key, required this.traceId, required this.bottomNavRoute});

//   @override
//   Widget build(BuildContext context) {
//     // Controller ko yahan init kar rahe hain (permanent, single instance)
//     final OtpController controller = Get.put(OtpController(), permanent: true);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Enter OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             // OTP input field
//             TextField(
//               onChanged: (val) => controller.otpCode.value = val,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'OTP',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Verify OTP button
//             Obx(() {
//               return ElevatedButton(
//                 onPressed: controller.isOtpLoading.value
//                     ? null
//                     : () => controller.verifyOtp(
//                           traceId: traceId,
//                           bottomNavRoute: bottomNavRoute,
//                         ),
//                 child: controller.isOtpLoading.value
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : const Text("Verify OTP"),
//               );
//             }),
//             const SizedBox(height: 10),

//             // Resend OTP button with timer
//             Obx(() {
//               return TextButton(
//                 onPressed: controller.isResendEnabled.value
//                     ? () => controller.resendOtp(traceId: traceId, dialCode: '+880')
//                     : null,
//                 child: Text(
//                   controller.isResendEnabled.value
//                       ? "Resend OTP"
//                       : "Resend in ${controller.resendSeconds.value}s",
//                   style: TextStyle(
//                     color: controller.isResendEnabled.value ? Colors.blue : Colors.grey,
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

// class OtpScreen extends StatelessWidget {
//   final String traceId;
//   final String bottomNavRoute;

//   OtpScreen({super.key, required this.traceId, required this.bottomNavRoute});

//   @override
//   Widget build(BuildContext context) {
//     final OtpController controller = Get.put(OtpController(), permanent: true);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           "Verify it's you",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [

//             // 🔐 Lock Icon
//             SvgPicture.asset(
//               'assets/icons/otp_lock.svg',
//               height: 120,
//             ),

//             const SizedBox(height: 25),

//             // Instruction Text
//             const Text(
//               "An SMS with OTP has been sent to",
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 10),

//             // Phone Number
//             Text(
//               controller.fullPhoneNumber.value,
//               style: const TextStyle(
//                 color: Color(0xFF008541),
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 25),

//             // OTP Input Field
//             TextField(
//               onChanged: (val) => controller.otpCode.value = val,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 22,
//                 letterSpacing: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               decoration: InputDecoration(
//                 counterText: "",
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 18),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Resend Timer / Button
//             Obx(() {
//               return TextButton(
//                 onPressed: controller.isResendEnabled.value
//                     ? () => controller.resendOtp(
//                         traceId: traceId,
//                         dialCode: '+880',
//                       )
//                     : null,
//                 child: Text(
//                   controller.isResendEnabled.value
//                       ? "Resend OTP"
//                       : "Resend in  ${controller.resendSeconds.value}s",
//                   style: TextStyle(
//                     color: controller.isResendEnabled.value
//                         ? const Color(0xFF008541)
//                         : Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             }),

//             const SizedBox(height: 25),

//             // Verify Button
//             Obx(() {
//               return SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: controller.isOtpLoading.value
//                       ? null
//                       : () => controller.verifyOtp(
//                             traceId: traceId,
//                             bottomNavRoute: bottomNavRoute,
//                           ),

//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF008541),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),

//                   child: controller.isOtpLoading.value
//                       ? const SizedBox(
//                           width: 22,
//                           height: 22,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                       : const Text(
//                           "Verify",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

class OtpScreen extends StatelessWidget {
  final String traceId;
  final String bottomNavRoute;

  OtpScreen({super.key, required this.traceId, required this.bottomNavRoute});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter the 6-digit OTP sent to your number",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // OTP TextField
            TextField(
              onChanged: (val) => controller.otpCode.value = val,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: "OTP Code",
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Verify Button
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isOtpLoading.value
                      ? null
                      : () => controller.verifyOtp(
                            traceId: traceId,
                            bottomNavRoute: bottomNavRoute,
                          ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.isOtpLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Verify OTP"),
                ),
              );
            }),

            const SizedBox(height: 10),

            // Resend OTP Button
            Center(
              child: Obx(() {
                return TextButton(
                  onPressed: controller.isResendEnabled.value
                      ? () => controller.resendOtp(
                            traceId: traceId,
                            dialCode: "+880",
                          )
                      : null,
                  child: Text(
                    controller.isResendEnabled.value
                        ? "Resend OTP"
                        : "Resend in ${controller.resendSeconds.value}s",
                    style: TextStyle(
                      fontSize: 15,
                      color: controller.isResendEnabled.value
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
