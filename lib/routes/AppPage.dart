import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/views/AddMfsScreen.dart';

import 'package:beh_doctor/views/AgoraDoctorCallScreen.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';
import 'package:beh_doctor/views/DoctorProfileScreen.dart';
import 'package:beh_doctor/views/EditProfileScreen.dart';

import 'package:beh_doctor/views/LoginScreen.dart';
import 'package:beh_doctor/views/OtpScreen.dart';
import 'package:beh_doctor/views/PatientInfoScreen.dart';
import 'package:beh_doctor/views/PaymentsTermPage.dart';
import 'package:beh_doctor/views/PrivacyPolichyPage.dart';
import 'package:beh_doctor/views/TermsAndConditionsPage.dart';
import 'package:beh_doctor/views/TestResultScreen.dart';
import 'package:beh_doctor/views/callend.dart';
import 'package:beh_doctor/widgets/AppTestWidget.dart';
import 'package:beh_doctor/widgets/ClinicalResultWidget.dart';
import 'package:beh_doctor/views/callend.dart';
import 'package:beh_doctor/shareprefs.dart';

import 'package:get/get.dart';

class AppPages {
  static final pages = [
    /// Login Screen
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),

    /// OTP Screen
    GetPage(
      name: Routes.OTP,
      page: () => OtpScreen(traceId: '', bottomNavRoute: ''),
    ),

    GetPage(
      name: Routes.DoctorProfileScreen,
      page: () => DoctorProfileScreen(),
    ),

    GetPage(name: Routes.EditProfileScreen, page: () => EditProfileScreen()),

    GetPage(
      name: Routes.PatientInfoScreen,
      page: () => PatientInfoScreen(appointment: Appointment()),
    ),

    GetPage(name: Routes.AddMfsScreen, page: () => AddMfsScreen()),

    // GetPage(
    //   name: Routes.AgoraDoctorCallScreen,
    //   page: () {
    //     final args = Get.arguments ?? {};
    //     return AgoraDoctorCallScreen(
    //       channelId: args['channelId'] ?? "",
    //       token: args['token'] ?? "",
    //       appointment: args['appointment'],
    //     );
    //   },
    // ),
    // GetPage(
    //   name: Routes.AgoraDoctorCallScreen,
    //   page: () {
    //     final args = Get.arguments;

    //     if (args == null ||
    //         args['appointment'] == null ||
    //         args['channelId'] == null ||
    //         args['token'] == null) {
    //       return const Scaffold(
    //         body: Center(
    //           child: Text("Invalid navigation data"),
    //         ),
    //       );
    //     }

    //     return AgoraDoctorCallScreen(
    //       channelId: args['channelId'],
    //       token: args['token'],
    //       appointment: args['appointment'],
    //     );
    //   },
    // ),

    // GetPage(
    //   name: Routes.AgoraDoctorCallScreen,
    //   page: () {
    //     final args = Get.arguments as Map<String, dynamic>;

    //     return AgoraDoctorCallScreen(
    //       channelId: args['channelId'],
    //       token: args['token'],
    //       appointment: args['appointment'],
    //     );
    //   },
    // ),
    GetPage(
      name: Routes.AgoraDoctorCallScreen,
      page: () => AgoraDoctorCallScreen(
        channelId: SharedPrefs.getAgoraChannelId(),
        token: SharedPrefs.getDoctorAgoraToken(),
      ),
    ),
    // Call End Screen
    GetPage(name: Routes.CallEndScreen, page: () => const CallEndScreen()),

    GetPage(name: Routes.AppTestWidget, page: () => AppTestWidget()),
    GetPage(
      name: Routes.ClinicalResultWidget,
      page: () => ClinicalResultWidget(),
    ),
    GetPage(
      name: Routes.TestResultScreen,
      page: () => TestResultScreen(
        appointmentId: 'appoinmentID',
        appointment: Appointment(),
      ),
    ),
    GetPage(name: Routes.paymentterms, page: () => PaymentTermsPage()),
    GetPage(
      name: Routes.TermsAndConditions,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(name: Routes.PrivacyPolicy, page: () => PrivacyPolicyPage()),

    /// Home Screen (Not BottomNav)
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => Homepage(),
    // ),

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
