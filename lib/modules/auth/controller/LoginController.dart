
import 'package:beh_doctor/views/OtpScreen.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';


class LoginController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var phone = ''.obs;
  var dialCode = '+880'.obs; // fixed country code
  var traceId = ''.obs;
  var isLoading = false.obs;

  // 🔹 Request OTP
  Future<void> sendOtp() async {
    if (phone.value.isEmpty) {
      Get.snackbar('Error', 'Enter phone number');
      return;
    }

    try {
      isLoading.value = true;

      final result = await repo.requestOtp(
        phone: phone.value,
        dialCode: dialCode.value,
      );

      if (result.status == 'success' && result.data != null) {
        traceId.value = result.data?.traceId ?? '';
        print("📌 TRACEID: ${traceId.value}");

        // Navigate to OTP screen
        Get.to(() => OtpScreen(
              traceId: traceId.value,
              bottomNavRoute: '/bottomNav', // pass your bottom nav route here
            ));
      } else {
        Get.snackbar('Error', result.message ?? 'Failed to request OTP');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
