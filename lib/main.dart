import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/firebase_options.dart';
import 'package:login/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:login/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login/src/utils/Theme/theme.dart';

void main() async {
  // Ensure Flutter engine is initialized before any other setup
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and then register AuthenticationRepository with GetX
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value)=>Get.put(AuthenticationRepository()));
  
  // Run the Flutter app
  runApp(const App());
}

class WidgetFlutterBinding {
  static void ensureInitialized() {}
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // home: const Scaffold(body: Center(child:CircularProgressIndicator())),
      home: const SplashScreen(),
      // home: GoogleMapPage(),
    );
  }
}
