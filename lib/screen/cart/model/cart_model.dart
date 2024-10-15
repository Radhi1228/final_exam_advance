class CartModel
{
  String?product,price,qua;
  int?id;

  CartModel({this.product,this.price,this.qua,this.id});
  factory CartModel.mapToModel(Map m1)
  {
    return CartModel(id:m1['id'] ,product:m1['product'] ,price:m1['price'] ,qua:m1['qua']);
  }
}