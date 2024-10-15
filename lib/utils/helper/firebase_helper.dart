import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam_ad/screen/home/model/home_model.dart';

class FirebaseHelper {
  static FirebaseHelper fbHelper = FirebaseHelper._();

  FirebaseHelper._();

  var database = FirebaseFirestore.instance;

  Future<void> insertData(HomeModel model) async {
    await database.collection("shopping").add({
      "product": model.product,
      "price": model.price,
      "qua": model.qua,
    });
  }

  Future<List<HomeModel>> readData() async {
    QuerySnapshot shoppingData = await database.collection("shopping").get();
    List<QueryDocumentSnapshot<Object?>> data = shoppingData.docs;
    List<HomeModel> model = data
        .map(
          (e) => HomeModel.mapToModel(e.data()! as Map, e.id),
        )
        .toList();
    return model;
  }

  Future<void> updateData(HomeModel model) async {
    await database.collection("shopping").doc(model.id).set({
      "product": model.product,
      "price": model.price,
      "qua": model.qua,
    });
  }
  Future<void> deleteData(String dId)
  async {
    await database.collection("shopping").doc(dId).delete();
  }
}
