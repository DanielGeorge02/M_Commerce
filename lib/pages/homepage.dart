import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_commerce/pages/Post.dart';
import 'package:m_commerce/pages/loginpage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'seeAll.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List upl_image = [];
  getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("upl_image").get();
    for (int i = 0; i < qn.docs.length; i++) {
      setState(() {
        upl_image.add({
          "img": qn.docs[i]["upl_img"],
          "name": qn.docs[i]["upl_name"],
          "old": qn.docs[i]["upl_old"],
          "new": qn.docs[i]["upl_new"]
        });
      });
    }
    return qn.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget _buildCategory({required String name, required String photo}) {
    return Card(
      shadowColor: Colors.grey,
      elevation: 4,
      child: Container(
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/$photos",
                      ),
                      fit: BoxFit.fill)),
            )));
  }

  Widget _buildRecomended(
      {required String price,
      required String newprice,
      required String description,
      required String recimage}) {
    return Container(
      height: 0,
      color: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 6,
        child: Container(
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  width: 170,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            "images/$recimage",
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                color: Colors.amber,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                  child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: '\u{20B9}${price} ',
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                TextSpan(
                    text: '\u{20B9}${newprice}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              ]))),
            ],
          ),
        ),
      ),
    );
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
  File? _image;
  Future getImage(ImageSource gallery) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  final data = ['1', '2'];
  final List<String> imgList = [
    'images/image1.jpeg',
    'images/image2.jpeg',
    'images/image3.jpg'
  ];

  GlobalKey<SliderDrawerState> _drawerkey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        toolbarHeight: height * 0.09,
        title: Container(
          child: TextField(
              autofocus: false,
              cursorColor: Colors.black,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Search Products",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ))),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Column(
                  children: [
                    Container(
                      child: const Text(
                        "DAniel George",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        height: height * 0.20,
                        width: width * 0.38,
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    maxRadius: 100,
                                    minRadius: 10,
                                    backgroundImage:
                                        FileImage(File(_image!.path)),
                                  )
                                : CircleAvatar(
                                    maxRadius: 80,
                                    minRadius: 70,
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.255, top: height * 0.128),
                              child: CircleAvatar(
                                maxRadius: 28,
                                minRadius: 10,
                                child: IconButton(
                                  onPressed: () =>
                                      getImage(ImageSource.gallery),
                                  icon: Icon(
                                    Icons.edit,
                                    size: 38,
                                  ),
                                  alignment: AlignmentDirectional.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.28),
                    width: width,
                    height: height * 0.4,
                    child: ListView.builder(
                        itemCount: name.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Align(
                              child: ListTile(
                                leading: Icon(
                                  icon[index],
                                  size: 30,
                                ),
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(name[index],
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center),
                                ),
                                minVerticalPadding: 5,
                              ),
                            ),
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.09),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          icon: Icon(Icons.logout_sharp),
                          label: Text("Logout")),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // color: Color.fromARGB(255, 236, 233, 233),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: CarouselSlider(
                    items: imgList
                        .map(
                          (item) => Container(
                            child: Center(
                              child: Image.asset(item,
                                  fit: BoxFit.cover, width: 1000),
                            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildShop(photos: "buy.png"),
                    _buildShop(photos: "sale.png"),
                    _buildShop(photos: "rent.png"),
                  ],
                ),
              ),
              //Category>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: Align(
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
                          MaterialPageRoute(builder: (context) => SeeAll()),
                        );
                      },
                      child: Text(
                        "See All >",
                        textAlign: TextAlign.end,
                      ),
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            //no splash for textbutton
                            (states) => Colors.transparent),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
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
                    _buildCategory(photo: "dresses.jpg", name: "Fashion"),
                    _buildCategory(photo: "Furniture.jpeg", name: "Furniture"),
                    _buildCategory(photo: "phone.webp", name: "Mobiles"),
                    _buildCategory(photo: "Grocery.png", name: "Grocery"),
                    _buildCategory(photo: "toys.jpeg", name: "Toys"),
                    _buildCategory(photo: "sports.jpg", name: "Sports"),
                    _buildCategory(photo: "Utensils.webp", name: "Utensils"),
                  ],
                ),
              ),

              //Recommended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 20),
                child: Align(
                    alignment: Alignment.topLeft, child: Text("Recommended")),
              ),

              // Stack(
              //   children: [
              //     Expanded(
              //       child: GridView.builder(
              //           shrinkWrap: true,
              //           itemCount: upl_image.length,
              //           scrollDirection: Axis.horizontal,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 1,
              //           ),
              //           itemBuilder: ((context, index) {
              //             return Column(
              //               children: [
              //                 Expanded(
              //                   child: GestureDetector(
              //                     onTap: () {
              //                       // Navigator.push(
              //                       //     context,
              //                       //     MaterialPageRoute(
              //                       //         builder: (context) =>
              //                       //             cement_product_page(
              //                       //                 _ProductCement[index]
              //                       //                     ["x"])));
              //                     },
              //                     child: Container(
              //                         child: Image.network(
              //                             upl_image[index]["img"])),
              //                   ),
              //                 ),
              //                 // if (_ProductCement[index]["category"] == "cement")
              //                 Column(
              //                   children: [
              //                     Text(upl_image[index]["name"]),
              //                     Text(upl_image[index]["old"].toString()),
              //                     SizedBox(
              //                       width: 20,
              //                     ),
              //                     Text(upl_image[index]["new"].toString()),
              //                   ],
              //                 )

              //                 // Text("working"),
              //               ],
              //             );
              //           })),
              //     ),
              //   ],
              // ),

              Container(
                height: 1000,
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.2),
                  children: [
                    for (int i = 0; i < upl_image.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(upl_image[i]["img"]),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                color: Colors.amber,
                                height: 120,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 10),
                                  child: Text(
                                    upl_image[i]["name"],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '\u{20B9}${upl_image[i]["old"]} ',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.grey),
                                      ),
                                      TextSpan(
                                          text:
                                              '\u{20B9}${upl_image[i]["old"]}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        activeIcon: Icons.add,
        buttonSize: Size(60.0, 50.0),
        visible: true,
        elevation: 30,
        label: Text("Upload"),
        backgroundColor: Colors.amber[600],
        animatedIcon: AnimatedIcons.add_event,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.abc,
            ),
            label: "sale",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Post()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.ac_unit_rounded),
            label: "rent",
          )
        ],
      ),
    );
  }
}
