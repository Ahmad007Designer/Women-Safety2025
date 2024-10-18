import 'package:flutter/material.dart';
import 'package:login/src/constants/colors.dart';
import 'package:login/src/features/authentication/screens/forgot_screen/forgot_password_otp/otp_screen.dart';
import 'package:login/src/features/authentication/screens/login_screen/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isEmail = true;

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_isEmail) {
          await _auth.sendPasswordResetEmail(email: _identifierController.text);
        } else {
          await _sendPhoneOTP(_identifierController.text);
        }
        _navigateToOTPScreen(
            isEmail: _isEmail, identifier: _identifierController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _sendPhoneOTP(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
    print('OTP sent to $phoneNumber');
  }

  void _navigateToOTPScreen({required bool isEmail, required String identifier}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            OTPScreen(isEmail: isEmail, identifier: identifier, verificationId: '',),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: tPrimeColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Image.asset(
                              'assets/logo/logo.png',
                              height: 150,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _identifierController,
                            decoration: InputDecoration(
                              hintText: _isEmail ? 'Enter Email' : 'Enter Phone Number',
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              filled: true,
                              fillColor: Colors.pink[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                _isEmail ? Icons.email : Icons.phone,
                                color: Colors.pink
                              ),
                            ),
                            style: const TextStyle(
                              color: tPrimeColor,
                              fontSize: 14,
                            ),
                            keyboardType: _isEmail ? TextInputType.emailAddress : TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return _isEmail ? 'Please enter your email' : 'Please enter your phone number';
                              }
                              if (_isEmail && !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              if (!_isEmail && value.length != 10) {
                                return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isEmail = !_isEmail;
                                _identifierController.clear();
                              });
                            },
                            child: Text(
                              _isEmail ? 'Use Phone Number Instead' : 'Use Email Instead',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: _sendOTP,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: tPrimeColor,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white),
                                SizedBox(width: 7),
                                Text(
                                  'Back to Log In',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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