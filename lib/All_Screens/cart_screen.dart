import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/models/cart_model.dart';
import 'package:food_ordering_app/models/food_item_model.dart';

class CartScreen extends StatefulWidget {
  int quantity;
  int price;
  // FoodItemModel foodItemModel;
  CartScreen({
    super.key,
    required this.price,
    required this.quantity,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Text of items in cart
            Text(
              'Items in Cart',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            //List of items
            SizedBox(
              height: sh * 0.5,
              child: ListView.builder(
                  itemCount: cartListItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Container(
                            width: sw * 0.3,
                            height: sh * 0.2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xffD3C7DF6E).withOpacity(0.43),
                                      Color(0xff7E3EBE00).withOpacity(0.1),
                                    ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                                '${cartListItems[index].Item_image}'),
                          ),
                          //All text
                          Column(
                            children: [
                              Text(
                                '${cartListItems[index].Item_name}',
                                style: TextStyle(
                                    fontFamily: 'Poopins', fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Rs.${cartListItems[index].Item_price * widget.quantity}',
                                style: TextStyle(
                                    fontFamily: 'Poopins', fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (widget.quantity > 1) {
                                          widget.quantity--;
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
                                    '${widget.quantity}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (widget.quantity < 5) {
                                          widget.quantity++;
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
                          //Remove Button
                          Spacer(),
                          InkWell(
                            onTap: () {
                              cartListItems.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            //Text order innstruction
            Text(
              'Order Instructions',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            //Instruction textfeild
            TextField(
              maxLength: 500,
              decoration: InputDecoration(
                  hintText: 'Order Instruction',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            //Order Total
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '${counttotalprice()}',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColor.green),
                ),
              ],
            ),
            //Checkout Button
            SizedBox(
              height: 5,
            ),
            Container(
              height: sh * 0.07,
              width: sw * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.mainColor,
              ),
              child: Center(
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: AppColor.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            //Text Back to menu
            SizedBox(
              height: 5,
            ),
            Text(
              'Back to menu',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }

  int counttotalprice() {
    int totalpricenew = 0;
    for (var i in cartListItems) {
      totalpricenew += i.Item_price * widget.quantity;
    }
    return totalpricenew;
  }
}
