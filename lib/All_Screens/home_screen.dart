import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/detail_screen.dart';
import 'package:food_ordering_app/All_Screens/home_item_page.dart';
import 'package:food_ordering_app/helper/app_pictures.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/models/category_model.dart';
import 'package:food_ordering_app/models/dish_model.dart';
import 'package:food_ordering_app/models/food_item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Menu',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: sh * 0.09,
                width: sw * 0.2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/pictures/profile.png',
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //..................................................................text For permotion
                SizedBox(
                  height: sh * 0.01,
                ),
                //promotion Text
                const Text(
                  'Promotions',
                  style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
                ),
                //....................................................promotion container
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.none,
                      width: sw * 0.9,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            const Color(0xff7E3EBEEB).withOpacity(0.92),
                            const Color(0xff7E3EBEEB).withOpacity(0.55)
                          ])),
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: 'Todays Offers',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        TextSpan(
                            text: '\n\nFree Box Of Fries',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '\n\non all order above Rs.599',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ])),
                    ),
                    Positioned(
                      right: -5,
                      top: -8,
                      child: Image.asset(
                        'assets/pictures/fries.png',
                        height: 130,
                        width: 150,
                      ),
                    )
                  ],
                ),
                //................................................................................all iteam
                SizedBox(
                  height: sh * 0.01,
                ),
                const Text(
                  'All Items',
                  style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
                ),
                // popular item
                SizedBox(
                  height: sh * 0.01,
                ),
                //..................................................................grid view
                StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection("Dishes").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // Error
                      if (snapshot.hasError) {
                        return Center(child: Text("Error loading dishes"));
                      }

                      // No Data
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No dishes found"));
                      }

                      final dishes = snapshot.data!.docs.map((doc) {
                        return DishModel.fromMap(
                            doc.data() as Map<String, dynamic>);
                      }).toList();

                      return GridView.builder(
                        itemCount: dishes.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final dish = dishes[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailScreen(foodItemModel: dish)))),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xff7E3EBE2D)
                                            .withOpacity(0.17),
                                        const Color(0xff7E3EBE2D)
                                            .withOpacity(0.21)
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: sw * 0.25,
                                      width: sw,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          dish.dishimage,
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(dish.dishname,
                                        style: TextStyle(fontSize: 20)),
                                    Text(
                                      dish.dishprice.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff626C23),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}

//Category List
// SizedBox(
//   height: sh * 0.15,
//   child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       itemCount: CategoryItem.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//                 clipBehavior: Clip.hardEdge,
//                 height: sh * 0.10,
//                 width: sw * 0.20,
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Color(0xffD3C7DF6E).withOpacity(0.48),
//                           Color(0xff7E3EBE00).withOpacity(0.0)
//                         ]),
//                     borderRadius: BorderRadius.circular(15)),
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   HomeItemScreen(
//                                       categoryModel:
//                                           CategoryItem[
//                                               index])));
//                     },
//                     child: Image.asset(
//                         CategoryItem[index].categroy_image)),
//               ),
//             ),
//             Text(
//               CategoryItem[index].category_name,
//               style: TextStyle(
//                   fontSize: 14,
//                   color: AppColor.grey,
//                   fontFamily: 'Poppins'),
//             )
//           ],
//         );
//       }),
// ),

// Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xff7E3EBE2D).withOpacity(0.17),
//                 Color(0xff7E3EBE2D).withOpacity(0.21)
//               ])),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.asset(
//                 AppPictures.pizza2,
//               ),
//             ),
//             SizedBox(
//               height: sh * 0.04,
//             ),
//             Text(
//               'Chesse Pizza',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               'Rs.200',
//               style: TextStyle(
//                   fontSize: 20,
//                   color: Color(0xff626C23),
//                   fontWeight: FontWeight.bold),
//             )
//           ],
//         ),
//       ),
//     )
