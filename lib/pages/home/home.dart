// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_commerce/pages/cart_favorite/cart_and_favorite/Favorites.dart';
import 'package:m_commerce/pages/cart_favorite/cart_and_favorite/cart.dart';
import 'package:m_commerce/pages/home/chatlobby.dart';
import 'package:m_commerce/pages/home/homepage.dart';
import 'package:m_commerce/pages/MyProduct.dart';
import 'package:m_commerce/pages/login/userType.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController pageController = PageController();
  int index = 0;

  var IconDataProperty = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: ref.read(userTypeProvider) == "Customer"
              ? const <Widget>[
                  Homepage(),
                  ChatLobby(),
                  Favorites(),
                  Cart(),
                  // MyProduct(),
                ]
              : const <Widget>[
                  Homepage(),
                  ChatLobby(),
                  MyProduct(),
                ]),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.amber,
        index: index,
        height: 65,
        backgroundColor: Colors.transparent,
        color: Colors.amber,
        items: ref.read(userTypeProvider) == "Customer"
            ? const [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                Icon(
                  Icons.chat,
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
              ]
            : const [
                Icon(
                  Icons.home,
                  size: 30,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                Icon(
                  Icons.chat,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.category,
                  size: 30,
                  color: Colors.white,
                ),
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
