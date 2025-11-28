import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

class OtpScreen extends StatelessWidget {
  final String traceId;
  final String bottomNavRoute;

  OtpScreen({super.key, required this.traceId, required this.bottomNavRoute});

  @override
  Widget build(BuildContext context) {
    // Controller ko yahan init kar rahe hain (permanent, single instance)
    final OtpController controller = Get.put(OtpController(), permanent: true);

    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // OTP input field
            TextField(
              onChanged: (val) => controller.otpCode.value = val,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Verify OTP button
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isOtpLoading.value
                    ? null
                    : () => controller.verifyOtp(
                          traceId: traceId,
                          bottomNavRoute: bottomNavRoute,
                        ),
                child: controller.isOtpLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Verify OTP"),
              );
            }),
            const SizedBox(height: 10),

            // Resend OTP button with timer
            Obx(() {
              return TextButton(
                onPressed: controller.isResendEnabled.value
                    ? () => controller.resendOtp(traceId: traceId, dialCode: '+880')
                    : null,
                child: Text(
                  controller.isResendEnabled.value
                      ? "Resend OTP"
                      : "Resend in ${controller.resendSeconds.value}s",
                  style: TextStyle(
                    color: controller.isResendEnabled.value ? Colors.blue : Colors.grey,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
