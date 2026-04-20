import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/cart_data.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/All_Screens/mian_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  Future<void> placeOrder() async {
    if (cartListItems.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      final orderId = FirebaseFirestore.instance.collection("Orders").doc().id;

      int totalPrice = 0;

      for (var item in cartListItems) {
        totalPrice += item.price * item.quantity;
      }

      await FirebaseFirestore.instance.collection("Orders").doc(orderId).set({
        "orderId": orderId,
        "userId": user!.uid,
        "items": cartListItems
            .map((e) => {
                  "name": e.name,
                  "price": e.price,
                  "quantity": e.quantity,
                  "image": e.image,
                })
            .toList(),
        "totalPrice": totalPrice,
        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      // CLEAR CART
      cartListItems.clear();

      setState(() {
        isLoading = false;
      });

      // NAVIGATE TO MAIN SCREEN
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Text(
              'Your Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: cartListItems.length,
                itemBuilder: (context, index) {
                  final item = cartListItems[index];

                  return Card(
                    child: ListTile(
                      leading: Image.network(item.image),
                      title: Text(item.name),
                      subtitle: Text("Rs ${item.price * item.quantity}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (item.quantity > 1) {
                                  item.quantity--;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text("${item.quantity}"),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // TOTAL
            Text(
              "Total: Rs ${countTotal()}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // PLACE ORDER BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.mainColor,
                ),
                onPressed: isLoading ? null : placeOrder,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Place Order",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  int countTotal() {
    int total = 0;

    for (var item in cartListItems) {
      total += item.price * item.quantity;
    }

    return total;
  }
}
