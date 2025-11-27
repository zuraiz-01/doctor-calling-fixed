// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/models/VerifyOtpModel.dart';

// import 'package:dio/dio.dart';

// class AuthRepo {
//   final Dio _dio = Dio();

//   // Request OTP
//   Future<Map<String, dynamic>> requestOtp(String dialCode, String phone) async {
//     final response = await _dio.post(ApiConstants.doctorRequestOtp, data: {
//       "dialCode": dialCode,
//       "phone": phone,
//     });
//     print("requestOtp Response: ${response.data}");
//     return response.data;
//   }

//   // Verify OTP using model
//   Future<VerifyOtpResponse> verifyOtp(VerifyOtpModel model) async {
//     try {
//       final response = await _dio.post(
//         ApiConstants.doctorVerifyOtp,
//         data: model.toMap(),
//         options: Options(
//           validateStatus: (status) => status! < 500, // handle 422 without throwing
//         ),
//       );
//       print("verifyOtp Response: ${response.data}");
//       return VerifyOtpResponse.fromMap(response.data);
//     } catch (e) {
//       print("verifyOtp Exception: $e");
//       rethrow;
//     }
//   }

//   // Resend OTP
//   Future<void> resendOtp(String traceId, String deviceToken) async {
//     final response = await _dio.post(
//       ApiConstants.resendOtp,
//       data: {"traceId": traceId, "deviceToken": deviceToken},
//     );
//     print("resendOtp Response: ${response.data}");
//   }
// }
import 'dart:developer';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/apiconstant/apiservice.dart';
import 'package:beh_doctor/models/VerifyOtpModel.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  // 🔹 Request OTP
  Future<VerifyOtpApiResponse> requestOtp({
    required String phone,
    required String dialCode,
  }) async {
    try {
      final response = await _apiService.getPostResponse(
  '${ApiConstants.baseUrl}/api/doctor/auth/request',
  {
    "phone": phone,
    "dialCode": dialCode, // contains the PLUS
  },
);

      log("Request OTP Response: $response");
      return VerifyOtpApiResponse.fromMap(response);
    } catch (err) {
      return VerifyOtpApiResponse(status: 'error', message: 'Failed to request OTP');
    }
  }

  // 🔹 Verify OTP
  Future<VerifyOtpApiResponse> verifyOtp({
    required String traceId,
    required String otpCode,
    required String deviceToken, // user device token
  }) async {
    try {
      final verifyOtpModel = VerifyOtpModel(
        traceId: traceId,
        code: otpCode,
        deviceToken: deviceToken,
      );

      final response = await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/doctor/auth/verifyAuth',
        verifyOtpModel.toMap(),
      );

      log("Verify OTP Request: ${verifyOtpModel.toMap()}");
      log("Verify OTP Response: $response");

      return VerifyOtpApiResponse.fromMap(response);
    } catch (err) {
      return VerifyOtpApiResponse(status: 'error', message: 'Failed to verify OTP');
    }
  }

  // 🔹 Resend OTP
  Future<void> resendOtp({required String traceId, required String dialCode}) async {
    try {
      await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/common/resendOtp',
        {"traceId": traceId},
      );
    } catch (_) {}
  }
}
