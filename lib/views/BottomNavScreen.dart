import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/views/AppointmentScreen.dart';
import 'package:beh_doctor/views/HomePage.dart';
import 'package:beh_doctor/views/MorePage.dart';
import 'package:beh_doctor/views/PrescriptionScreen.dart';
import 'package:beh_doctor/views/TransectionScreen.dart';
import 'package:beh_doctor/views/WithdrawScreen.dart';
import 'package:beh_doctor/widgets/CustomeBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      TransactionScreen(),
      // PrescriptionScreen(),
  
      AppointmentTabScreen(),
    //  WithdrawScreen(),
   
      
      const MorePage(),
    ];

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),

      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

