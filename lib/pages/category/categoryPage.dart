// ignore_for_file: must_be_immutable, file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Filter.dart';

import '../viewproduct.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({super.key, this.category, this.slider, this.city});
  var category;
  var slider;
  var city;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? city;
  String? state;
  Future<void> showFilter() async {
    double width = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location'),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Location",
                      style: TextStyle(fontSize: 15),
                    )),
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: CSCPicker(
                    layout: Layout.vertical,
                    defaultCountry: CscCountry.India,
                    disableCountry: true,
                    onCountryChanged: (Country) {},
                    onStateChanged: (state) {
                      setState(() {
                        this.state = state;
                      });
                    },
                    onCityChanged: (city) {
                      setState(() {
                        this.city = city.toString();
                      });
                    },
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",
                  ),
                ),
              ]),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Filters(
                                category: widget.category,
                                city: city.toString(),
                              )));
                },
                child: const Text("Apply")),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection("Seller_req");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.black,
              )),
          automaticallyImplyLeading: false,
          toolbarHeight: height * 0.1,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
          title: Text(widget.category,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.w500,
              )),
        ),
        body: Column(children: [
          Container(
            height: height * 0.1,
            color: const Color.fromARGB(255, 209, 207, 207),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.city,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const Icon(Icons.keyboard_double_arrow_right_sharp),
                ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      showFilter();
                    },
                    icon: const Icon(
                      Icons.filter_alt_sharp,
                    ),
                    label: const Text("Filter"))
              ],
            ),
          ),
          SizedBox(
            height: height * 0.23,
            width: width * 1,
            child: CarouselSlider(
                items: widget.slider
                    .map<Widget>(
                      (item) => Padding(
                        padding: EdgeInsets.symmetric(vertical: width * 0.05),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: item,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                )),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: users.doc("Products").collection("item").get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No videos Uplaoded"));
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.73),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      if (widget.category ==
                          documentSnapshot['categoryController']) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProduct(
                                        color: documentSnapshot['Colour'],
                                        currentuser: FirebaseAuth
                                            .instance.currentUser!.email
                                            .toString(),
                                        email: documentSnapshot["email"],
                                        New: documentSnapshot[
                                            'PpriceController'],
                                        des: documentSnapshot['PdesController'],
                                        image: documentSnapshot['image'],
                                        name:
                                            documentSnapshot['PnameController'],
                                        old: documentSnapshot['MrpController'],
                                        addr:
                                            documentSnapshot['AddrController'],
                                        shop:
                                            documentSnapshot['SnameController'],
                                        quan: documentSnapshot[
                                            'QuantityController'],
                                        type: documentSnapshot['Ptype']))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.01,
                                left: width * 0.02,
                                right: width * 0.02,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(13)),
                                child: Column(
                                  children: [
                                    Container(
                                        height: height * 0.18,
                                        color: Colors.white,
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  documentSnapshot["image"],
                                            ),
                                            documentSnapshot["Ptype"] == 'New'
                                                ? SvgPicture.asset(
                                                    "images/new.svg")
                                                : SvgPicture.asset(
                                                    "images/used.svg")
                                          ],
                                        )),
                                    Container(
                                      alignment: Alignment.center,
                                      height: height * 0.08,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03),
                                        child: Text(documentSnapshot[
                                            "PnameController"]),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              text: '\u{20B9}' +
                                                  documentSnapshot[
                                                      "MrpController"],
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            ),
                                            TextSpan(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                text: '  \u{20B9}' +
                                                    documentSnapshot[
                                                        "PpriceController"],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }
                      return null;
                    },
                  );
                }
              },
            ),
          )
        ]));
  }
}
