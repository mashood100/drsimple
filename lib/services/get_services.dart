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

class GetAPIServices extends GetxService {
  Future geDoctors() async {
    final response = await http.get(
      Uri.parse("https://dr-simple.com/test_api/simple/doctors.php"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      inspect(response.statusCode);
      //
    }
  }

  Future getCovidDate() async {
    final response = await http.get(
      Uri.parse("https://dr-simple.com/test_api/simple/available_covid.php"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      inspect(response.statusCode);
      //
    }
  }

  Future getUserInfo() async {
    Map<String, dynamic> data = {
      "number": sharedPreferences.getString("number").toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/single_patient.php"),
        body: data,
      );

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        inspect(data);
        inspect(responseData);
        await sharedPreferences.setString("name", responseData[0]["name"]);
        return responseData;
      } else {
        Fluttertoast.showToast(
            msg: "Can't proccess check your internet connection");
      }
    } catch (e, s) {
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future getRecipies() async {
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString("number").toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/recipe.php"),
        body: data,
      );

      var responseData = jsonDecode(response.body);

      if (responseData[0]["status"] != 400) {
        return responseData;
      } else {}
    } catch (e, s) {
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

///////////////////////////////////////////////
  Future getRefral() async {
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString("number").toString(),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/categories.php"),
        body: data,
      );

      var responseData = jsonDecode(response.body);

      if (responseData[0]["status"] != 400) {
        return responseData;
      } else {
        inspect("getRefral $responseData");
      }
    } catch (e, s) {
      inspect("exception getRefral post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }
////////////////////////////////////////////////////////////////////

  Future getRequest({type}) async {
    Map<String, dynamic> data = {
      "u_id": sharedPreferences.getString("number").toString(),
      "type": type,
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/request_status.php"),
        body: data,
      );

      var responseData = jsonDecode(response.body);

      if (responseData[0]["status"] != 400) {
        return responseData;
      } else {}
    } catch (e, s) {
      inspect("exception edit post api: $e");
      debugPrintStack(stackTrace: s);
    }
  }

  Future getnNotifocation() async {
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString("number").toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(
            "https://dr-simple.com/test_api/simple/notification_history.php"),
        body: data,
      );

      var responseData = jsonDecode(response.body);

      if (responseData[0]["status"] != 400) {
        return responseData;
      } else {}
    } catch (e, s) {
      inspect("exception getnNotifocation api: $e");
      debugPrintStack(stackTrace: s);
    }
  }
}
