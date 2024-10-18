import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/constants/colors.dart';
import 'package:login/src/constants/image_strings.dart';
import 'package:login/src/features/authentication/controllers/login_controller.dart';
import 'package:login/src/features/authentication/screens/forgot_screen/forgot_page.dart';
import 'package:login/src/features/authentication/screens/signup_screen/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

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
                          const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controller.email,
                            decoration: InputDecoration(
                              hintText: 'Enter Email or Phone Number',
                              hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
                              filled: true,
                              fillColor: Colors.pink[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.email, color: Colors.pink),
                            ),
                            style: const TextStyle(color: tPrimeColor, fontSize: 14),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email or phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.password,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
                              filled: true,
                              fillColor: Colors.pink[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.lock, color: Colors.pink),
                            ),
                            style: const TextStyle(color: tPrimeColor, fontSize: 14),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage()));},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.loginUser(
                                  controller.email.text.trim(),
                                  controller.password.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: tPrimeColor,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Or Connect With',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  googleLogo,
                                  width: 40,
                                  height: 40,
                                ),
                                onPressed: (){},
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                            },
                            child: const Text(
                              "Don't Have An Account? Sign Up",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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