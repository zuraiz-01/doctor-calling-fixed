import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BankAccountsWidget extends StatelessWidget {
  BankAccountsWidget({super.key});

  final controller = Get.find<WithdrawAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.bankAccounts.isEmpty) {
        return const Center(child: Text("No Bank Accounts Found"));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.bankAccounts.length,
        itemBuilder: (context, index) {
          final acc = controller.bankAccounts[index];

          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              title: Text(acc.bankName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account Name: ${acc.accountName}"),
                  Text("Account Number: ${acc.accountNumber}"),
                  if (acc.branch.isNotEmpty) Text("Branch: ${acc.branch}"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
