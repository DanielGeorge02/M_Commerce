// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lottie/lottie.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
  File? file;
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
        .doc("A3YtV51DsJGf7ruoFV6x")
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
          "state": state,
          "email": FirebaseAuth.instance.currentUser!.email,
          "city": city,
          "image": url,
          "id": collectionreference.id
        })
        .then((value) => showSuccessful())
        .then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                        labelText: "phone Number",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, right: 100, left: 100),
                  child: TextFormField(
                      controller: QuantityController,
                      decoration: const InputDecoration(

                          // icon: Icon(Icons.currency_rupee_sharp),
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
                          // prefixIcon: Icon(Icons.shopping_cart),
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
