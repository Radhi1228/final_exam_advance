import 'package:final_exam_ad/screen/home/model/home_model.dart';
import 'package:final_exam_ad/utils/helper/firebase_helper.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController{

  RxList<HomeModel> dataList = <HomeModel>[].obs;

  Future<void> readData() async {

    List<HomeModel> database = await FirebaseHelper.fbHelper.readData();
    dataList.value = database;
  }
}