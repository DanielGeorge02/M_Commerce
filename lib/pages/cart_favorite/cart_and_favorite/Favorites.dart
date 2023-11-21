// ignore_for_file: file_names, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/viewproduct.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
        title: Text("Favorite",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 29,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Favorite_item")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("item")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              try {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No items'),
                  );
                } else {
                  return SizedBox(
                    height: height,
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProduct(
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
                                        )));
                          },
                          child: Card(
                            elevation: 5,
                            child: Column(children: [
                              Stack(children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            documentSnapshot['image'],
                                          ),
                                          fit: BoxFit.contain)),
                                ),
                                IconButton(
                                    padding: const EdgeInsets.only(left: 150),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Favorite_item")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("item")
                                          .doc(documentSnapshot.id)
                                          .delete();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 60,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: const Text(
                                            "Item removed from Favorite!!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ));
                                    },
                                    icon: const Icon(Icons.cancel)),
                              ]),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Text(
                                        documentSnapshot['PnameController']
                                                    .length >
                                                50
                                            ? documentSnapshot[
                                                        'PnameController']
                                                    .substring(0, 20) +
                                                '...'
                                            : documentSnapshot[
                                                'PnameController'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 48,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          documentSnapshot['PdesController']
                                                      .length >
                                                  50
                                              ? documentSnapshot[
                                                          'PdesController']
                                                      .substring(0, 53) +
                                                  '...'
                                              : documentSnapshot[
                                                  'PdesController'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          text: '\u{20B9}' +
                                              documentSnapshot['MrpController'],
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 13,
                                              color: Colors.grey)),
                                      TextSpan(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          text: ' \u{20B9}' +
                                              documentSnapshot[
                                                  'PpriceController'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 72, 179, 75))),
                                    ])),
                                  ],
                                ),
                              )),
                            ]),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              crossAxisSpacing: 5),
                    ),
                  );
                }
              } catch (e) {
                print(e);
              }
              return Container();
            }),
      ),
    );
  }
}
