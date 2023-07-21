import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_commerce/pages/Post.dart';
import 'package:m_commerce/pages/home/chatlobby.dart';
import 'package:m_commerce/pages/home/drawer.dart';
import 'package:m_commerce/pages/home/Search.dart';
import 'package:m_commerce/pages/login/rent_splash.dart';
import 'package:m_commerce/pages/viewproduct.dart';
import '../category/seeAll.dart';
import 'package:animated_background/animated_background.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  List upl_image = [];
  getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("upl_image").get();
    for (int i = 0; i < qn.docs.length; i++) {
      setState(() {
        upl_image.add({
          "image": qn.docs[i]["image"],
          "PnameController": qn.docs[i]["pnameController"],
          "PdesController": qn.docs[i]["pdesController"],
          "MrpController": qn.docs[i]["mrpController"],
          "PpriceController": qn.docs[i]["ppriceController"],
          "AddrController": qn.docs[i]["addrController"],
          "categoryController": qn.docs[i]["categoryController"],
          "QuantityController": qn.docs[i]["QuantityController"]
        });
      });
    }
    return qn.docs;
  }

  @override
  void initState() {
    getData();
    super.initState();
    // print(upl_image[0][image]);
  }

  Widget _buildCategory({required String name, required String photo}) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 4,
      child: SizedBox(
        height: 160,
        width: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  image: DecorationImage(
                      image: AssetImage(
                        "images/$photo",
                      ),
                      fit: BoxFit.fill)),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShop({required String photos}) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 6,
        child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Container(
              margin: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 15),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/$photos",
                      ),
                      fit: BoxFit.fill)),
            )));
  }

  List icon = [
    Icons.person,
    Icons.email_rounded,
    Icons.location_on,
    Icons.phone_android_rounded,
    Icons.headset_mic
  ];

  List name = ["email Id", "Address", "Phone no.", "Help Center"];
  ImagePicker? image = ImagePicker();
  Future getImage(ImageSource gallery) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
  }

  final data = ['1', '2'];
  final List<String> imgList = [
    'images/image1.jpeg',
    'images/image2.jpeg',
    'images/image3.jpg'
  ];
  Future<bool> _onbackbottonpressed(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('EXIT'),
            content: const Text('Do You Want to Exit the App?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'No',
                  )),
            ],
          );
        });
    return exitApp;
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection('User_data');

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: height * 0.09,
        title: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage()));
          },
          child: Container(
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatLobby()));
              },
              icon: const Icon(Icons.chat)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      drawer: MainDrawer(),

      //                     _image != null
      //                         ? CircleAvatar(
      //                             maxRadius: 100,
      //                             minRadius: 10,
      //                             backgroundImage:
      //                                 FileImage(File(_image!.path)),
      //                           )
      //                         : CircleAvatar(
      //                             maxRadius: 80,
      //                             minRadius: 70,
      //                           ),

      body: WillPopScope(
        onWillPop: () => _onbackbottonpressed(context),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder<DocumentSnapshot>(
              future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Container(
                        height: 80,
                        child: Center(
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                  text: "Welcome ",
                                  style: TextStyle(fontSize: 30)),
                              TextSpan(
                                  text: data["Name"].toString().toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.amber))
                            ]),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: CarouselSlider(
                            items: imgList
                                .map(
                                  (item) => Center(
                                    child: Image.asset(item,
                                        fit: BoxFit.cover, width: 1000),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              // aspectRatio: 2.0,
                              enlargeCenterPage: true,
                            )),
                      ),

                      Container(
                        height: 180,
                        color: Colors.amberAccent,
                        child: AnimatedBackground(
                          behaviour: RandomParticleBehaviour(
                              options: const ParticleOptions(
                            spawnMaxRadius: 20,
                            spawnMinSpeed: 50,
                            particleCount: 50,
                            spawnMaxSpeed: 80,
                            minOpacity: 0.7,
                            maxOpacity: 0.9,
                            baseColor: Colors.white,
                          )),
                          vsync: this,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SeeAll()));
                                  },
                                  child: _buildShop(photos: "buy.png")),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Post()));
                                  },
                                  child: _buildShop(photos: "sale.png")),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Splash()));
                                  },
                                  child: _buildShop(photos: "rent.png")),
                            ],
                          ),
                        ),
                      ),
                      //Category>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Category",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeeAll()),
                                );
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    //no splash for textbutton
                                    (states) => Colors.transparent),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: const Text(
                                "See All >",
                                textAlign: TextAlign.end,
                              ),
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCategory(
                                photo: "electronics.jpg", name: "Electronics"),
                            _buildCategory(
                                photo: "dresses.jpg", name: "Fashion"),
                            _buildCategory(
                                photo: "Furniture.jpeg", name: "Furniture"),
                            _buildCategory(
                                photo: "phone.webp", name: "Mobiles"),
                            _buildCategory(
                                photo: "Grocery.png", name: "Grocery"),
                            _buildCategory(photo: "toys.jpeg", name: "Toys"),
                            _buildCategory(photo: "sports.jpg", name: "Sports"),
                            _buildCategory(
                                photo: "Utensils.webp", name: "Home"),
                          ],
                        ),
                      ),

                      //Recommended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                      const Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 20),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Recommended")),
                      ),

                      SizedBox(
                        height: 950,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.73),
                          children: [
                            for (int i = 0; i < upl_image.length; i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewProduct(
                                              New: upl_image[i]
                                                  ["PpriceController"],
                                              des: upl_image[i]
                                                  ["PdesController"],
                                              image: upl_image[i]["image"],
                                              name: upl_image[i]
                                                  ["PnameController"],
                                              old: upl_image[i]
                                                  ["MrpController"],
                                              addr: upl_image[i]
                                                  ["AddrController"],
                                              quan: upl_image[i]
                                                  ["QuantityController"])));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(13)),
                                    child: Column(children: [
                                      // _buildRecomended(price: price, newprice: newprice, description: description, recimage: recimage),
                                      Container(
                                          height: 160,
                                          color: Colors.white,
                                          child: CachedNetworkImage(
                                            imageUrl: upl_image[i]["image"],
                                          )),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 75,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                              upl_image[i]["PnameController"]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    '\u{20B9}${upl_image[i]["MrpController"]}',
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 11,
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                  text:
                                                      ' \u{20B9}${upl_image[i]["PpriceController"]}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      )
                                    ])),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.4,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              },
            )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton.extended(
                heroTag: "btn1",
                focusColor: Colors.amber,
                backgroundColor: Colors.black,
                icon: const Icon(
                  Icons.shopping_cart_checkout_rounded,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Splash()));
                },
                label: const Text(
                  "Rental Products",
                  style: TextStyle(color: Colors.amber),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              elevation: 30,
              label: const Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.amber[600],
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Post()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
