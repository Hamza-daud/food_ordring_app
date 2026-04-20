import 'package:flutter/material.dart';

import 'package:food_ordering_app/All_Screens/mian_screen.dart';
import 'package:food_ordering_app/helper/colors.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.sizeOf(context).height;
    double sw = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: sh,
        width: sw,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColor.mainColor.withOpacity(0.98),
              AppColor.purple.withOpacity(0.69)
            ])),
        child: Column(
          children: [
            SizedBox(
              height: sh * 0.1,
            ),
            Container(
              height: sh * 0.40,
              width: sw * 0.60,
              decoration:
                  BoxDecoration(color: AppColor.white, shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  'assets/pictures/All.png',
                  height: 230,
                ),
              ),
            ),
            SizedBox(
              height: sh * 0.05,
            ),
            Text(
              '\t\t\t\tEnjoy\nYour Food',
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: sh * 0.05,
            ),
            Container(
              height: sh * 0.08,
              width: sw * 0.7,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        color: AppColor.darkpurple.withOpacity(0.98),
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
