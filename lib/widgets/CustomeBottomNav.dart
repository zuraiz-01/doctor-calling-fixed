import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({super.key});

  final BottomNavController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navItem("Home", Icons.home, 0),
            navItem("Appointments", Icons.calendar_month, 1),
            navItem("Wallet", Icons.wallet, 2),
            navItem("Profile", Icons.person, 3),
          ],
        );
      }),
    );
  }

  Widget navItem(String title, IconData icon, int pageIndex) {
    return GestureDetector(
      onTap: () => controller.changeTab(pageIndex),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: controller.index.value == pageIndex ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: controller.index.value == pageIndex ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
