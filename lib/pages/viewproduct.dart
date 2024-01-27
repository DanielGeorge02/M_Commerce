// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m_commerce/pages/chat.dart';
import 'package:m_commerce/pages/home/Search.dart';
import 'package:m_commerce/pages/shoppage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewProduct extends StatefulWidget {
  var image;
  var name;
  var des;
  var old;
  var New;
  var addr;
  var quan;
  var email;
  var currentuser;
  var shop;
  var type;
  List<dynamic> color;
  ViewProduct(
      {super.key,
      this.New,
      this.des,
      this.addr,
      this.image,
      this.name,
      this.old,
      this.quan,
      this.email,
      this.currentuser,
      this.type,
      required this.color,
      this.shop});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct>
    with SingleTickerProviderStateMixin {
  static Future<void> openMAp(String addr) async {
    String googlemapUrl =
        "https://www.google.com/maps/search/?api=1&query=$addr";

    if (await canLaunch(googlemapUrl)) {
      await launch(googlemapUrl);
    } else {
      throw "Could not Open the Map";
    }
  }

  late AnimationController controller;

  List review = [
    "Video",
    "Reviews",
    "Privacy Policy",
    "Return Policy",
    "Support Policy"
  ];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future addtocart() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection("cart_item");
    return collectionref.doc(currentUser!.email).collection("item").doc().set({
      'PnameController': widget.name,
      'PpriceController': widget.New,
      'image': widget.image,
      'PdesController': widget.des,
      'MrpController': widget.old,
      'AddrController': widget.addr,
    }).then((value) {
      showCartDialog();
    }).then((value) {
      setState(() {});
    });
  }

  Future addtoFavorite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection("Favorite_item");
    return collectionref.doc(currentUser!.email).collection("item").doc().set({
      'PnameController': widget.name,
      'PpriceController': widget.New,
      'image': widget.image,
      'PdesController': widget.des,
      'MrpController': widget.old,
      'AddrController': widget.addr,
    }).then((value) {
      showFavoriteDialog();
    });
  }

  Color getColorFromString(String colorString) {
    // Remove 'Color(' and ')' from the string
    String hexString = colorString.replaceAll('Color(', '').replaceAll(')', '');

    // Remove '0x' prefix if present
    if (hexString.startsWith('0x')) {
      hexString = hexString.substring(2);
    }

    // Parse the hexadecimal value and create a Color object
    int hexColorValue = int.parse(hexString, radix: 16);
    return Color(hexColorValue);
  }

  void showCartDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: LottieBuilder.asset(
                    "images/Add-to-cart.json",
                    repeat: false,
                    fit: BoxFit.contain,
                    controller: controller,
                    onLoaded: (composition) {
                      controller.forward();
                    },
                  ),
                ),
                const Text(
                  "Item Added to Cart!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ));

  void showFavoriteDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: LottieBuilder.asset(
                    "images/Add-to-favorite.json",
                    repeat: false,
                    fit: BoxFit.contain,
                    controller: controller,
                    onLoaded: (composition) {
                      controller.forward();
                    },
                  ),
                ),
                const Text(
                  "Item Added to Favorite!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ));
  int quantity = 0;

  CollectionReference users = FirebaseFirestore.instance
      .collection("Favorite_item")
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .collection("item");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: const Color.fromARGB(250, 245, 221, 149),
          title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: Container(
                  height: 60,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
          // automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 1350,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: Stack(children: [
                      SizedBox(
                          height: height * 0.4,
                          width: width,
                          child: CachedNetworkImage(imageUrl: widget.image)),
                      FutureBuilder(
                        future: users
                            .where("PnameController", isEqualTo: widget.name)
                            .get(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Text("No Favorite items added");
                          }
                          return Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                padding: EdgeInsets.only(top: height * 0.02),
                                onPressed: () {
                                  addtoFavorite();
                                },
                                icon: snapshot.data.docs.length == 0
                                    ? const Icon(
                                        Icons.favorite_border,
                                        size: 35,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                              ));
                        },
                      ),
                    ])),
                10.heightBox,
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Text(widget.name),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: VxRating(
                    onRatingUpdate: (value) {},
                    normalColor: Colors.grey,
                    selectionColor: Colors.green,
                    count: 5,
                    size: 25,
                    stepInt: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Row(children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\u{20B9}${widget.old}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 13,
                                color: Colors.grey),
                          ),
                          TextSpan(
                              text: ' \u{20B9}${widget.New}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  ]),
                ),
                10.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chat(
                                          chatroomkey:
                                              widget.email + widget.currentuser,
                                          shop: widget.email,
                                          user: widget.currentuser,
                                        )));
                          },
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(10),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.amber)),
                          icon: const Icon(Icons.message),
                          label: const Text("Message")),
                      ElevatedButton.icon(
                          onPressed: () {
                            openMAp(widget.addr);
                          },
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(10),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.red)),
                          icon: const Icon(Icons.location_on),
                          label: const Text("Location")),
                      ElevatedButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(10),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.green)),
                          icon: const Icon(Icons.share),
                          label: const Text("Share")),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Shoppage(
                                    addr: widget.addr,
                                    shop: widget.shop,
                                  )));
                    },
                    child: Container(
                      height: 35,
                      width: width,
                      constraints:
                          const BoxConstraints(maxHeight: double.infinity),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(169, 246, 223, 156),
                      ),
                      child: Text(
                        widget.shop!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            letterSpacing: 0,
                            wordSpacing: 2,
                            height: 2,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(height * 0.01),
                  child: Container(
                    // height: height * 0.12,
                    width: width,
                    constraints:
                        const BoxConstraints(maxHeight: double.infinity),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(169, 246, 223, 156),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(height * 0.015),
                        child: Text(
                          widget.addr!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              letterSpacing: 0,
                              wordSpacing: 2,
                              height: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.25,
                          child:
                              "Color:".text.color(Colors.grey.shade700).make(),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                widget.color.length,
                                (index) => CircleAvatar(
                                      backgroundColor: getColorFromString(
                                          widget.color[index]),
                                    )),
                          ),
                        ),
                      ],
                    ).box.padding(EdgeInsets.all(height * 0.01)).make(),
                  ],
                ).box.white.shadowSm.make(),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.25,
                      child:
                          "Quantity:".text.color(Colors.grey.shade700).make(),
                    ),
                    Row(children: [
                      IconButton(
                          onPressed: () {
                            if (quantity == 0) {
                              setState(() {
                                quantity = 0;
                              });
                            } else {
                              setState(() {
                                quantity = quantity - 1;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove)),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            if (quantity == int.parse(widget.quan)) {
                              setState(() {
                                quantity = int.parse(widget.quan);
                              });
                            } else {
                              setState(() {
                                quantity = quantity + 1;
                              });
                            }
                          },
                          icon: const Icon(Icons.add)),
                    ]),
                    Text(
                      '(available ${widget.quan})',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ).box.padding(const EdgeInsets.all(8)).make(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Container(
                    // height: 100,
                    // constraints: const BoxConstraints(
                    //     maxHeight: double.infinity,
                    //     maxWidth: double.infinity,
                    //     minHeight: 100),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(169, 246, 223, 156),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.02, vertical: height * 0.02),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.055, bottom: height * 0.01),
                              child: "Description:"
                                  .text
                                  .fontWeight(FontWeight.w700)
                                  .maxFontSize(17)
                                  .minFontSize(17)
                                  .color(Colors.black)
                                  .make(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.07),
                              child: Text('${widget.des}'),
                            ),
                          ]),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.025,
                      right: width * 0.025,
                      bottom: height * 0.01),
                  child: ListView.builder(
                      itemCount: review.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(3),
                            title: Text(
                              '${review[index]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.black,
                            ),
                          ),
                        );
                      })),
                ))
              ],
            ),
          ),
        ),
        floatingActionButton: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("cart_item")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("item")
              .where("PnameController", isNotEqualTo: widget.name)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.done) {
                // Handle the completed state and use the snapshot data
                if (snapshot.hasData) {
                  // Your logic to check if the document exists and decide whether to show the button
                  var documents = snapshot.data!.docs;
                  bool showButton = documents
                      .isEmpty; // Adjust this condition based on your needs

                  return Theme(
                    data: Theme.of(context).copyWith(
                      floatingActionButtonTheme:
                          const FloatingActionButtonThemeData(
                        extendedSizeConstraints:
                            BoxConstraints.tightFor(height: 50, width: 180),
                      ),
                    ),
                    child: showButton
                        ? FloatingActionButton.extended(
                            elevation: 10,
                            backgroundColor: Colors.amber,
                            splashColor: Colors.amber.shade800,
                            onPressed: () => addtocart(),
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text("ADD TO CART"),
                          )
                        : Container(),
                  );
                } else if (snapshot.hasError) {
                  // Handle the error state
                  print(snapshot.error);
                  return Container();
                }
              }
              // Handle other connection states
              return const CircularProgressIndicator(); // Or any other loading indicator
            } catch (e) {
              print(e);
              return Container();
            }
          },
        ));
  }
}
