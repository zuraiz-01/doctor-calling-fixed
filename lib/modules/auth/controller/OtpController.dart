// import 'dart:async';
// import 'package:beh_doctor/models/VerifyOtpModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:get/get.dart';

// class OtpController extends GetxController {
//   final AuthRepo repo = AuthRepo();

//   // Observables
//   RxString otpCode = ''.obs;
//   RxBool isLoading = false.obs;
//   RxBool canResend = false.obs;
//   RxInt timer = 30.obs;

//   // Required data
//   late String traceId;
//   late String deviceToken;

//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();

//     final args = Get.arguments;

//     // Receive traceId and deviceToken safely
//     if (args is Map<String, dynamic>) {
//       traceId = args["traceId"] ?? "";
//       deviceToken = args["deviceToken"] ?? "";
//     } else {
//       traceId = "";
//       deviceToken = "";
//     }

//     print("OtpController Init => traceId: $traceId, deviceToken: $deviceToken");

//     startTimer();
//   }

//   // Timer for resend
//   void startTimer() {
//     canResend.value = false;
//     timer.value = 30;

//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (timer.value == 0) {
//         canResend.value = true;
//         t.cancel();
//       } else {
//         timer.value--;
//       }
//     });
//   }

//   // Verify OTP
//   Future<bool> verifyOtp() async {
//     if (otpCode.value.length != 6) {
//       Get.snackbar("Error", "Enter 6-digit OTP");
//       return false;
//     }

//     try {
//       isLoading.value = true;

//       final model = VerifyOtpModel(
//         traceId: traceId,
//         code: otpCode.value,
//         deviceToken: deviceToken,
//       );

//       final response = await repo.verifyOtp(model);

//       isLoading.value = false;

//       if (response.status == 'success' && response.data?.token != null) {
//         print("Token: ${response.data?.token}, isNewUser: ${response.data?.isNewUser}");
//         return true;
//       } else {
//         Get.snackbar("Error", response.message ?? "Invalid OTP");
//         return false;
//       }
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar("Error", "OTP verification failed");
//       return false;
//     }
//   }

//   // Resend OTP
//   Future<void> resendOtp() async {
//     if (!canResend.value) return;

//     try {
//       canResend.value = false;
//       startTimer();

//       await repo.resendOtp(traceId, deviceToken);
//       Get.snackbar("Success", "OTP resent successfully");
//     } catch (e) {
//       Get.snackbar("Error", "Failed to resend OTP");
//     }
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }
// import 'package:get/get.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';

// class OtpController extends GetxController {
//   final AuthRepo repo = AuthRepo();

//   var otpCode = ''.obs;
//   var isOtpLoading = false.obs;

//   // 🔹 Verify OTP
//   Future<void> verifyOtp({
//     required String traceId,
//     required String bottomNavRoute,
//   }) async {
//     if (otpCode.value.isEmpty) {
//       Get.snackbar('Error', 'Enter OTP');
//       return;
//     }

//     try {
//       isOtpLoading.value = true;

//       // Device token generate karna yahan (example random)
//       final deviceToken = DateTime.now().millisecondsSinceEpoch.toString();

//       final result = await repo.verifyOtp(
//         traceId: traceId,
//         otpCode: otpCode.value,
//         deviceToken: deviceToken,
//       );

//       if (result.status == 'success' && result.data != null) {
//         print("✅ OTP verified successfully");
//         print("📌 Generated Device Token: ${result.data?.token}");
//         Get.offAllNamed(bottomNavRoute); // Navigate to main screen
//       } else {
//         Get.snackbar('Error', result.message ?? 'OTP verification failed');
//       }
//     } finally {
//       isOtpLoading.value = false;
//     }
//   }
// }
// import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var otpCode = ''.obs;
  var isOtpLoading = false.obs;

  var isResendEnabled = false.obs;
  var resendSeconds = 30.obs;
  Timer? _resendTimer;

  /// 🔹 Verify OTP and save user token
  Future<void> verifyOtp({
    required String traceId,
    required String bottomNavRoute,
  }) async {
    if (otpCode.value.isEmpty) {
      Get.snackbar('Error', 'Enter OTP');
      return;
    }

    try {
      isOtpLoading.value = true;

      // Device token generate karna (unique per device/session)
      final deviceToken = DateTime.now().millisecondsSinceEpoch.toString();

      final result = await repo.verifyOtp(
        traceId: traceId,
        otpCode: otpCode.value,
        deviceToken: deviceToken,
      );

      if (result.status == 'success' && result.data != null && result.data!.token != null) {
        // Save user token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', result.data!.token!);

        Get.snackbar('Success', 'OTP verified and token saved!');
        Get.offAllNamed(bottomNavRoute); // Navigate to main screen
      } else {
        Get.snackbar('Error', result.message ?? 'OTP verification failed');
      }
    } finally {
      isOtpLoading.value = false;
    }
  }

  /// 🔹 Resend OTP
  Future<void> resendOtp({
    required String traceId,
    required String dialCode,
  }) async {
    if (!isResendEnabled.value) return;

    try {
      await repo.resendOtp(traceId: traceId, dialCode: dialCode);
      Get.snackbar('OTP', 'OTP resent successfully');
      startResendTimer();
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP');
    }
  }

  /// 🔹 Start resend OTP timer
  void startResendTimer() {
    isResendEnabled.value = false;
    resendSeconds.value = 30;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  /// 🔹 Helper to get saved user token anywhere
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
