// ignore_for_file: must_be_immutable, file_names, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Rent_page/rent_category.dart';
import 'package:m_commerce/pages/Rent_page/rent_homepage.dart';

class Rent_SeeAll extends StatefulWidget {
  Rent_SeeAll({super.key, this.Category});
  var Category;
  @override
  State<Rent_SeeAll> createState() => _Rent_SeeAllState();
}

class _Rent_SeeAllState extends State<Rent_SeeAll> {
  Widget _buildCategory({required String name, required String photo}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Rent_category(category: name)));
      },
      child: Card(
        shadowColor: Colors.grey,
        elevation: 4,
        child: SizedBox(
          height: 220,
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 231, 192),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Rent_homepage()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 23,
            color: Colors.black,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        title: Text("Category",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          color: const Color.fromARGB(255, 244, 231, 192),
          child: GridView(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
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
      ),
    );
  }
}
