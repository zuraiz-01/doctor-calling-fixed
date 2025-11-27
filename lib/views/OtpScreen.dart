

import 'package:flutter/material.dart' show Text, TextButton, SizedBox, Colors, CircularProgressIndicator, BuildContext, Scaffold, AppBar, TextField, InputDecoration, OutlineInputBorder, ElevatedButton;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

class OtpScreen extends StatelessWidget {
  final OtpController controller = Get.put(OtpController());

  final String traceId;
  final String bottomNavRoute;

  OtpScreen({super.key, required this.traceId, required this.bottomNavRoute});

  @override
  Widget build(BuildContext context) {
    // Constructor variables ko local me assign kar rahe hain
    final String _traceId = traceId;
    final String _bottomNavRoute = bottomNavRoute;

    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => controller.otpCode.value = val,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isOtpLoading.value
                    ? null
                    : () => controller.verifyOtp(
                          traceId: _traceId,
                          bottomNavRoute: _bottomNavRoute,
                        ),
                child: controller.isOtpLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text("Verify OTP"),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextButton(
                onPressed: controller.isResendEnabled.value
                    ? () => controller.resendOtp(traceId: _traceId, dialCode: '+880')
                    : null,
                child: Text(
                  controller.isResendEnabled.value
                      ? "Resend OTP"
                      : "Resend in ${controller.resendSeconds.value}s",
                  style: TextStyle(color: controller.isResendEnabled.value ? Colors.blue : Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
