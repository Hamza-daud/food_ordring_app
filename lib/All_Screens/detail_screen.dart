import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/cart_screen.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/models/dish_model.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/cart_data.dart';

class DetailScreen extends StatefulWidget {
  final DishModel foodItemModel;

  const DetailScreen({super.key, required this.foodItemModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          // 🔵 TOP IMAGE SECTION
          Container(
            height: sh * 0.45,
            width: sw,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Center(
                  child: Hero(
                    tag: widget.foodItemModel.dishimage,
                    child: Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(widget.foodItemModel.dishimage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔵 DETAILS SECTION
          Expanded(
            child: Container(
              width: sw,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME + PRICE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.foodItemModel.dishname,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs ${widget.foodItemModel.dishprice}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.foodItemModel.DishDiscripition,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // QUANTITY
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text(
                        "$quantity",
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // 🔵 ADD TO CART BUTTON (FIXED VISIBILITY)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        final cartItem = CartModel(
                          id: widget.foodItemModel.id,
                          name: widget.foodItemModel.dishname,
                          price: widget.foodItemModel.dishprice,
                          image: widget.foodItemModel.dishimage,
                          quantity: quantity,
                        );

                        cartListItems.add(cartItem);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Add To Cart",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
