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
  var colour;
  ViewProduct(
      {this.New,
      this.des,
      this.addr,
      this.image,
      this.name,
      this.old,
      this.quan,
      this.email,
      this.currentuser,
      this.shop,
      this.type,
      this.colour});

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
        AnimationController(duration: Duration(seconds: 3), vsync: this);
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
                Container(
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
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ));
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(250, 245, 221, 149),
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
                child: Row(children: const [
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
                padding: const EdgeInsets.only(top: 18.0),
                child: Stack(
                  children: [
                    SizedBox(
                        height: height * 0.4,
                        width: width,
                        child: CachedNetworkImage(imageUrl: widget.image)),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Favorite_item")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("item")
                          .where("PnameController", isEqualTo: widget.name)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Text("No Favorite items added");
                        }
                        return Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              padding: const EdgeInsets.only(top: 20),
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
                  ],
                ),
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.name),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                padding: const EdgeInsets.all(10.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                MaterialStatePropertyAll(Colors.amber)),
                        icon: Icon(Icons.message),
                        label: Text("Message")),
                    ElevatedButton.icon(
                        onPressed: () {
                          openMAp(widget.addr);
                        },
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(10),
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
                            elevation: MaterialStatePropertyAll(10),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.green)),
                        icon: const Icon(Icons.share),
                        label: Text("Share")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        widget.shop!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 90,
                  width: width,
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(169, 246, 223, 156),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.addr!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          letterSpacing: 0,
                          wordSpacing: 2,
                          height: 2,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
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
                        width: 100,
                        child: "Color:".text.color(Colors.grey.shade700).make(),
                      ),
                      Row(
                        children: List.generate(
                            3,
                            (index) => VxBox()
                                .size(40, 40)
                                .roundedFull
                                .color(Vx.randomPrimaryColor)
                                .margin(EdgeInsets.symmetric(horizontal: 6))
                                .make()),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                ],
              ).box.white.shadowSm.make(),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: "Quantity:".text.color(Colors.grey.shade700).make(),
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
                        icon: Icon(Icons.remove)),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 15),
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
                        icon: Icon(Icons.add)),
                  ]),
                  Text(
                    '(available ${widget.quan})',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ).box.padding(const EdgeInsets.all(8)).make(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  height: 100,
                  constraints: BoxConstraints(
                      maxHeight: double.infinity,
                      maxWidth: double.infinity,
                      minHeight: 100),
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(169, 246, 223, 156),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: "Description:"
                              .text
                              .fontWeight(FontWeight.w700)
                              .maxFontSize(17)
                              .minFontSize(17)
                              .color(Colors.black)
                              .make(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text('${widget.des}'),
                        ),
                      ]),
                ),
              ),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18, bottom: 40),
                child: ListView.builder(
                    itemCount: review.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(3),
                          title: Text(
                            '${review[index]}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          trailing: Icon(
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
      floatingActionButton: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Favorite_item")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("item")
            .where("PnameController", isEqualTo: widget.name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          try {
            return Theme(
                data: Theme.of(context).copyWith(
                    floatingActionButtonTheme:
                        const FloatingActionButtonThemeData(
                            extendedSizeConstraints: BoxConstraints.tightFor(
                                height: 50, width: 180))),
                child: FloatingActionButton.extended(
                    elevation: 10,
                    backgroundColor: Colors.amber,
                    splashColor: Colors.amber.shade800,
                    onPressed: () => addtocart(),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("ADD TO CART")));
          } catch (e) {
            print(e);
          }
          return Container();
        },
      ),
    );
  }
}
