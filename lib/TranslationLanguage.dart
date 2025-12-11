import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'doctor_profile': 'Doctor Profile',
          'no_data': 'No Data',
          'unknown': 'Unknown',

          // Basic Info
          'basic_info': 'Basic Information',
          'gender': 'Gender',
          'experience': 'Experience',
          'years': 'years',

          // Specialty
          'specialties': 'Specialties',
          'no_specialty': 'No specialties available',

          // Hospitals
          'hospitals': 'Hospitals',
          'no_hospital': 'No hospital data available',

          // Button
          'edit_profile': 'Edit Profile',
        },

        'bn': {
          'doctor_profile': 'ডাক্টর প্রোফাইল',
          'no_data': 'কোনো তথ্য নেই',
          'unknown': 'অজানা',

          // Basic Info
          'basic_info': 'মৌলিক তথ্য',
          'gender': 'লিঙ্গ',
          'experience': 'অভিজ্ঞতা',
          'years': 'বছর',

          // Specialty
          'specialties': 'বিশেষত্ব',
          'no_specialty': 'কোনো বিশেষত্ব নেই',

          // Hospitals
          'hospitals': 'হাসপাতাল',
          'no_hospital': 'হাসপাতালের তথ্য নেই',

          // Button
          'edit_profile': 'প্রোফাইল সম্পাদনা করুন',
        },
      };
}
