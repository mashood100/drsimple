import 'dart:convert';
import 'dart:developer';
import 'package:drsimple/main.dart';
import 'package:drsimple/view/app%20essentionals/done_request_screen.dart';
import 'package:drsimple/view/login%20screen/welcome_screen.dart';
import 'package:drsimple/view/receipthistory/receipt_history_page.dart';
import 'package:drsimple/view/referral_historypage/referral_history_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostApiService extends GetxService {
  Future createRecipe({
    required String? name,
    required String? power,
  }) async {
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString("number").toString(),
      "power": power,
      "name": name,
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/recipe_create.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);
          Get.offAll(() => const ReceiptHistory());
          Fluttertoast.showToast(msg: "Recipe Created ");
        } else {
          //debug the responce Status code
          inspect("Recipe API $statusCode");
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

  Future removeRecipe({
    required id,
  }) async {
    Map<String, dynamic> data = {
      "id": id,
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/delete_recipe.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);

          Fluttertoast.showToast(msg: "Removed");
        } else {
          //debug the responce Status code
          inspect("Recipe API $statusCode");
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

  Future orderRecipe({required id, required dose}) async {
    Map<String, dynamic> data = {
      "r_id": id,
      "u_id": sharedPreferences.getString("number"),
      "dose": dose ?? "",
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/order.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);
          Get.offAll(() => const RequestDoneScreen());
          Fluttertoast.showToast(msg: "ordered");
        } else {
          //debug the responce Status code
          inspect("Recipe API $statusCode");
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

  ///////////////////////////////////////////////////////////////////////////////////////////
  ///
  Future createReferal({
    required String? name,
  }) async {
    Map<String, dynamic> data = {
      "user_id": sharedPreferences.getString("number").toString(),
      "c_name": name,
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/category_create.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);
          Get.offAll(() => const ReferralHistory());
          Fluttertoast.showToast(msg: "Referal Created ");
        } else {
          //debug the responce Status code
          inspect("createReferal API $statusCode");
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

  Future removeRefral({
    required id,
  }) async {
    Map<String, dynamic> data = {
      "c_id": id,
    };

    try {
      var response = await http.post(
        Uri.parse(
            "https://dr-simple.com/test_api/simple/delete_categories.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);

          Fluttertoast.showToast(msg: "Removed");
        } else {
          //debug the responce Status code
          inspect("Recipe API $statusCode");
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

  Future bookedRefral({
    required id,
  }) async {
    Map<String, dynamic> data = {
      "c_id": id,
      "u_id": sharedPreferences.getString("number"),
    };

    try {
      var response = await http.post(
        Uri.parse("https://dr-simple.com/test_api/simple/referal_create.php"),
        body: data,
      );

      var statusCode = jsonDecode(response.body)["status"];
      if (response.statusCode == 200) {
        if (statusCode == 200) {
          inspect(data.toString());
          inspect(statusCode);
          Get.offAll(() => const RequestDoneScreen());
          Fluttertoast.showToast(msg: "Done");
        } else {
          //debug the responce Status code
          inspect("bookedRefral API $statusCode");
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
