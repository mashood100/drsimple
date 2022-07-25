import 'dart:convert';
import 'dart:developer';
import 'package:drsimple/main.dart';
import 'package:drsimple/view/app%20essentionals/done_request_screen.dart';
import 'package:drsimple/view/login%20screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppoinmentService extends GetxService {
  Future appointmentCreate({
    required String? dr_id,
    required String? reason,
  }) async {
    Map<String, dynamic> data = {
      "u_id": sharedPreferences.getString("number").toString(),
      "d_id": dr_id,
      "reason": reason,
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/appointment.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data);
          inspect(statusCode);
          Get.offAll(() => const RequestDoneScreen());
          Fluttertoast.showToast(msg: "Created Appointment successfully");
        } else {
          //debug the responce Status code
          inspect("appointmentCreate API $statusCode");
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

  Future covidCreate({
    required String? book_date,
  }) async {
    Map<String, dynamic> data = {
      "u_id": sharedPreferences.getString("number").toString(),
      "book_date": book_date,
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/covid.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data);
          inspect(statusCode);
          Get.offAll(() => const RequestDoneScreen());
          Fluttertoast.showToast(msg: "booked successfully");
        } else {
          //debug the responce Status code
          inspect("appointmentCreate API $statusCode");
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

  Future consultCreate({
    required String? reason,
  }) async {
    Map<String, dynamic> data = {
      "u_id": sharedPreferences.getString("number").toString(),
      "reason": reason,
    };

    try {
      var response = await http.post(
        Uri.parse("https://cybernsoft.com/test_api/simple/consult.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data);
          inspect(statusCode);
          Get.offAll(() => const RequestDoneScreen());
          Fluttertoast.showToast(msg: "Created consult successfully");
        } else {
          //debug the responce Status code
          inspect("consultCreate API $statusCode");
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
}
