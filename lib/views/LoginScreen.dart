
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:beh_doctor/modules/auth/controller/LoginController.dart';

// class LoginScreen extends StatelessWidget {
//   final LoginController controller = Get.put(LoginController());

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 60),
//               Text(
//                 "Welcome",
//                 style: TextStyle(
//                   color: Colors.green.shade700,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 40),

//               // Phone input with country code
//               IntlPhoneField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter Phone Number',
//                   labelStyle: TextStyle(color: Colors.grey.shade600),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.green),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.green.shade700, width: 2),
//                   ),
//                 ),
//               initialCountryCode: 'BD',
//   showDropdownIcon: false,
//   onChanged: (phone) {
//     controller.phone.value = phone.number;
//     controller.dialCode.value = phone.countryCode;
//                 },
//                 cursorColor: Colors.green,
//               ),

//               const SizedBox(height: 50),

//               // Continue Button
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade700,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: controller.isLoading.value
//                           ? null
//                           : () => controller.sendOtp(),
//                       child: controller.isLoading.value
//                           ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : const Text(
//                               "Continue",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:beh_doctor/modules/auth/controller/LoginController.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

// ---------------- LANGUAGE CHIP ----------------
class LanguageChipGetX extends StatelessWidget {
  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(63),
          border: Border.all(color: const Color(0xFF008541)),
        ),
        child: Row(
          children: [
            // BANGLA
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeLanguage('bn'),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedLang.value == 'bn'
                        ? const Color(0xFF008541)
                        : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'বাং',
                    style: TextStyle(
                      fontSize: 9,
                      color: controller.selectedLang.value == 'bn'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // ENGLISH
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeLanguage('en'),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedLang.value == 'en'
                        ? const Color(0xFF008541)
                        : Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'ENG',
                    style: TextStyle(
                      fontSize: 9,
                      color: controller.selectedLang.value == 'en'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  static const Color appGreen = Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ----------- APPBAR WITH LANGUAGE TOGGLE -----------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: LanguageChipGetX(),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // --------- TITLE ---------
              const Text(
                "Welcome",
                style: TextStyle(
                  color: appGreen,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // -------- PHONE FIELD ----------
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Enter Phone Number',
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: appGreen),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: appGreen, width: 2),
                  ),
                ),
                initialCountryCode: 'BD',
                showDropdownIcon: false,
                cursorColor: appGreen,
                onChanged: (phone) {
                  controller.phone.value = phone.number;
                  controller.dialCode.value = phone.countryCode;
                },
              ),

              const SizedBox(height: 50),

              // -------- CONTINUE BUTTON --------
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.sendOtp(),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )),

              const SizedBox(height: 25),

              // -------- TERMS & CONDITIONS --------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "By continuing, you agree to our ",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 12,
                      color: appGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              const Text(
                "Privacy Policy applies",
                style: TextStyle(
                  fontSize: 12,
                  color: appGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
