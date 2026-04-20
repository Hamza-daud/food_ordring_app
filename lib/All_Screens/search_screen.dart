import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Search',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: AppColor.lightgrey,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
