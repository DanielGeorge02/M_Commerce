// ignore_for_file: non_constant_identifier_names, camel_case_types, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Rent_post extends StatefulWidget {
  const Rent_post({super.key});

  @override
  State<Rent_post> createState() => _Rent_postState();
}

class _Rent_postState extends State<Rent_post> {
  File? file1;
  ImagePicker image1 = ImagePicker();

  final items1 = [
    "Laptops",
    "Mobiles",
    "Fashion",
    "Computer",
    "Washing Machine",
    "Fridge",
    "TV",
    "Bike",
    "Home",
    "Cycle",
    "Car",
    "Other Electronics",
    "Van",
    "Bus"
  ];
  String? Rcategory;
  String? Rstate;
  String? Rcity;
  TextEditingController SnameController1 = TextEditingController();
  TextEditingController PnoController1 = TextEditingController();
  TextEditingController AddrController1 = TextEditingController();
  TextEditingController PnameController1 = TextEditingController();
  TextEditingController PdesController1 = TextEditingController();
  TextEditingController emailcontroller1 = TextEditingController();
  TextEditingController QuantityController1 = TextEditingController();
  TextEditingController Gstcontroller1 = TextEditingController();
  TextEditingController onedayController1 = TextEditingController();
  TextEditingController oneweekController1 = TextEditingController();
  TextEditingController twoweekController1 = TextEditingController();
  TextEditingController threeweekController1 = TextEditingController();
  TextEditingController onemonthController1 = TextEditingController();
  TextEditingController sixmonthController1 = TextEditingController();
  TextEditingController threemonthController1 = TextEditingController();
  TextEditingController twelvemonthController1 = TextEditingController();

  String url = "";

  senddata() async {
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    var imageFile =
        FirebaseStorage.instance.ref().child("Rent_info").child(name);
    UploadTask task = imageFile.putFile(file1!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    final collectionreference = FirebaseFirestore.instance
        .collection("Rent_upload_products")
        .doc("AllProducts")
        .collection("item")
        .doc();

    return collectionreference.set({
      'date': DateTime.now(),
      "RSnameController": SnameController1.text,
      "RPnoController": PnoController1.text,
      "RAddrController": AddrController1.text,
      "RPnameController": PnameController1.text,
      "RcategoryController": Rcategory,
      "RPdesController": PdesController1.text,
      "RonedayController": onedayController1.text,
      "RoneweekController": oneweekController1.text,
      "RtwoweekController": twoweekController1.text,
      "RthreeweekController": threeweekController1.text,
      "RonemonthController": onemonthController1.text,
      "RthreemonthController": threemonthController1.text,
      "RsixmonthController": sixmonthController1.text,
      "RtwelvemonthController": twelvemonthController1.text,
      "RemailController": emailcontroller1.text,
      "RQuantityController": QuantityController1.text,
      "RGstController": Gstcontroller1.text,
      "email": FirebaseAuth.instance.currentUser!.email,
      "state": Rstate,
      "city": Rcity,
      "image": url
    }).then((value) {
      print(Rcategory);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ViewProduct(
      //             New:,
      //             addr:,
      //             des:,
      //             image: ,
      //             name:,
      //             old:)));
    });
  }

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product Upload Page"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: SnameController1,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
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
                    controller: PnoController1,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_outlined),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextField(
                    controller: Gstcontroller1,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.content_paste_sharp),
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
                  controller: emailcontroller1,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
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
                    controller: AddrController1,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
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
                              Rstate = state;
                            });
                          },
                          onCityChanged: (city) {
                            setState(() {
                              Rcity = city;
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
                      value: Rcategory,
                      items: items1.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() {
                            Rcategory = value;
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: TextFormField(
                    controller: PnameController1,
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
                    controller: PdesController1,
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
                      child: file1 == null
                          ? const Icon(Icons.image)
                          : Image.file(
                              file1!,
                              fit: BoxFit.fill,
                            )),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 40,
                    width: 140,
                    child: ElevatedButton(
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
                      const EdgeInsets.only(top: 14.0, right: 60, left: 60),
                  child: TextFormField(
                      controller: QuantityController1,
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
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 212, 141),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, right: 60),
                        child: TextFormField(
                            controller: onedayController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "1 day price",
                                labelText: "1 day price",
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
                        child: TextFormField(
                            controller: oneweekController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "1-week price",
                                labelText: "1-week price",
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
                        child: TextFormField(
                            controller: twoweekController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "2-weeks price",
                                labelText: "2-weeks price",
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
                        child: TextFormField(
                            controller: threeweekController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "3-weeks price",
                                labelText: "3-weeks price",
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
                        child: TextFormField(
                            controller: onemonthController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "1-month price",
                                labelText: "1-month price",
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
                        child: TextFormField(
                            controller: threemonthController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "3-months price",
                                labelText: "3-months price",
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
                        child: TextFormField(
                            controller: sixmonthController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "6-months price",
                                labelText: "6-months price",
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
                        child: TextFormField(
                            controller: twelvemonthController1,
                            decoration: const InputDecoration(
                                // prefixIcon: Icon(Icons.shopping_cart),
                                icon: Icon(Icons.currency_rupee_sharp),
                                hintText: "12-months price",
                                labelText: "12-months price",
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            maxLength: 6),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
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
      file1 = File(photo!.path);
    });
  }

  getgal() async {
    final ImagePicker picker = ImagePicker();
    final XFile? galleryVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    // var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file1 = File(galleryVideo!.path);
    });
  }
}
