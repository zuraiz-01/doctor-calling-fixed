import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:beh_doctor/views/PrescriptionScreen.dart';
import 'package:beh_doctor/widgets/PrescriptionButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

class CallOptionsBottomSheet extends StatelessWidget {
  const CallOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgoraCallController>();

    final appt = controller.currentAppointment;
    final patient = appt?.patient;

    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Patient Options",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // -------------------- PRESCRIPTION --------------------
              _optionButton(
                title: "Prescription",
                icon: Icons.description,
                onTap: () {
                  if (patient?.id == null) {
                    Get.snackbar("Error", "Patient ID missing");
                    return;
                  }

                  Get.lazyPut(() => AppointmentDetailsController());

                  Get.to(() => PrescriptionListScreen(
                        patientId: patient!.id!,
                      ));
                },
              ),

              // -------------------- EYE TEST --------------------
              _optionButton(
                title: "Eye Test",
                icon: Icons.visibility,
                onTap: () {
                  if (appt == null) {
                    Get.snackbar("Error", "Appointment data missing");
                    return;
                  }

                  Get.lazyPut(() => AppointmentDetailsController());

                  Get.toNamed(
                    Routes.AppTestWidget,
                    arguments: appt,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // -------------------- REASON --------------------
          const Text(
            "Reason For Visit",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Text(
              appt?.reason ?? "No reason provided",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- BUTTON WIDGET --------------------
  Widget _optionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 150,
      height: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.grey.shade300,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
