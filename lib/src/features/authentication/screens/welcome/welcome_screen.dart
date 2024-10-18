import 'package:flutter/material.dart';
import 'package:login/src/constants/colors.dart';

import 'package:login/src/constants/image_strings.dart';
import 'package:login/src/constants/text_strings.dart';
import 'package:login/src/features/authentication/screens/login_screen/login_page.dart';
import 'package:login/src/features/authentication/screens/signup_screen/signup_page.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: const AssetImage(welcomeScreenImage2),
                  height: height * 0.5),
              const Text(tWelcomeTitle,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: tPrimeColor)),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                tWelcomeSubTitle,
                style: TextStyle(fontSize: 16, color: tSubTitleColor,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                        },
                        style: OutlinedButton.styleFrom(
                          elevation: 0,
                      
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: tPrimeColor),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: tPrimeColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
            
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
                          foregroundColor: tPrimeColor,
                          backgroundColor: tPrimeColor,
                          side: const BorderSide(color: tPrimeColor),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
