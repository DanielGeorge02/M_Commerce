// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
  File? file;
  var colour = 0;
  Color currentColor = Colors.green;
  bool no_color = false;
  List<Color> currentColors = [Colors.yellow, Colors.red];

  //colors for loop
  List<String> colors(List ColList) {
    List<String> Col = [];
    for (int i = 0; i < ColList.length; i++) {
      Col.add(ColList[i].toString());
    }
    return Col;
  }

  String? product_type;
  ImagePicker image = ImagePicker();
  late AnimationController controller;
  final items = [
    "Electronics",
    "Mobiles",
    "Fashion",
    "Furniture",
    "Toys",
    "Hardwares",
    "Footwear",
    "Stationary",
    "Home",
    "Sports",
    "Auto spare Parts",
    "Laptops"
  ];
  void changeColor(Color color) => setState(() => currentColor = color);

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

  String? category;
  String? state;
  String? city;
  TextEditingController SnameController = TextEditingController();
  TextEditingController PnoController = TextEditingController();
  TextEditingController ShopController = TextEditingController();
  TextEditingController AddrController = TextEditingController();
  TextEditingController PnameController = TextEditingController();
  TextEditingController PdesController = TextEditingController();
  TextEditingController MrpController = TextEditingController();
  TextEditingController PpriceController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController Gstcontroller = TextEditingController();
  String url = "";

  void showSuccessful() => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: LottieBuilder.asset(
                    "images/successful.json",
                    repeat: false,
                    fit: BoxFit.contain,
                    controller: controller,
                    onLoaded: (composition) {
                      controller.forward();
                    },
                  ),
                ),
                const Text(
                  "Item Added Successfully!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ));

  senddata() async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile =
        FirebaseStorage.instance.ref().child("seller_info").child(name);
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    final collectionreference = FirebaseFirestore.instance
        .collection("Seller_req")
        .doc("Products")
        .collection("item")
        .doc(FirebaseAuth.instance.currentUser!.email);

    return collectionreference
        .set({
          'date': DateTime.now(),
          "SnameController": SnameController.text,
          "PnoController": PnoController.text,
          "AddrController": AddrController.text,
          "PnameController": PnameController.text,
          "categoryController": category,
          "PdesController": PdesController.text,
          "MrpController": MrpController.text,
          "PpriceController": PpriceController.text,
          "emailController": emailcontroller.text,
          "QuantityController": QuantityController.text,
          "GstController": Gstcontroller.text,
          "Ptype": product_type,
          "Colour": colors(chosenColor),
          "state": state,
          "email": FirebaseAuth.instance.currentUser!.email,
          "city": city,
          "image": url,
          "id": collectionreference.id
        })
        .then((value) => showSuccessful())
        .then((value) => Navigator.of(context).pop());
  }

  List chosenColor = [];
  bool success = true;
  int count = 0;
  var jsondata;

  //34ARPPM1668N1Z3

  getRequest() async {
    var url = Uri.https(
      'gst-return-status.p.rapidapi.com',
      '/free/gstin/$Gstcontroller',
    );
    var headers = {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': '24d87c3e7fmshcd2f1f1625659c5p12eb66jsn76a1e6dca6df',
      'X-RapidAPI-Host': 'gst-return-status.p.rapidapi.com'
    };
    final response = await http.get(url, headers: headers);

    jsondata = jsonDecode(response.body);
    success = jsondata["success"];
    print(success.runtimeType);
    print(success);
    return success;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          toolbarHeight: height * 0.09,
          title: const Text("Product Upload Page"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: SnameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.amber,
                      ),
                      hintText: "Seller Name",
                      labelText: "Seller Name",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextField(
                    controller: PnoController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.amber,
                        ),
                        hintText: "Phone Numer",
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const Text(
                    "If you are a Vendor, give the shop name below, else just give None"),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15.0),
                  child: TextField(
                    controller: ShopController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.shopping_bag,
                          color: Colors.amber,
                        ),
                        hintText: "Shop Name",
                        labelText: "Shop Name",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const Text(
                    "If you are a Vendor, give the GST Number below, else just give None"),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: Gstcontroller,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.content_paste_sharp,
                                color: Colors.amber,
                              ),
                              hintText: "GST Number",
                              labelText: "GST Number",
                              labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          count++;
                          getRequest();
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        child: const Text("Verify",
                            style: TextStyle(color: Colors.white)),
                      ),
                      if (success && count > 0)
                        const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      else if (!success && count > 0)
                        const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )
                      else
                        const Text(""),
                    ],
                  ),
                ),
                TextFormField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.amber,
                      ),
                      hintText: "email address",
                      labelText: "email address",
                      labelStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextFormField(
                    controller: AddrController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.amber,
                        ),
                        hintText: "Address",
                        labelText: "Address",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.name,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "  Location",
                            style: TextStyle(fontSize: 15),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CSCPicker(
                          layout: Layout.vertical,
                          defaultCountry: CscCountry.India,
                          disableCountry: true,
                          onCountryChanged: (Country) {},
                          onStateChanged: (state) {
                            setState(() {
                              this.state = state;
                            });
                          },
                          onCityChanged: (city) {
                            setState(() {
                              this.city = city;
                            });
                          },
                          stateDropdownLabel: "State",
                          cityDropdownLabel: "City",
                        ),
                      ),
                    ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Product Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 249, 217, 121),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      const Text(
                        "Select Product Type",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      RadioListTile(
                        activeColor: Colors.black,
                        title: const Text("New Product"),
                        value: "New",
                        groupValue: product_type,
                        onChanged: (value) {
                          setState(() {
                            product_type = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        activeColor: Colors.black,
                        title: const Text("Old Product"),
                        value: "Old",
                        groupValue: product_type,
                        onChanged: (value) {
                          setState(() {
                            product_type = value.toString();
                          });
                        },
                      ),
                    ])),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      dropdownColor: const Color.fromARGB(255, 249, 217, 121),
                      borderRadius: BorderRadius.circular(20),
                      hint: const Text("Category"),
                      isExpanded: true,
                      value: category,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() {
                            category = value;
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextFormField(
                    controller: PnameController,
                    decoration: const InputDecoration(
                        hintText: "Product name",
                        labelText: "Product Name",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.name,
                    maxLength: 45,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: TextField(
                    controller: PdesController,
                    decoration: const InputDecoration(
                        hintText: "Product description",
                        labelText: "Product description",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Upload Product Images",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.grey,
                      child: file == null
                          ? const Icon(Icons.image)
                          : Image.file(
                              file!,
                              fit: BoxFit.fill,
                            )),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 40,
                    width: 140,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        getcam();
                      },
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              getcam();
                            },
                            icon: const Icon(Icons.camera_alt)),
                        const Text("Camera"),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: SizedBox(
                      height: 40,
                      width: 140,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () {
                          getgal();
                        },
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                getgal();
                              },
                              icon: const Icon(Icons.photo)),
                          const Text("Gallery"),
                        ]),
                      ),
                    ),
                  ),
                ]),

                const Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Color",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                no_color == false
                    ? Container(
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                            const Text("If Color Available"),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.amber)),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Choose Color"),
                                      actions: <Widget>[
                                        Column(
                                          children: [
                                            MaterialPicker(
                                                pickerColor: currentColor,
                                                onColorChanged: changeColor),
                                            TextButton(
                                                onPressed: () {
                                                  const snackdemo = SnackBar(
                                                    content: Text(
                                                        'Already Selected'),
                                                    backgroundColor: Colors.red,
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(5),
                                                  );
                                                  chosenColor.contains(
                                                          currentColor)
                                                      ? ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackdemo)
                                                      : chosenColor
                                                          .add(currentColor);
                                                  print(chosenColor);
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Done"))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: const Text("Choose Color")),
                          ],
                        ),
                      )
                    : Container(),

                // Text("$selectedColor"),
                chosenColor.isNotEmpty
                    ? SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chosenColor.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return SizedBox(
                                height: 50,
                                width: 50,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0, right: 20),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: chosenColor[position],
                                      ),
                                    ),
                                    IconButton(
                                        iconSize: 20,
                                        color: Colors.red,
                                        onPressed: () {
                                          chosenColor.removeAt(position);
                                          print(chosenColor);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                        )),
                                  ],
                                ));
                          },
                        ),
                      )
                    : Container(),
                chosenColor.isEmpty && no_color == false
                    ? Column(children: [
                        const Text("If color not available"),
                        TextButton(
                          onPressed: () {
                            no_color = true;
                            setState(() {});
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          child: const Text("No color"),
                        ),
                      ])
                    : Container(),
                no_color == true
                    ? SizedBox(
                        height: 70,
                        width: 100,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 220, 220, 220),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                    child: Text(
                                  "No color",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Color.fromARGB(255, 129, 128, 128)),
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 45.0),
                              child: IconButton(
                                  onPressed: () {
                                    no_color = false;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.cancel)),
                            ),
                          ],
                        ),
                      )
                    : Container(),

                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, right: 100, left: 100),
                  child: TextFormField(
                      controller: QuantityController,
                      decoration: const InputDecoration(
                          hintText: "Quantity",
                          labelText: "Quantity",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      maxLength: 4),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, right: 60),
                  child: TextFormField(
                      controller: MrpController,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.currency_rupee_sharp,
                            color: Colors.amber,
                          ),
                          hintText: "MRP Price",
                          labelText: "MRP Price",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      maxLength: 6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0, right: 60),
                  child: TextField(
                      controller: PpriceController,
                      decoration: const InputDecoration(
                          // prefixIcon: Icon(Icons.shopping_cart),
                          icon: Icon(
                            Icons.currency_rupee_sharp,
                            color: Colors.amber,
                          ),
                          hintText: "Product Price",
                          labelText: "Product Price",
                          labelStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      maxLength: 6),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      senddata();
                    },
                    child: const Text("Upload"))
              ],
            ),
          ),
        ));
  }

  getcam() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    // var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(photo!.path);
    });
  }

  getgal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? galleryVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    // var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(galleryVideo!.path);
    });
  }
}
