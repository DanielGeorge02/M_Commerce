// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:m_commerce/pages/cart_favorite/cart_and_favorite/Favorites.dart';
import 'package:m_commerce/pages/cart_favorite/cart_and_favorite/cart.dart';
import 'package:m_commerce/pages/home/homepage.dart';
import 'package:m_commerce/pages/MyProduct.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController pageController = PageController();
  int index = 0;

  var IconDataProperty = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          Homepage(),
          Favorites(),
          Cart(),
          MyProduct(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.amber,
        index: index,
        height: 65,
        backgroundColor: Colors.white, //backgroundcolor of curve
        color: Colors.amber,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.category,
            size: 30,
            color: Colors.white,
          )
        ],
        onTap: ((value) => setState(() {
              index = value;
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            })),
      ),
    );
  }
}
