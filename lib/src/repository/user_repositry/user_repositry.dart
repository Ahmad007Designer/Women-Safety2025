import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").add(user.toJson());
      Get.snackbar(
        "Success", 
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error", 
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error creating user: $error");
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromJson(snapshot.docs.first.data());
      }
    } catch (error) {
      print("Error fetching user: $error");
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _db.collection("Users").get();
      return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    } catch (error) {
      print("Error fetching all users: $error");
      return [];
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
      Get.snackbar(
        "Success", 
        "Your account has been updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error", 
        "Failed to update account. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error updating user: $error");
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
      Get.snackbar(
        "Success", 
        "Account has been deleted.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error", 
        "Failed to delete account. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error deleting user: $error");
    }
  }
}