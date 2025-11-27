import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 25);
    _dio.options.receiveTimeout = const Duration(seconds: 25);
  }

  Future<Map<String, dynamic>> getPostResponse(
      String url, Map<String, dynamic> body) async {
    try {
      print("🌐 POST URL: $url");
      print("📦 POST BODY: $body");

      final response = await _dio.post(
        url,
        data: body, // ✅ FIXED (no jsonEncode)
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ RESPONSE DATA: ${response.data}");
      print("RAW OTP RESPONSE: ${response.data}");

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ DIO ERROR: ${e.message}");
      if (e.response != null) {
        print("❌ RESPONSE: ${e.response?.data}");
        return e.response?.data as Map<String, dynamic>;
      } else {
        return {'status': 'error', 'message': 'Network error'};
      }
    } catch (err) {
      print("❌ API ERROR: $err");
      return {'status': 'error', 'message': 'Something went wrong'};
    }
  }
}
