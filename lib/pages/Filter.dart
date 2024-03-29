// ignore_for_file: must_be_immutable, file_names, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/viewproduct.dart';

class Filters extends StatefulWidget {
  Filters({super.key, required this.category, required this.city});
  var category;
  var city;
  @override
  State<Filters> createState() => _FilterState();
}

class _FilterState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
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
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                const Text("   "),
                Text(
                  widget.city.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Seller_req")
                    .doc("A3YtV51DsJGf7ruoFV6x")
                    .collection("item")
                    .where("city", isEqualTo: widget.city)
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
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.63),
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
                                          color: documentSnapshot['Colour'],
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
                                    borderRadius: BorderRadius.circular(13)),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 160,
                                        color: Colors.white,
                                        child: CachedNetworkImage(
                                          imageUrl: documentSnapshot["image"],
                                        )),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 75,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(documentSnapshot[
                                            "PnameController"]),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
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
                                                text: '\u{20B9}' +
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
                }),
          )
        ]));
  }
}
