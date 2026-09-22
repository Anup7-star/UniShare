import 'package:unishare/core/constants/app_constants.dart';
import 'package:unishare/core/utils/extensions.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.isValidEmail()) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateCollegeEmail(String? value) {
    final emailError = validateEmail(value);
    if (emailError != null) return emailError;

    if (!value!.isCollegeEmail(AppConstants.mockCollegeDomain)) {
      return 'Please use your college email (${AppConstants.mockCollegeDomain})';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != AppConstants.otpLength) {
      return 'OTP must be ${AppConstants.otpLength} digits';
    }
    if (int.tryParse(value) == null) {
      return 'OTP must contain only numbers';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid amount';
    }
    if (price < 0) {
      return 'Price cannot be negative';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegExp = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
