// ignore_for_file: file_names, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m_commerce/pages/update.dart';
import 'package:m_commerce/pages/viewproduct.dart';
import 'package:intl/intl.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

String formattedDate(timestramp) {
  var dateFromTimeStramp =
      DateTime.fromMillisecondsSinceEpoch(timestramp.seconds * 1000);
  return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimeStramp);
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, 'home');
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
        title: Text("My Products",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Seller_req")
                  .doc("A3YtV51DsJGf7ruoFV6x")
                  .collection("item")
                  .where("email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                try {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          LottieBuilder.network(
                              "https://assets5.lottiefiles.com/packages/lf20_sjrrfsoj.json"),
                          const Text("No products found"),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                        color: Colors.white,
                        height: height,
                        child: Column(children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(114, 158, 158, 158),
                              // borderRadius: BorderRadius.circular(35)),
                            ),
                            height: 70,
                            // width: 350,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "No. of products uploaded : ${snapshot.data!.docs.length}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: GridView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.52),
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
                                      onLongPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (cpntext) {
                                              return AlertDialog(
                                                title: const Text("Remove product"),
                                                content: const SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'Are you sure want to remove your product?'),
                                                ],
                                              ),
                                                ),
                                                actions: <Widget>[
                                              TextButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('Yes'),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          "Seller_req")
                                                      .doc(
                                                          "A3YtV51DsJGf7ruoFV6x")
                                                      .collection("item")
                                                      .doc(documentSnapshot
                                                          .id)
                                                      .delete();
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          SnackBar(
                                                    content: Container(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(16),
                                                      height: 60,
                                                      decoration: const BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                                  .circular(
                                                                      20))),
                                                      child: const Text(
                                                        "Item removed!!",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    behavior:
                                                        SnackBarBehavior
                                                            .floating,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                  ));
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Card(
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            Text(
                                              'UPLOADED : ${formattedDate(
                                                  documentSnapshot['date'])}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          alignment:
                                                              Alignment.center,
                                                          image:
                                                              CachedNetworkImageProvider(
                                                            documentSnapshot[
                                                                'image'],
                                                          ),
                                                          fit: BoxFit.contain)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 150),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.amber,
                                                    radius: 20,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Update(
                                                                            addr:
                                                                                documentSnapshot['AddrController'],
                                                                            category:
                                                                                documentSnapshot['categoryController'],
                                                                            city:
                                                                                documentSnapshot['city'],
                                                                            desc:
                                                                                documentSnapshot['PdesController'],
                                                                            email:
                                                                                documentSnapshot['emailController'],
                                                                            gst:
                                                                                documentSnapshot['GstController'],
                                                                            img:
                                                                                documentSnapshot['image'],
                                                                            mrp:
                                                                                documentSnapshot['MrpController'],
                                                                            name:
                                                                                documentSnapshot['SnameController'],
                                                                            number:
                                                                                documentSnapshot['PnoController'],
                                                                            quan:
                                                                                documentSnapshot['QuantityController'],
                                                                            state:
                                                                                documentSnapshot['state'],
                                                                            // shop:
                                                                            //     documentSnapshot['ShopController'],
                                                                            pname:
                                                                                documentSnapshot['PnameController'],
                                                                            price:
                                                                                documentSnapshot['PpriceController'],
                                                                          )));
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child: Text(
                                                      documentSnapshot[
                                                                      'PnameController']
                                                                  .length >
                                                              50
                                                          ? documentSnapshot[
                                                                      'PnameController']
                                                                  .substring(
                                                                      0, 20) +
                                                              '...'
                                                          : documentSnapshot[
                                                              'PnameController'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 48,
                                                    width: 300,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        documentSnapshot[
                                                                        'PdesController']
                                                                    .length >
                                                                50
                                                            ? documentSnapshot[
                                                                        'PdesController']
                                                                    .substring(
                                                                        0, 53) +
                                                                '...'
                                                            : documentSnapshot[
                                                                'PdesController'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                        // ignore: prefer_interpolation_to_compose_strings
                                                        text: '\u{20B9}' +
                                                            documentSnapshot[
                                                                'MrpController'],
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: 13,
                                                            color:
                                                                Colors.grey)),
                                                    TextSpan(
                                                        // ignore: prefer_interpolation_to_compose_strings
                                                        text: ' \u{20B9}' +
                                                            documentSnapshot[
                                                                'PpriceController'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    72,
                                                                    179,
                                                                    75))),
                                                  ])),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ]));
                  }
                } catch (e) {
                  print(e);
                }
                return Container();
              },
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
