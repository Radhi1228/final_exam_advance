import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../utils/helper/db_helper.dart';
import '../../home/controller/home_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text("Your Shopping Cart"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.dataList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Are you sure want to delete",
                      content: const Text("Shopping"),
                      actions: [
                        ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black,
                              )),
                          onPressed: () async {
                            await DBHelper.helper.deleteCart(
                                int.parse(controller.dataList[index].id!));
                            controller.readData();
                            Get.back();
                          },
                          child: const Text(
                            "Yes",
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black,
                              )),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "No",
                          ),
                        )
                      ],
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.dataList[index].product}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                          Text("\$ ${controller.dataList[index].price}",
                              style: const TextStyle(
                                  fontSize: 16)),
                          Text("${controller.dataList[index].qua}",
                              style: const TextStyle(
                                  fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
