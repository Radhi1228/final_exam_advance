class HomeModel
{
  String? product,qua,id,price;


  HomeModel({this.product,this.price,this.qua,this.id});
  factory HomeModel.mapToModel(Map m1, String docId)
  {
    return HomeModel(id:docId ,product:m1['product'] ,price:m1['price'] ,qua:m1['qua']);
  }
}