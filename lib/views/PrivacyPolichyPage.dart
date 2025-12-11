import 'package:beh_doctor/widgets/CenterLottieWidget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),

      body: const CenterLottieWidget(title: "Privacy Policy"),
    );
  }
}
