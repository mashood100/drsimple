import 'dart:convert';
import 'dart:developer';
import 'package:drsimple/main.dart';
import 'package:drsimple/view/app%20essentionals/bottom_nav.dart';
import 'package:drsimple/view/login%20screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginAPiService extends GetxService {
  Future createUserAccount({
    required String name,
    required String? phone,
    required String? dob,
    required String? password,
  }) async {
    Map<String, dynamic> data = {
      "name": name.toString(),
      "number": phone.toString(),
      "password": password.toString(),
      "dob": dob.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/register.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(name);
          inspect(password);
          inspect(dob);
          inspect(statusCode);
          Get.offAll(() => const WelcomeScreen());
          Fluttertoast.showToast(msg: "Account created successfully");
        } else if (statusCode == 2) {
          Fluttertoast.showToast(msg: "Number is already registered");
        } else {
          //debug the responce Status code
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future forgetPassword({
    required String? phone,
    required String? confirmPassword,
    required String? password,
  }) async {
    Map<String, dynamic> data = {
      "number": phone.toString(),
      "confirm_password": confirmPassword.toString(),
      "new_password": password.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/forget_password.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 1) {
          inspect(phone);
          inspect(password);
          inspect(confirmPassword);
          inspect(statusCode);
          Get.offAll(() => const WelcomeScreen());
          Fluttertoast.showToast(msg: "Password changed successfully ");
        } else if (statusCode == 3) {
          Fluttertoast.showToast(msg: "mobile number not found");
        } else {
          //debug the responce Status code
          inspect("register API $statusCode");
          Fluttertoast.showToast(msg: "Can't proccess request");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future loginUser({
    required String phone,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      "number": phone.toString(),
      "password": password.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/login.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      var date = jsonDecode(response.body)["date"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(phone);
          inspect(password);
          inspect(statusCode);
          await sharedPreferences.setString("number", phone.toString());
          await sharedPreferences.setString("nextloginn", phone.toString());
          Get.offAll(() => const MyNavigationBar());
          Fluttertoast.showToast(msg: "willkommen");
        } else if (statusCode == 400) {
          Fluttertoast.showToast(
              msg:
                  "Es existiert kein Account mit diesen Daten. Bitte Registrieren.");
        } else if (statusCode == 600) {
          Fluttertoast.showToast(msg: "Der Account wurde blockiert");
        } else if (statusCode == 700) {
          Fluttertoast.showToast(
              msg: "Die Praxis ist bis zum $date geschlossen");
        } else {
          //debug the responce Status code
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

  Future checkLoginStatus() async {
    Map<String, dynamic> data = {
      "number": sharedPreferences.getString("number"),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/check_login.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
        } else if (statusCode == 600) {
          Get.off(WelcomeScreen());
          await sharedPreferences.remove("name");
          await sharedPreferences.remove("number");
          Fluttertoast.showToast(msg: "Der Account wurde blockiert");
        } else if (statusCode == 700) {
          Fluttertoast.showToast(msg: "Benutzer ist im Urlaub");
          Get.off(WelcomeScreen());
          await sharedPreferences.remove("number");
          await sharedPreferences.remove("name");
        } else {
          //debug the responce Status code
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

  logout() async {
    await sharedPreferences.remove("name");
    await sharedPreferences.remove("number");
  }
}
