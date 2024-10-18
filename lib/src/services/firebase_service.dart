

class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  // final String ConfirmPassword;

  const UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNo,
  });

  // to store the data in firebase
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }
}
