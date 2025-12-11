import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLang = 'en'.obs;

  void changeLanguage(String langCode) {
    selectedLang.value = langCode;
    Get.updateLocale(Locale(langCode));
  }
}
