import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce_app/pages/Order.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/profile.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;

  late HomePage Home;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    
    Home = HomePage();
    order = Order();
    profile = Profile();

    pages = [Home, order, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Color(0xfff2f2f2),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
        Icon(
          Icons.home_outlined, 
          color: Colors.white,
          ),
          Icon(
          Icons.shopping_cart_outlined, 
          color: Colors.white,
          ),
          Icon(
          Icons.person_outline, 
          color: Colors.white,
          )
        ]),
        body: pages[currentTabIndex],
    );
  }
}