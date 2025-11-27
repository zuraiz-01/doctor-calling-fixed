import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';
import 'package:beh_doctor/views/HomePage.dart';
import 'package:beh_doctor/views/LoginScreen.dart';
import 'package:beh_doctor/views/OtpScreen.dart';

import 'package:get/get.dart';

class AppPages {
  static final pages = [
    /// Login Screen
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),

    /// OTP Screen
    GetPage(
      name: Routes.OTP,
      page: () => OtpScreen(traceId: '', bottomNavRoute: '',),
    ),

    /// Home Screen (Not BottomNav)
    GetPage(
      name: Routes.HOME,
      page: () => Homepage(),
    ),

    /// Bottom Navigation Page with Binding
    GetPage(
      name: Routes.BOTTOM_NAV,
      page: () => BottomNavScreen(),
      binding: BindingsBuilder(() {
        Get.put(BottomNavController());
      }),
    ),
  ];
}
