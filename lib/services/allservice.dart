import 'package:drsimple/services/appoinment_service.dart';
import 'package:drsimple/services/get_services.dart';
import 'package:drsimple/services/login_service.dart';
import 'package:drsimple/services/post_service.dart';
import 'package:drsimple/services/profile_update_service.dart';
import 'package:get/get.dart';

Future<void> initServices() async {
  // put your services here
  await Get.putAsync<LoginAPiService>(() async => LoginAPiService());
  await Get.putAsync<UpdateprofileService>(() async => UpdateprofileService());
  await Get.putAsync<GetAPIServices>(() async => GetAPIServices());
  await Get.putAsync<AppoinmentService>(() async => AppoinmentService());
  await Get.putAsync<PostApiService>(() async => PostApiService());
}
