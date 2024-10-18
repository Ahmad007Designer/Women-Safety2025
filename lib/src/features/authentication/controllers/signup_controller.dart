import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/authentication/models/user_model.dart';
import 'package:login/src/features/authentication/screens/forgot_screen/forgot_password_otp/otp_screen.dart';
import 'package:login/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login/src/repository/user_repositry/user_repositry.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final userRepo = Get.put(UserRepository());
  final authRepo = Get.put(AuthenticationRepository());

  final fullname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final conpassword = TextEditingController();

  // Create a user using the provided user model.
  void createUser(UserModel user) async {
    try {
      // Save user data to the repository.
      await userRepo.createUser(user);
      await authRepo.createUserWithEmailAndPassword(user.email, user.password);
      phoneAuthentication(user.phoneNo);

    } catch (error) {
      Get.snackbar('Error', 'Something went wrong. Try again');
      print(error.toString());
    }
  }

  // Handle phone number authentication using Firebase.
  Future<void> phoneAuthentication(String phone) async {
    try {
      // Firebase phone number verification.
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 $phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user after phone number is verified.
          await FirebaseAuth.instance.signInWithCredential(credential);
          print("Phone number automatically verified and user signed in.");
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle errors if verification fails.
          print("Phone authentication failed: ${e.message}");
          throw Exception('Phone authentication failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // OTP sent successfully, navigate to OTP screen.
          print("OTP sent to phone. Verification ID: $verificationId");

          // Passing the verification ID to the OTP screen.
          Get.to(() => OTPScreen(verificationId: verificationId, isEmail: false, identifier: phone));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval of the OTP timed out.
          print("Auto retrieval timed out.");
        },
      );
    } catch (e) {
      // Handle any errors during phone authentication.
      print("Phone authentication error: $e");
      throw Exception('Phone authentication failed: $e');
    }
  }
}
