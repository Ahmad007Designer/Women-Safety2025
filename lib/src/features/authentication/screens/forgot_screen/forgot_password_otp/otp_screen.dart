import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/src/constants/colors.dart';
import 'package:login/src/features/authentication/screens/login_screen/login_page.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId; // Add this parameter
  final bool isEmail; // To differentiate between email and phone verification
  final String identifier; // Email or phone number

  const OTPScreen({
    super.key,
    required this.verificationId, // Ensure verificationId is passed to constructor
    required this.isEmail,
    required this.identifier,
  });

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  // Method to verify OTP
  Future<void> _verifyOTP(String otp) async {
    try {
      if (widget.isEmail) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Please check your email for password reset instructions.')),
        );
      } else {
        await _verifyPhoneOTP(otp);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Method to verify phone OTP
  Future<void> _verifyPhoneOTP(String otp) async {
    if (otp.length != 6) {
      // If OTP is not 6 digits long, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP must be 6 digits')),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully')),
      );

      // Navigate to home or desired screen after successful verification
      Get.to(() => LoginPage());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  "CODE\nVERIFICATION",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: tPrimeColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                Text(
                  widget.isEmail
                      ? "Check your email for password reset instructions"
                      : "Enter the verification code sent to your phone ${widget.identifier}",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                if (!widget.isEmail)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: tPrimeColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: tPrimeColor, width: 2),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (value.length == 1 && index < 5) {
                              FocusScope.of(context).nextFocus();
                            }
                            if (index == 5 && value.isNotEmpty) {
                              _verifyOTP(
                                  _controllers.map((c) => c.text).join());
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    if (widget.isEmail) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    } else {
                      _verifyOTP(_controllers.map((c) => c.text).join());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: tPrimeColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    widget.isEmail ? 'Back to Login' : 'Verify',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
