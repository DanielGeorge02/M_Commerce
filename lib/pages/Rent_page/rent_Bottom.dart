// ignore_for_file: file_names, implementation_imports, camel_case_types, non_constant_identifier_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/pages/Rent_page/rent_favorite.dart';
import 'package:m_commerce/pages/Rent_page/rent_homepage.dart';
import 'package:m_commerce/pages/Rent_page/rent_myproducts.dart';

class Rent_BottomNav extends StatefulWidget {
  const Rent_BottomNav({super.key});

  @override
  State<Rent_BottomNav> createState() => _Rent_BottomNavState();
}

class _Rent_BottomNavState extends State<Rent_BottomNav> {
  late PageController pageController = PageController();
  int index = 0;

  var IconDataProperty = const Rent_BottomNav();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          Rent_homepage(),
          Rent_favorite(),
          Rent_myproducts(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.amber,
        index: index,
        height: 65,
        backgroundColor: Colors.white, //backgroundcolor of curve
        color: const Color.fromARGB(198, 0, 0, 0),
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
            Icons.person,
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
