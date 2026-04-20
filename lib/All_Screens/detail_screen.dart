import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/cart_screen.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/models/dish_model.dart';
import 'package:food_ordering_app/models/food_item_model.dart';

class DetailScreen extends StatefulWidget {
  DishModel foodItemModel;

  DetailScreen({super.key, required this.foodItemModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  int index = 1;

  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          //main container in which picture will  be there
          Container(
            height: sh,
            width: sw,
            color: AppColor.mainColor,
          ),
          //main picture
          Positioned(
              top: 45,
              child: Center(
                child: Container(
                  height: sw * 0.5,
                  width: sw,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Image.network(
                    widget.foodItemModel.dishimage,
                    fit: BoxFit.contain,
                  ),
                ),
              )),
          Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios))),
          //secondary container
          ///........................................................................
          Positioned(
            top: 270,
            child: Container(
              height: sh,
              width: sw,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(70))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: sh * 0.050,
                              width: sw * 0.22,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade600,
                                    ),
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              )),
                          Text(
                            'Rs.${widget.foodItemModel.dishprice}',
                            style: TextStyle(
                                color: Color(
                                  0xffC9CC45,
                                ),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.foodItemModel.dishname,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: sh * 0.10,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (index > 1) {
                                      index--;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColor.mainColor,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$index',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (index < 5) {
                                      index++;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: AppColor.mainColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        "${widget.foodItemModel.DishDiscripition}",
                        style: TextStyle(color: Color(0xffA7A1A1)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Add On',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      //Adds items
                      SizedBox(
                        height: sh * 0.19,
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: AddOn.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    clipBehavior: Clip.none,
                                    decoration: BoxDecoration(
                                        color: Color(0xffD3C7DF6E),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                        child: Image.asset(
                                            AddOn[index].Item_image)),
                                  ),
                                  Positioned(
                                    right: -10,
                                    bottom: 1,
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                      // Add to cart button
                      SizedBox(
                        height: sh * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          // cartListItems.add(widget.foodItemModel);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen(
                                      price: widget.foodItemModel.dishprice,
                                      quantity: index)));
                        },
                        child: Container(
                          height: sh * 0.09,
                          width: sw * 0.8,
                          decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
