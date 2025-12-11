// import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AppTestWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AppointmentDetailsController>();

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Obx(() {
//         final app = controller.appTestData.value;

//         if (app == null) {
//           return Center(child: Text("No App Test Found"));
//         }

//         final data = app.data;
//         if (data == null) {
//           return Center(child: Text("No App Test Data Available"));
//         }

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Visual Acuity", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("${data.visualAcuity?.left?.os} | ${data.visualAcuity?.right?.od}"),

//             SizedBox(height: 12),

//             Text("Near Vision", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("${data.nearVision?.left?.os} | ${data.nearVision?.right?.od}"),

//             SizedBox(height: 12),

//             Text("Color Vision", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("${data.colorVision?.left} | ${data.colorVision?.right}"),

//             SizedBox(height: 12),

//             Text("AMD Test", style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("${data.amdVision?.left} | ${data.amdVision?.right}"),
//           ],
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';

class AppTestWidget extends StatelessWidget {
  const AppTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDetailsController>();

    return Obx(() {
      final app = controller.appTestData.value;

      if (app == null || app.data == null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Patient doesn't have any app test result",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }

      final data = app.data!;

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual Acuity card
            if (data.visualAcuity != null)
              _appTestCard(
                title: "Visual Acuity",
                leftItems: [
                  "OD   ${data.visualAcuity?.left?.od ?? '--'}",
                  "OS   ${data.visualAcuity?.left?.os ?? '--'}",
                ],
                rightItems: [
                  "OD   ${data.visualAcuity?.right?.od ?? '--'}",
                  "OS   ${data.visualAcuity?.right?.os ?? '--'}",
                ],
              ),

            // spacing
            const SizedBox(height: 14),

            // Near Vision card
            if (data.nearVision != null)
              _appTestCard(
                title: "Near Vision",
                leftItems: [
                  "OD   ${data.nearVision?.left?.od ?? '--'}",
                  "OS   ${data.nearVision?.left?.os ?? '--'}",
                ],
                rightItems: [
                  "OD   ${data.nearVision?.right?.od ?? '--'}",
                  "OS   ${data.nearVision?.right?.os ?? '--'}",
                ],
              ),

            const SizedBox(height: 14),

            // Color Vision card
            if (data.colorVision != null)
              _appTestCard(
                title: "Color Vision",
                leftItems: ["${data.colorVision?.left ?? '--'}"],
                rightItems: ["${data.colorVision?.right ?? '--'}"],
              ),

            const SizedBox(height: 14),

            // AMD card
            if (data.amdVision != null)
              _appTestCard(
                title: "AMD",
                leftItems: ["${data.amdVision?.left ?? '--'}"],
                rightItems: ["${data.amdVision?.right ?? '--'}"],
              ),

            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }

  Widget _appTestCard({
    required String title,
    required List<String> leftItems,
    required List<String> rightItems,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title row
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              // optional small chevron like screenshot (keeps same look)
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 12),

          // left / right columns
          Row(
            children: [
              // left column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Left Eye", style: TextStyle(fontSize: 13, color: Colors.black54)),
                    const SizedBox(height: 8),
                    for (var item in leftItems)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(item, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),

              // divider like screenshot
              Container(width: 1, height: 48, color: Colors.grey.shade200),

              // right column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Right Eye", style: TextStyle(fontSize: 13, color: Colors.black54)),
                      const SizedBox(height: 8),
                      for (var item in rightItems)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(item, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
