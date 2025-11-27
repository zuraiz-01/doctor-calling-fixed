import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/views/HomePage.dart';
import 'package:beh_doctor/widgets/CustomeBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Homepage(),
      // const AppointmentsPage(),
      // const WalletPage(),
      // const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() {
        return PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        );
      }),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
