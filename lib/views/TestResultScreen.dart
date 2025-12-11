
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
// import 'package:beh_doctor/widgets/AppTestWidget.dart';
// import 'package:beh_doctor/widgets/ClinicalResultWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TestResultScreen extends StatelessWidget {
//   final String appointmentId;

//   TestResultScreen({required this.appointmentId, required Appointment appointment});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AppointmentDetailsController(), permanent: true);

//     /// FETCH DATA ON SCREEN LOAD
//     controller.fetchAppointmentDetails(appointmentId);

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,

//         appBar: AppBar(
//           title: Text(
//             "Test Results",
//             style: TextStyle(fontWeight: FontWeight.w600),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black87,

//           bottom: TabBar(
//             indicatorColor: Colors.green,
//             indicatorWeight: 3,
//             labelColor: Colors.green,
//             unselectedLabelColor: Colors.black54,
//             labelStyle: TextStyle(fontWeight: FontWeight.w600),
//             tabs: const [
//               Tab(text: "App Test"),
//               Tab(text: "Clinical Results"),
//             ],
//           ),
//         ),

//         /// MAIN BODY
//         body: Obx(() {
//           if (controller.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return TabBarView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               AppTestWidget(),
//               ClinicalResultWidget(),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:beh_doctor/widgets/AppTestWidget.dart';
import 'package:beh_doctor/widgets/ClinicalResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestResultScreen extends StatelessWidget {
  final String appointmentId;

  TestResultScreen({
    required this.appointmentId,
    required Appointment appointment,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentDetailsController(), permanent: true);

    controller.fetchAppointmentDetails(appointmentId);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Test Results",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          bottom: const TabBar(
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "App Test"),
              Tab(text: "Clinical Results"),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              AppTestWidget(),
              ClinicalResultWidget(),
            ],
          );
        }),
      ),
    );
  }
}
