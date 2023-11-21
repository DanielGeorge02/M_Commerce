// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:animated_background/animated_background.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Rent_page/rent_SeeAll.dart';
import 'package:m_commerce/pages/Rent_page/rent_post.dart';

import '../home/home.dart';

class Rent_homepage extends StatefulWidget {
  const Rent_homepage({super.key});

  @override
  State<Rent_homepage> createState() => _Rent_homepageState();
}

List carousel = [
  "https://ezo.io/wp-content/uploads/2021/11/EZR-rental-discounts-1-1024x512.jpg",
  "https://5.imimg.com/data5/SELLER/Default/2022/10/PS/LV/YJ/34867514/laptop-rental-service-500x500.jpeg",
  "https://primexnewsnetwork.com/wp-content/uploads/2022/12/second-image-28.jpg"
];

// ignore: camel_case_types
class _Rent_homepageState extends State<Rent_homepage>
    with TickerProviderStateMixin {
  final PageController pageController = PageController();
  int index = 0;

  Widget _buildCategory({required String name, required String photo}) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 4,
      child: SizedBox(
        height: 160,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // height: 140,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "images/$photo",
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 8,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(198, 0, 0, 0),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        toolbarHeight: height * 0.1,
        backgroundColor: const Color.fromARGB(232, 255, 255, 255),
        title: GestureDetector(
          onTap: () {},
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromARGB(55, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  child: const Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Text(
                          "Search Products...",
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ),
                    ),
                  ])),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: CarouselSlider(
                items: carousel
                    .map(
                      (item) => Center(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 1000,
                          imageUrl: item,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            decoration: const BoxDecoration(
              color: Colors.amberAccent,
            ),
            child: AnimatedBackground(
                behaviour: RandomParticleBehaviour(
                    options: const ParticleOptions(
                  spawnMaxRadius: 20,
                  spawnMinSpeed: 50,
                  particleCount: 50,
                  spawnMaxSpeed: 80,
                  minOpacity: 0.7,
                  maxOpacity: 0.9,
                  baseColor: Colors.white,
                )),
                vsync: this,
                child: Center(
                  child: Text(
                    "Rent Products",
                    style: GoogleFonts.bungeeShade(
                        fontSize: 35, fontWeight: FontWeight.w800),
                  ),
                )),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.03),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Category",
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Rent_SeeAll()));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      //no splash for textbutton
                      (states) => Colors.transparent),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text(
                  "See All >",
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategory(photo: "rent_laptop.jpg", name: "Laptops"),
                _buildCategory(photo: "rent_mobile.png", name: "Mobiles"),
                _buildCategory(photo: "rent_fashion.png", name: "Fashion"),
                _buildCategory(photo: "rent_computer.jpeg", name: "Computers"),
                _buildCategory(
                    photo: "rent_washingmachine.png", name: "Washing Machine"),
                _buildCategory(photo: "rent_fridge.png", name: "Fridge"),
                _buildCategory(photo: "rent_TV.jpg", name: "TV"),
                _buildCategory(photo: "rent_bike.jpg", name: "Bike"),
                _buildCategory(photo: "rent_home.png", name: "Home"),
                _buildCategory(photo: "rent_cycle.jpeg", name: "Cycle"),
                _buildCategory(photo: "rent_car.jpeg", name: "Car"),
                _buildCategory(
                    photo: "rent_other.jpg", name: "Other Electronics"),
                _buildCategory(photo: "rent_van.jpeg", name: "Van"),
                _buildCategory(photo: "rent_bus.jpeg", name: "Bus"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 30,
        label: const Text("Upload", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.amber[600],
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Rent_post()));
        },
      ),
    );
  }
}
