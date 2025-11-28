import 'package:beh_doctor/views/OtpScreen.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';

class LoginController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var phone = ''.obs;
  var dialCode = '+880'.obs; 
  var isLoading = false.obs;

  var traceId = ''.obs;
  var deviceToken = ''.obs;

  // 🔹 Request OTP
 Future<void> sendOtp() async {
  if (phone.value.isEmpty) {
    Get.snackbar('Error', 'Enter phone number');
    return;
  }

  try {
    isLoading.value = true;

    // 🔹 Call API
    final res = await repo.requestOtp(
      phone: phone.value,
      dialCode: dialCode.value,
    );

    print("📌 OTP API Response: ${res.toJson()}");

    // 🔹 Check API Response
    if (res.status == "success" && res.data != null) {
      traceId.value = res.data?.traceId ?? "";

      print("📌 TRACEID Saved: ${traceId.value}");

      // 🔹 Navigate to OTP screen
      Get.to(() => OtpScreen(
            traceId: traceId.value,
            bottomNavRoute: '/bottomNav',
          ));
    } else {
      Get.snackbar("Error", res.message ?? "Unknown error");
    }
  } finally {
    isLoading.value = false;
  }
}

}
