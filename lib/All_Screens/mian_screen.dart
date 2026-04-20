import 'package:flutter/material.dart';
import 'package:food_ordering_app/All_Screens/cart_screen.dart';
import 'package:food_ordering_app/All_Screens/home_screen.dart';
import 'package:food_ordering_app/All_Screens/profile_screen.dart';
import 'package:food_ordering_app/All_Screens/search_screen.dart';
import 'package:food_ordering_app/helper/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget getbody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();

      case 1:
        return const SearchScreen();

      case 2:
        return const CartScreen(); // ✅ FIXED (no parameters)

      case 3:
        return ProfileScreen();

      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getbody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: ontapped,
        selectedItemColor: AppColor.mainColor,
        unselectedItemColor: AppColor.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
