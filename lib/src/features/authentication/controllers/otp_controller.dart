import 'package:get/get.dart';
import 'package:login/src/features/authentication/screens/Home_sccreen/home_page.dart';
import 'package:login/src/repository/authentication_repository/authentication_repository.dart';


class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomePage()) : Get.back();
  }
}
