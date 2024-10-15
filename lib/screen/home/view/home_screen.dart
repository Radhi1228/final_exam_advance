import 'package:final_exam_ad/screen/home/controller/home_controller.dart';
import 'package:final_exam_ad/screen/home/model/home_model.dart';
import 'package:final_exam_ad/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  TextEditingController txtProduct = TextEditingController();
  TextEditingController txtQua = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            "Shopping",
            style: (TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/cart');
              },
              icon: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              ),
            ),
          ]),
      body: Center(
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.white,),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 8),
                                  child: Text(
                                    "Name : ${controller.dataList[index].product}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 3),
                                  child: Text(
                                    "Quantity : ${controller.dataList[index].qua}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 3),
                                      child: Text(
                                        "Price : \$${controller.dataList[index].price}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(width: 130,),
                                    IconButton(
                                        onPressed: () {
                                          txtProduct.text =
                                          controller.dataList[index].product!;
                                          txtPrice.text =
                                          controller.dataList[index].price!;
                                          txtQua.text = controller.dataList[index].qua!;
                                          Get.defaultDialog(
                                              title: "Update Details",
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: txtProduct,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter the product";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: const InputDecoration(
                                                        hintText: "Product"),
                                                  ),
                                                  TextFormField(
                                                    controller: txtQua,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter the Quantity";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: const InputDecoration(
                                                        hintText: "Quantity"),
                                                  ),
                                                  TextFormField(
                                                    controller: txtPrice,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter the price";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: const InputDecoration(
                                                        hintText: "Price"),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.black),
                                                        foregroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.white)),
                                                    onPressed: () {
                                                      String product =
                                                          txtProduct.text;
                                                      String qua = txtQua.text;
                                                      String price = txtPrice.text;
                                                      HomeModel model = HomeModel(
                                                          qua: qua,
                                                          product: product,
                                                          price: price,
                                                          id: controller
                                                              .dataList[index].id);
                                                      FirebaseHelper.fbHelper
                                                          .updateData(model);
                                                      controller.readData();
                                                      txtPrice.clear();
                                                      txtQua.clear();
                                                      txtProduct.clear();
                                                      Get.back();
                                                    },
                                                    child: const Text("Update")),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.black),
                                                        foregroundColor:
                                                        WidgetStatePropertyAll(
                                                            Colors.white)),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: const Text("Cancel"))
                                              ]);
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseHelper.fbHelper
                                              .deleteData(controller.dataList[index].id!);
                                          controller.readData();
                                        },
                                        icon: const Icon(Icons.delete)),
                                    IconButton(
                                        onPressed: () {
                                          HomeModel model = HomeModel(
                                            price: controller.dataList[index].price,
                                            product: controller.dataList[index].product,
                                            qua: controller.dataList[index].qua,
                                          );Get.snackbar("Add to cart", "Successfully",backgroundColor: Colors.white);
                                        },
                                        icon: const Icon(Icons.add_box_sharp)),

                                  ],
                                ),

                              ],
                            ),

                            const Spacer(),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Products ",
              content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: txtProduct,
                        decoration: const InputDecoration(
                          hintText: "Product Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the product";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: txtQua,
                        decoration: const InputDecoration(
                          hintText: "Product Quantity",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Quantity";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: txtPrice,
                        decoration: const InputDecoration(
                          hintText: "Product Price",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the Price";
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              actions: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        HomeModel m1 = HomeModel(
                            price: txtPrice.text,
                            product: txtProduct.text,
                            qua: txtQua.text);
                        FirebaseHelper.fbHelper.insertData(m1);
                        controller.readData();
                        txtProduct.clear();
                        txtQua.clear();
                        txtPrice.clear();

                        Get.back();
                        Get.snackbar("Data Saved", "Successfully",backgroundColor: Colors.white);
                      }
                    },
                    child: const Text("Submit")),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                        foregroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"))
              ]);
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
