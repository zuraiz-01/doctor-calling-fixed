// // import 'package:beh_doctor/modules/AppointmentController.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';


// // class AppointmentScreen extends StatelessWidget {
// //   final AppointmentController _controller = Get.put(AppointmentController());

// //   AppointmentScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // First fetch appointments when screen opens
// //     _controller.fetchAppointments();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('My Appointments'),
// //         centerTitle: true,
// //       ),
// //       body: Obx(
// //         () {
// //           // Loading indicator
// //           if (_controller.isLoading.value) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           // Error message
// //           if (_controller.errorMessage.value.isNotEmpty) {
// //             return Center(child: Text(_controller.errorMessage.value));
// //           }

// //           // Empty list
// //           if (_controller.appointments.isEmpty) {
// //             return const Center(child: Text('No appointments found'));
// //           }

// //           // Appointment list
// //           return RefreshIndicator(
// //             onRefresh: () async {
// //               await _controller.fetchAppointments();
// //             },
// //             child: ListView.separated(
// //               itemCount: _controller.appointments.length,
// //               separatorBuilder: (_, __) => const Divider(),
// //               itemBuilder: (context, index) {
// //                 final appointment = _controller.appointments[index];

// //                 return ListTile(
// //                   leading: CircleAvatar(
// //                     backgroundImage: appointment.patient?.photo != null
// //                         ? NetworkImage(appointment.patient!.photo!)
// //                         : null,
// //                     child: appointment.patient?.photo == null
// //                         ? const Icon(Icons.person)
// //                         : null,
// //                   ),
// //                   title: Text(appointment.patient?.name ?? 'Unknown Patient'),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text('Type: ${appointment.appointmentType ?? '-'}'),
// //                       Text('Date: ${appointment.date ?? '-'}'),
// //                       Text('Status: ${appointment.status ?? '-'}'),
// //                     ],
// //                   ),
// //                   trailing: appointment.isPrescribed == true
// //                       ? const Icon(Icons.check_circle, color: Colors.green)
// //                       : null,
// //                   onTap: () {
// //                     // Optional: navigate to appointment detail
// //                   },
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:beh_doctor/modules/AppointmentController.dart';
// import 'package:beh_doctor/widgets/AppointmentListWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class AppointmentTabScreen extends StatelessWidget {
//   final AppointmentController _controller =
//       Get.put(AppointmentController());

//   AppointmentTabScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Load data once
//     _controller.fetchAppointments();

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Appointments"),
//           centerTitle: true,
//           bottom: const TabBar(
//             indicatorColor: Colors.blue,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             tabs: [
//               Tab(text: "Upcoming"),
//               Tab(text: "Past"),
//             ],
//           ),
//         ),
//         body: Obx(() {
//           return TabBarView(
//             children: [
//               /// Upcoming Appointments
//               AppointmentListWidget(
//                 appointments: _controller.upcomingAppointments,
//                 isLoading: _controller.isLoading.value,
//                 errorMessage: _controller.errorMessage.value,
//                 onRefresh: () async => _controller.fetchAppointments(),
//               ),

//               /// Past Appointments
//               AppointmentListWidget(
//                 appointments: _controller.pastAppointments,
//                 isLoading: _controller.isLoading.value,
//                 errorMessage: _controller.errorMessage.value,
//                 onRefresh: () async => _controller.fetchAppointments(),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
// import 'package:beh_doctor/modules/AppointmentController.dart';
// import 'package:beh_doctor/widgets/AppointmentListWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AppointmentTabScreen extends StatelessWidget {
//   final AppointmentController _controller =
//       Get.put(AppointmentController());

//   AppointmentTabScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     _controller.fetchAppointments();

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("appointments".tr),   // 🔥 KEY
//           centerTitle: true,
//           bottom: TabBar(
//             indicatorColor: Colors.blue,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             tabs: [
//               Tab(text: "upcoming".tr),   // 🔥 KEY
//               Tab(text: "past".tr),       // 🔥 KEY
//             ],
//           ),
//         ),
//         body: Obx(() {
//           return TabBarView(
//             children: [
//               AppointmentListWidget(
//                 appointments: _controller.upcomingAppointments,
//                 isLoading: _controller.isLoading.value,
//                 errorMessage: _controller.errorMessage.value,
//                 onRefresh: () async => _controller.fetchAppointments(),
//               ),

//               AppointmentListWidget(
//                 appointments: _controller.pastAppointments,
//                 isLoading: _controller.isLoading.value,
//                 errorMessage: _controller.errorMessage.value,
//                 onRefresh: () async => _controller.fetchAppointments(),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/widgets/AppointmentListWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentTabScreen extends StatelessWidget {
  final AppointmentController _controller =
      Get.put(AppointmentController());

  AppointmentTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.fetchAppointments();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // same as queue bg

      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text(
          "appointments".tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: Column(
        children: [

          // ------------- Custom Queue Style Tab Bar ---------------
       
Container(
    width: double.infinity,
  padding: const EdgeInsets.symmetric(vertical: 12),
  color: Colors.white,
  child: Obx(() {
    return Container(
      width: 260, // border box width — adjust if needed
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF008541)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _innerTab(
            title: "upcoming".tr,
            isSelected: _controller.selectedTab.value == 0,
            onTap: () => _controller.changeTab(0),
          ),
          _innerTab(
            title: "past".tr,
            isSelected: _controller.selectedTab.value == 1,
            onTap: () => _controller.changeTab(1),
          ),
        ],
      ),
    );
  }),
),

          // ---------------- PageView (Queue-style) ------------------
          Expanded(
            child: Obx(() {
              return PageView(
                controller: _controller.pageController,
                onPageChanged: (i) => _controller.changeTab(i),
                children: [
                  AppointmentListWidget(
                    appointments: _controller.upcomingAppointments,
                    isLoading: _controller.isLoading.value,
                    errorMessage: _controller.errorMessage.value,
                    onRefresh: () async => _controller.fetchAppointments(),
                  ),

                  AppointmentListWidget(
                    appointments: _controller.pastAppointments,
                    isLoading: _controller.isLoading.value,
                    errorMessage: _controller.errorMessage.value,
                    onRefresh: () async => _controller.fetchAppointments(),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // ------------------- Custom Tab Button (Queue Style) -------------------
  Widget appointmentTabs({
  required int selectedIndex,
  required Function(int) onTabChange,
}) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF008541), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),

    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _innerTab(
          title: "Upcoming",
          isSelected: selectedIndex == 0,
          onTap: () => onTabChange(0),
        ),
        const SizedBox(width: 6),
        _innerTab(
          title: "Past",
          isSelected: selectedIndex == 1,
          onTap: () => onTabChange(1),
        ),
      ],
    ),
  );
}

Widget _innerTab({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF008541) : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF008541),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}

}


