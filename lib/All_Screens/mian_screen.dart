import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/cart_screen.dart';
import 'package:food_ordering_app/All_Screens/home_screen.dart';
import 'package:food_ordering_app/All_Screens/search_screen.dart';
import 'package:food_ordering_app/helper/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getbody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: ontapped,
          selectedItemColor: AppColor.mainColor,
          unselectedItemColor: AppColor.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Proflie'),
          ]),
    );
  }

  getbody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return SearchScreen();
        break;
      case 2:
        return CartScreen(
          quantity: index,
          price: 0,
        );
        break;
      case 3:
        return Text('profile');
        break;
      default:
    }
  }
}
