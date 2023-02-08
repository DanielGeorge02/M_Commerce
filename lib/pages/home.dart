import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:m_commerce/pages/Favorites.dart';
import 'package:m_commerce/pages/cart.dart';
import 'package:m_commerce/pages/homepage.dart';
import "package:m_commerce/pages/Myorder.dart";
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController pageController = PageController();
  int index = 0;

  var IconDataProperty = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //       onPressed: () {
      //         pageController.animateToPage(--index,
      //             duration: Duration(milliseconds: 400),
      //             curve: Curves.linearToEaseOut);
      //       },
      //       icon: Icon(Icons.arrow_back)),
      //   centerTitle: true,
      //   title: Text(temptitle),
      // ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Homepage(),
          Favorites(),
          Cart(),
          MyOrder(),
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        backgroundColor: Colors.white, //backgroundcolor of curve
        color: Colors.grey.shade900,
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

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.5)),
      //   ]),
      //   child: GNav(
      //       selectedIndex: index,
      //       tabBorderRadius: 15,
      //       // tabActiveBorder: Border.all(color: Colors.black, width: 1),
      //       curve: Curves.linearToEaseOut,
      //       duration: const Duration(milliseconds: 500),
      //       activeColor: Colors.grey.shade500, //selected navbar icon color
      //       color: Colors.black, //unselected navbar icon color
      //       iconSize: 24,
      //       tabBackgroundColor: Colors.grey.withOpacity(0.3),
      //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      //       tabs: [
      //         GButton(
      //           icon: Icons.home,
      //           text: "Home",
      //           onPressed: () {
      //             index = 0;
      //             pageController.animateToPage(index,
      //                 duration: const Duration(milliseconds: 500),
      //                 curve: Curves.linear);
      //           },
      //         ),
      //         GButton(
      //           icon: Icons.favorite,
      //           text: "Favorites",
      //           onPressed: () {
      //             index = 1;
      //             pageController.animateToPage(index,
      //                 duration: const Duration(milliseconds: 500),
      //                 curve: Curves.linear);
      //           },
      //         ),
      //         GButton(
      //             icon: Icons.search,
      //             text: "Search",
      //             onPressed: () {
      //               index = 2;
      //               pageController.animateToPage(index,
      //                   duration: const Duration(milliseconds: 500),
      //                   curve: Curves.linear);
      //             }),
      //         GButton(
      //           icon: Icons.person,
      //           text: "profile",
      //           onPressed: () {
      //             index = 3;
      //             pageController.animateToPage(index,
      //                 duration: const Duration(milliseconds: 500),
      //                 curve: Curves.linear);
      //           },
      //         )
      //       ]),
    );
  }
}
