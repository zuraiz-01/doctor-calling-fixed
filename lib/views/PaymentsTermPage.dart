import 'package:beh_doctor/widgets/CenterLottieWidget.dart';
import 'package:flutter/material.dart';

class PaymentTermsPage extends StatelessWidget {
  const PaymentTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Terms")),

      body: const CenterLottieWidget(title: "Payment Terms"),
    );
  }
}
