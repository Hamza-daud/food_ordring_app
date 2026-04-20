import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/colors.dart';
import 'package:food_ordering_app/models/category_model.dart';

class HomeItemScreen extends StatelessWidget {
  CategoryModel categoryModel;
  HomeItemScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 40,
        title: Text(
          categoryModel.category_name,
          style: TextStyle(
              fontFamily: 'Popppins',
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: AppColor.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TextField
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 15),
              child: SizedBox(
                height: sh * 0.07,
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: AppColor.lightgrey,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ),
            //Category Item Container
            SizedBox(
              height: sh * 0.04,
            ),
            Column(
              children: [
                Container(
                  height: sh * 0.1,
                  width: sw * 0.17,
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(categoryModel.categroy_image),
                ),
                Text(
                  categoryModel.category_name,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: AppColor.grey),
                ),
              ],
            ),
            // Category Item List
            SizedBox(
              height: sh * 0.05,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 3,
                    crossAxisCount: 3,
                    childAspectRatio: 0.6),
                itemCount: categoryModel.item.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DetailScreen(
                          //             foodItemModel:
                          //                 categoryModel.item[index])));
                        },
                        child: Container(
                          height: sh * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(colors: [
                                Color(0xff7E3EBE37).withOpacity(0.21),
                                Color(0xff7E3EBE2F).withOpacity(0.18)
                              ])),
                          child: Image.network(
                              categoryModel.item[index].Item_image),
                        ),
                      ),
                      Text(
                        categoryModel.item[index].Item_name,
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Rs.${categoryModel.item[index].Item_price}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: AppColor.green),
                      )
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
