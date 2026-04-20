import 'package:food_ordering_app/models/food_item_model.dart';

class CartModel {
  int price;
  int quantity;
  FoodItemModel foodItemModel;
  CartModel(
      {required this.price,
      required this.quantity,
      required this.foodItemModel});
}

List<FoodItemModel> cartListItems = [];
