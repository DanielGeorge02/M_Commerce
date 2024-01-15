// ignore_for_file: must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class Rent_viewproduct extends StatefulWidget {
  var image;
  var name;
  var description;
  var oneday;
  var oneweek;
  var twoweek;
  var threeweek;
  var onemonth;
  var threemonth;
  var sixmonth;
  var twelvemonth;
  var address;
  var quantity;
  Rent_viewproduct(
      {super.key,
      this.oneday,
      this.oneweek,
      this.twoweek,
      this.threeweek,
      this.onemonth,
      this.threemonth,
      this.sixmonth,
      this.twelvemonth,
      this.description,
      this.address,
      this.image,
      this.name,
      this.quantity});

  @override
  State<Rent_viewproduct> createState() => _Rent_viewproductState();
}

class _Rent_viewproductState extends State<Rent_viewproduct>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
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

  CollectionReference users = FirebaseFirestore.instance
      .collection("Favorite_item")
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .collection("rent");

  Future addtoFavorite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection("Favorite_item");
    return collectionref.doc(currentUser!.email).collection("rent").doc().set({
      'PnameController': widget.name,
      'onedayController': widget.oneday,
      'oneweekController': widget.oneweek,
      'twoweekController': widget.twoweek,
      'threeweekController': widget.threeweek,
      'onemonthController': widget.onemonth,
      'threemonthController': widget.threemonth,
      'sixmonthController': widget.sixmonth,
      'twelvemonthController': widget.twelvemonth,
      'image': widget.image,
      'quantity': widget.quantity,
      'PdesController': widget.description,
      'AddrController': widget.address,
    }).then((value) {
      showFavoriteDialog();
    });
  }

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

  late String? price = widget.oneday;
  bool press = true;
  bool press1 = false;
  bool press2 = false;
  bool press3 = false;
  bool press4 = false;
  bool press5 = false;
  bool press6 = false;
  bool press7 = false;
  bool text = false;
  String name = '';
  int quantity = 0;
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
            Navigator.of(context).pop();
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
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Stack(
              children: [
                SizedBox(
                    height: height * 0.4,
                    width: width,
                    child: CachedNetworkImage(imageUrl: widget.image)),
                FutureBuilder(
                  future: users
                      .where("PnameController", isEqualTo: widget.name)
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Text("No Favorite items added");
                    }
                    return Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
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
                      ),
                    );
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
              child: text == false
                  ? Text.rich(
                      TextSpan(
                          text: ' \u{20B9}$price per day ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    )
                  : Text.rich(
                      TextSpan(
                          text: ' \u{20B9}$price $name ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(168, 228, 228, 228),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press = !press;
                                  if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.oneday;
                                  name = 'per day';
                                });
                              },
                              child: const Text(
                                "1 day",
                                style: TextStyle(fontSize: 10),
                              )),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press1 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press1 = !press1;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.oneweek;
                                  name = 'per week';
                                });
                              },
                              child: const Text("1 week",
                                  style: TextStyle(fontSize: 10))),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press2 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press2 = !press2;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.twoweek;
                                  name = 'for 2 weeks';
                                });
                              },
                              child: const Text("2 weeks",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press3 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press3 = !press3;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.threeweek;
                                  name = 'for 3 weeks';
                                });
                              },
                              child: const Text("3 weeks",
                                  style: TextStyle(fontSize: 11))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press4 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press4 = !press4;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.onemonth;
                                  name = 'per month';
                                });
                              },
                              child: const Text("1 month",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press5 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press5 = !press5;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.threemonth;
                                  name = 'for 3 months';
                                });
                              },
                              child: const Text("3 months",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press6 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press6 = !press6;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press7 == true) {
                                    setState(() {
                                      press7 = !press7;
                                    });
                                  }
                                  price = widget.sixmonth;
                                  name = 'for 6 months';
                                });
                              },
                              child: const Text("6 months",
                                  style: TextStyle(fontSize: 11))),
                        ),
                        SizedBox(
                          height: 35,
                          width: 80,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: press7 == true
                                      ? const Color.fromARGB(255, 240, 227, 182)
                                      : Colors.amber),
                              onPressed: () {
                                setState(() {
                                  text = true;
                                  press7 = !press7;
                                  if (press == true) {
                                    setState(() {
                                      press = !press;
                                    });
                                  } else if (press2 == true) {
                                    setState(() {
                                      press2 = !press2;
                                    });
                                  } else if (press3 == true) {
                                    setState(() {
                                      press3 = !press3;
                                    });
                                  } else if (press4 == true) {
                                    setState(() {
                                      press4 = !press4;
                                    });
                                  } else if (press1 == true) {
                                    setState(() {
                                      press1 = !press1;
                                    });
                                  } else if (press6 == true) {
                                    setState(() {
                                      press6 = !press6;
                                    });
                                  } else if (press5 == true) {
                                    setState(() {
                                      press5 = !press5;
                                    });
                                  }
                                  price = widget.twelvemonth;
                                  name = 'for 12 months';
                                });
                              },
                              child: const Text("12 months",
                                  style: TextStyle(fontSize: 10))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.amber)),
                    icon: const Icon(Icons.message),
                    label: const Text("Message")),
                ElevatedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.red)),
                    icon: const Icon(Icons.location_on),
                    label: const Text("Location")),
                ElevatedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.green)),
                    icon: const Icon(Icons.share),
                    label: const Text("Share")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(169, 246, 223, 156),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            widget.address!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                letterSpacing: 1,
                                wordSpacing: 3,
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                            .margin(const EdgeInsets.symmetric(horizontal: 6))
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
                    icon: const Icon(Icons.remove)),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
                IconButton(
                    onPressed: () {
                      if (quantity == int.parse(widget.quantity)) {
                        setState(() {
                          quantity = int.parse(widget.quantity);
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
                '(available ${widget.quantity})',
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
                        child: Text('${widget.description}'),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          )
        ]),
      )),
    );
  }
}
