
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/viewproduct.dart';


class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

double add = 0;
double tot = add + 300;

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int i = 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
        title: Text("My Cart",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "images/cart1.png",
              color: Colors.white.withOpacity(0.3),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                  width: 430,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("cart_item")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("item")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      try {
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(''),
                          );
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.5,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewProduct(
                                                        New: documentSnapshot[
                                                            'PpriceController'],
                                                        des: documentSnapshot[
                                                            'PdesController'],
                                                        image: documentSnapshot[
                                                            'image'],
                                                        name: documentSnapshot[
                                                            'PnameController'],
                                                        old: documentSnapshot[
                                                            'MrpController'],
                                                        addr: documentSnapshot[
                                                            'AddrController'],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Card(
                                            margin:
                                                const EdgeInsets.only(top: 0),
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      CachedNetworkImageProvider(
                                                                    documentSnapshot[
                                                                        'image'],
                                                                  ),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                    )),
                                                    Expanded(
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                          Text(
                                                            documentSnapshot[
                                                                'PnameController'],
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          const SizedBox(
                                                            height: 40,
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                            child: Text(
                                                              // ignore: prefer_interpolation_to_compose_strings
                                                              ' \u{20B9}' +
                                                                  documentSnapshot[
                                                                      'PpriceController'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ])),
                                                    Container(
                                                      height: 120,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "cart_item")
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .email)
                                                                    .collection(
                                                                        "item")
                                                                    .doc(
                                                                        documentSnapshot
                                                                            .id)
                                                                    .delete();
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            16),
                                                                    height: 60,
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(20))),
                                                                    child:
                                                                        const Text(
                                                                      "Item removed from cart!!",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  elevation: 0,
                                                                ));
                                                              },
                                                              icon:
                                                                  const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            28.0),
                                                                child: Icon(
                                                                  Icons.cancel,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                      return Container();
                    }),
              ],
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("cart_item")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("item")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                try {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No items'),
                    );
                  } else {
                    add = 0;
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[i];
                      add = add +
                          double.parse(documentSnapshot['PpriceController']!);
                    }
                    return Positioned(
                        bottom: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            width: width * 0.9,
                            height: 120,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 222, 162),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Price',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        ' \u{20B9}$add',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const [
                                      Text(
                                        "Delivery Charges",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 0,
                                      ),
                                      Text(' \u{20B9}' "300"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Total Amount",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        ' \u{20B9}$tot',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  }
                } catch (e) {
                  print(e);
                }
                return Container();
              }),
        ],
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                extendedSizeConstraints:
                    BoxConstraints.tightFor(height: 60, width: 345))),
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("PROCEED TO BUY"),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
