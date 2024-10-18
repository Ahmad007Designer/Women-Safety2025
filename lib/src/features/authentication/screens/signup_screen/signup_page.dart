import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/constants/colors.dart';
import 'package:login/src/constants/image_strings.dart';
import 'package:login/src/features/authentication/controllers/signup_controller.dart';
import 'package:login/src/features/authentication/models/user_model.dart';
import 'package:login/src/features/authentication/screens/login_screen/login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
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
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(controller.fullname, 'Enter Full Name', Icons.person),
                          const SizedBox(height: 20),
                          _buildTextField(controller.email, 'Enter Your Email', Icons.email),
                          const SizedBox(height: 16),
                          _buildTextField(controller.phone, 'Enter Phone Number', Icons.phone),
                          const SizedBox(height: 16),
                          _buildTextField(controller.password, 'Create Password', Icons.lock, obscure: true),
                          const SizedBox(height: 16),
                          _buildTextField(controller.conpassword, 'Confirm Password', Icons.lock, obscure: true),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = UserModel(
                                  fullName: controller.fullname.text.trim(),
                                  email: controller.email.text.trim(),
                                  phoneNo: controller.phone.text.trim(),
                                  password: controller.password.text.trim(),
                                );
                                controller.createUser(user);
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
                              'Sign Up',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>const LoginPage()));
                            },
                            child: const Text(
                              "Do You Have An Account? Log In",
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

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
        filled: true,
        fillColor: Colors.pink[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.pink),
      ),
      style: const TextStyle(color: tPrimeColor, fontSize: 14),
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}