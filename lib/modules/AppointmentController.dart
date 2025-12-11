
import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';

class AppointmentController extends GetxController {
  final AppointmentRepo _repo = AppointmentRepo();

  var isLoading = false.obs;

  // 🔥 Updated: Two separate lists
  var upcomingAppointments = <Appointment>[].obs;
  var pastAppointments = <Appointment>[].obs;
    var clinicalTests = <TestResult>[].obs;       // clinical list
  var appTestData = Rxn<AppTestData>();   

  var errorMessage = ''.obs;

  // 🔥 Single API call → but split into two lists
  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final response = await _repo.getAppointmentList();

      if (response.status == "success" && response.data != null) {
        // 🔥 Extract all appointments and split into upcoming and past
        List<Appointment> allAppointments = response.data!.docs ?? [];
        print("========= 📌 FULL APPOINTMENT API LOGS START =========");

for (var apt in allAppointments) {
  print("--------------------------------------------------");
  print("👤 Patient: ${apt.patient?.name}");
  print("📞 Phone: ${apt.patient?.phone}");
  print("👨‍⚕️ Doctor: ${apt.doctor?.name}");

  print("🕒 Appointment Date: ${apt.appointmentDate}");
  print("📅 Raw Date String: ${apt.date}");
  print("📌 Status: ${apt.status}");
  // print("test result: ${apt.}");
  
  print("💳 Payment ID: ${apt.paymentId}");
  print("💰 Method: ${apt.paymentMethod}");
  print("💸 Total Amount: ${apt.totalAmount}");
  print("🏷️ VAT: ${apt.vat}");
  print("🏷️ Discount: ${apt.discount}");
  print("💵 Grand Total: ${apt.grandTotal}");
  print("appointment id: ${apt.id}");

  print("📁 Eye Photos: ${apt.eyePhotos}");
  print("📁 Additional Files: ${apt.additionalFiles}");

  print("📡 Agora Doctor Token: ${apt.doctorAgoraToken}");
  print("📡 Agora Patient Token: ${apt.patientAgoraToken}");
print(appTestData);

  print("--------------------------------------------------");
}

print("========= 📌 FULL APPOINTMENT API LOGS END =========");

      for (var apt in upcomingAppointments) {
  print("Upcoming: ${apt.patient?.name}, ${apt.appointmentDate}");
}
for (var apt in pastAppointments) {
  print("Past: ${apt.patient?.name}, ${apt.appointmentDate}");
}

 final today = DateTime.now();

upcomingAppointments.value = allAppointments.where((apt) {
  final aptDate = apt.appointmentDate!.toLocal(); // server se aaya UTC, convert to local
  // Check if appointment is today or in future
  return aptDate.isAfter(today) || 
         (aptDate.year == today.year && 
          aptDate.month == today.month && 
          aptDate.day == today.day);
}).toList();

pastAppointments.value = allAppointments.where((apt) {
  final aptDate = apt.appointmentDate!.toLocal();
  // Past appointments: strictly before today
  return aptDate.isBefore(today) && 
         !(aptDate.year == today.year && 
           aptDate.month == today.month && 
           aptDate.day == today.day);
}).toList();


    // 🔹 Debug prints
   
    print("Upcoming Appointments:");
    for (var apt in upcomingAppointments) {
      print("  ${apt.patient?.name}, ${apt.appointmentDate}");
    }

    print("Past Appointments:");
    for (var apt in pastAppointments) {
      print("  ${apt.patient?.name}, ${apt.appointmentDate}");
    }


      }
       else {
        errorMessage.value = response.message ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage.value = "An error occurred";
    } finally {
      isLoading.value = false;
    }
  }

var selectedTab = 0.obs;
PageController pageController = PageController();

void changeTab(int index) {
  selectedTab.value = index;
  pageController.jumpToPage(index);
}

}

