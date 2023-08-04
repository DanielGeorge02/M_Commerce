import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Filter.dart';

import '../viewproduct.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({this.category, this.slider, this.city});
  var category;
  var slider;
  var city;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? city;
  String? state;
  Future<void> showFilter() async {
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
                  padding: const EdgeInsets.all(8.0),
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
                          builder: (context) => Filter(
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

  @override
  Widget build(BuildContext context) {
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
          toolbarHeight: 70,
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
            height: 80,
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
            height: 200,
            width: 410,
            child: CarouselSlider(
                items: widget.slider
                    .map<Widget>(
                      (item) => Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: item,
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Seller_req")
                    .doc("Products")
                    .collection("item")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.69),
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      if (widget.category ==
                          documentSnapshot['categoryController']) {
                        // ignore: curly_braces_in_flow_control_structures
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProduct(
                                          currentuser: FirebaseAuth
                                              .instance.currentUser!.email
                                              .toString(),
                                          email: documentSnapshot["email"],
                                          New: documentSnapshot[
                                              'PpriceController'],
                                          des: documentSnapshot[
                                              'PdesController'],
                                          image: documentSnapshot['image'],
                                          name: documentSnapshot[
                                              'PnameController'],
                                          old:
                                              documentSnapshot['MrpController'],
                                          addr: documentSnapshot[
                                              'AddrController'],
                                          shop: documentSnapshot[
                                              'SnameController'],
                                          quan: documentSnapshot[
                                              'QuantityController'],
                                          type: documentSnapshot['Ptype'],
                                          colour: documentSnapshot['Colour'],
                                        ))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 2, right: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(17)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 12, left: 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                            height: 200,
                                            width: 190,
                                            color: Colors.pink,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  documentSnapshot["image"],
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      // color: Colors.red,
                                      child: Text(
                                          documentSnapshot["PnameController"]),
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
                    },
                  );
                }),
          )
        ]));
  }
}
