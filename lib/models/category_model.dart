import 'package:food_ordering_app/helper/app_pictures.dart';
import 'package:food_ordering_app/models/food_item_model.dart';

class CategoryModel {
  String categroy_image;
  String category_name;
  List<FoodItemModel> item;
  CategoryModel(
      {required this.category_name,
      required this.categroy_image,
      required this.item});
}

List<CategoryModel> CategoryItem = [
  CategoryModel(
      category_name: 'All',
      categroy_image: 'assets/pictures/All.png',
      item: []),
  CategoryModel(
      category_name: 'Burgers',
      categroy_image: AppPictures.burger1,
      item: BurgerList),
  CategoryModel(
      category_name: 'Pizza',
      categroy_image: AppPictures.pizza1,
      item: PizzaList),
  CategoryModel(
      category_name: 'Desserts',
      categroy_image: AppPictures.icecream1,
      item: IcecreamList),
];

List<FoodItemModel> BurgerList = [
  FoodItemModel(
      Item_image: AppPictures.burger2,
      Item_name: 'Zinger Burger',
      Item_price: 140),
  FoodItemModel(
      Item_image: AppPictures.burger3,
      Item_name: 'KFC Burger',
      Item_price: 150),
  FoodItemModel(
      Item_image: AppPictures.burger4,
      Item_name: 'Mexican Burger',
      Item_price: 180),
  FoodItemModel(
      Item_image: AppPictures.burger5,
      Item_name: 'Crispy Burger',
      Item_price: 100),
  FoodItemModel(
      Item_image: AppPictures.burger6,
      Item_name: 'Tandoori Burger',
      Item_price: 110),
  FoodItemModel(
      Item_image: AppPictures.burger7,
      Item_name: 'BBQ Burger',
      Item_price: 150),
];

List<FoodItemModel> PizzaList = [
  FoodItemModel(
      Item_image: AppPictures.pizza2,
      Item_name: 'Cheese Pizza',
      Item_price: 200),
  FoodItemModel(
      Item_image: AppPictures.pizza3,
      Item_name: 'Pepperoni Pizza',
      Item_price: 300),
  FoodItemModel(
      Item_image: AppPictures.pizza4,
      Item_name: 'Vegetable Pizza',
      Item_price: 400),
  FoodItemModel(
      Item_image: AppPictures.pizza5, Item_name: 'Meat Pizza', Item_price: 500),
  FoodItemModel(
      Item_image: AppPictures.pizza6, Item_name: 'BBQ Pizza', Item_price: 600),
  FoodItemModel(
      Item_image: AppPictures.pizza7,
      Item_name: 'Veggie Pizza',
      Item_price: 700),
];

List<FoodItemModel> IcecreamList = [
  FoodItemModel(
      Item_image: AppPictures.icecream2,
      Item_name: 'Icecream',
      Item_price: 1000),
  FoodItemModel(
      Item_image: AppPictures.icecream3,
      Item_name: 'Icecream',
      Item_price: 1000),
  FoodItemModel(
      Item_image: AppPictures.icecream4,
      Item_name: 'Icecream',
      Item_price: 1000),
  FoodItemModel(
      Item_image: AppPictures.icecream5,
      Item_name: 'Icecream',
      Item_price: 1000),
  FoodItemModel(
      Item_image: AppPictures.icecream6,
      Item_name: 'Icecream',
      Item_price: 1000),
  FoodItemModel(
      Item_image: AppPictures.icecream7,
      Item_name: 'Icecream',
      Item_price: 1000),
];

List<FoodItemModel> AddOn = [
  FoodItemModel(
      Item_image: AppPictures.Additem1, Item_name: 'Cheese', Item_price: 60),
  FoodItemModel(
      Item_image: AppPictures.Additem2, Item_name: 'Ketchup', Item_price: 100),
  FoodItemModel(
      Item_image: AppPictures.Additem3, Item_name: 'Mayo', Item_price: 100),
];
