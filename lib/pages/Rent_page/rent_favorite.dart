// ignore_for_file: camel_case_types, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/Rent_page/rent_viewproduct.dart';

class Rent_favorite extends StatefulWidget {
  const Rent_favorite({super.key});

  @override
  State<Rent_favorite> createState() => _Rent_favoriteState();
}

class _Rent_favoriteState extends State<Rent_favorite> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("Favorite_item")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("rent")
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              try {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No items'),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: height * 0.75,
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
                                  builder: (context) => Rent_viewproduct(),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: height * 0.23,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              documentSnapshot['image'],
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        padding:
                                            EdgeInsets.only(left: width * 0.39),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Favorite_item")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.email)
                                              .collection("rent")
                                              .doc(documentSnapshot.id)
                                              .delete();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                height: 60,
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Item removed from Favorite!!",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.cancel),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                            ),
                                            child: Text(
                                              documentSnapshot[
                                                              'PnameController']
                                                          .length >
                                                      50
                                                  ? documentSnapshot[
                                                              'PnameController']
                                                          .substring(0, 20) +
                                                      '...'
                                                  : documentSnapshot[
                                                      'PnameController'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                documentSnapshot[
                                                                'PdesController']
                                                            .length >
                                                        50
                                                    ? documentSnapshot[
                                                                'PdesController']
                                                            .substring(0, 53) +
                                                        '...'
                                                    : documentSnapshot[
                                                        'PdesController'],
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: ' \u{20B9}' +
                                                      documentSnapshot[
                                                          'onedayController'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255, 72, 179, 75),
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: "/one day",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 5,
                        ),
                      ),
                    );
                  }
                }
                // Handle other connection states
                return const CircularProgressIndicator(
                  color: Colors.amber,
                ); // Or any other loading indicator
              } catch (e) {
                print(e);
                return Container();
              }
            },
          )),
    );
  }
}
