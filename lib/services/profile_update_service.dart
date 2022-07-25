import 'package:drsimple/view/profile_information/user%20profile/change%20number/number_chnage_done,.dart';
import 'package:drsimple/view/profile_information/user%20profile/change%20number/sms_for_number_change.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:drsimple/main.dart';
import 'package:drsimple/view/app%20essentionals/bottom_nav.dart';
import 'package:drsimple/view/login%20screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../view/profile_information/user profile/change password/password_change_done.dart';

class UpdateprofileService extends GetxService {
  Future updatePassword({
    required String? phone,
    required String? currentPassword,
    required String? confirmPassword,
    required String? password,
  }) async {
    Map<String, dynamic> data = {
      "id": phone.toString(),
      "current_password": currentPassword,
      "confirm_password": confirmPassword,
      "new_password": password,
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/update_password.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 1) {
          inspect(data);

          Get.offAll(() => const PasswordChangeDone());
          Fluttertoast.showToast(msg: "Password changed successfully ");
        } else if (statusCode == 3) {
          Fluttertoast.showToast(msg: "current password not correct");
        } else if (statusCode == 4) {
          Fluttertoast.showToast(msg: "id not found");
        } else {
          //debug the responce Status code
          inspect(data.toString());
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      Fluttertoast.showToast(msg: "Sometong went wrong");
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future updateNumber({
    required String? oldNumber,
    required String? newNumber,
  }) async {
    Map<String, dynamic> data = {
      "id": oldNumber,
      "number": newNumber,
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/update_number.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 1) {
          inspect(data);
          await sharedPreferences.setString("number", newNumber.toString());
          Get.offAll(
            () => const NumberChangeDoneScreen(),
          );
          Fluttertoast.showToast(msg: "Number changed successfully ");
        } else if (statusCode == 0) {
          Fluttertoast.showToast(msg: "unable to update number");
        } else if (statusCode == 4) {
          Fluttertoast.showToast(msg: "number not found");
        } else {
          //debug the responce Status code
          inspect(data.toString());
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      Fluttertoast.showToast(msg: "Sometong went wrong");
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future deleteAccount() async {
    Map<String, dynamic> data = {
      "number": sharedPreferences.getString("number"),
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/delete_user.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data);
          await sharedPreferences.remove(
            "number",
          );
          await sharedPreferences.remove("name");
          await sharedPreferences.remove(
            "nextloginn",
          );
          Fluttertoast.showToast(msg: "Account erfolgreich löschen");
          Get.offAll(
            () => const WelcomeScreen(),
          );
        } else {
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      Fluttertoast.showToast(msg: "something went wrong");
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future checkPasswordforNumberChange({
    required String phone,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      "number": phone.toString(),
      "password": password.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/login.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data);

          await sharedPreferences.setString("number", phone.toString());
          inspect(data);

          Get.offAll(
            () => const SMSForNumberChange(),
          );
        } else {
          //debug the responce Status code
          inspect(data);
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      Fluttertoast.showToast(msg: "something went wrong");
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }
}
