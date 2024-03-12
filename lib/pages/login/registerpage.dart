// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';
import 'package:m_commerce/pages/login/userType.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends ConsumerStatefulWidget {
  var type;
  // var password;
  // var name;
  // var shopname;
  // var phone;
  // var gst;
  // var address;
  // var city;
  // var state;

  Register({
    super.key,
    @required this.type,
    // @required this.password,
    // @required this.name,
    // @required this.shopname,
    // @required this.phone,
    // @required this.gst,
    // @required this.address,
    // @required this.city,
    // @required this.state,
  });

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController gstcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController PnoController = TextEditingController();
  String? state;
  String? city;
  TextEditingController shopname = TextEditingController();

  late double height, width;
  bool success = true;
  int count = 0;
  var jsondata;
  String userType = "";

  @override
  void initState() {
    super.initState();
    userType = ref.read(userTypeProvider);
    print(ref.read(userTypeProvider));
  }

  Future<bool> getRequest() async {
    String gst = gstcontroller.text;
    var url = Uri.https(
      'gst-return-status.p.rapidapi.com',
      '/free/gstin/$gst',
    );

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': '24d87c3e7fmshcd2f1f1625659c5p12eb66jsn76a1e6dca6df',
      'X-RapidAPI-Host': 'gst-return-status.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);

    var jsonData = jsonDecode(response.body);
    var success = jsonData["success"];
    var data = jsonData["data"];
    print(gst);
    print(jsonData);
    print(data);
    print(success);

    return success;
  }

  Future Register() async {
    ref.read(emailProvider.notifier).state = emailcontroller.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', userType);
    prefs.setString('email', ref.read(emailProvider).toString());

    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection("No. of Users")
        .doc(emailcontroller.text + userType)
        .get();

    print(".................................................");

    if (userData.exists) {
      print(
          "user Exists......................................................");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User already exists!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      var collectionreference = FirebaseFirestore.instance
          .collection("No. of Users")
          .doc(emailcontroller.text)
          .collection(userType)
          .doc(emailcontroller.text + userType);
      print(
          "user doesnt Exists......................................................");

      return ref.read(userTypeProvider) == "Customer"
          ? collectionreference.set({
              "email": emailcontroller.text,
              "password": passwordcontroller.text,
              "name": namecontroller.text,
              "image": ""
            }).then((value) async {
              print(
                  "...........................................................");

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            })
          : ref.read(userTypeProvider) == "Shop_Owner"
              ? collectionreference.set({
                  "email": emailcontroller.text,
                  "password": passwordcontroller.text,
                  "name": namecontroller.text,
                  "phone": PnoController.text,
                  "shop_name": shopname.text,
                  "gst": gstcontroller.text,
                  "address": addresscontroller.text,
                  "city": city,
                  "state": state,
                  "image": ""
                }).then((value) async {
                  print(
                      "...........................................................");

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                })
              : ref.read(userTypeProvider) == "Self_Service"
                  ? collectionreference.set({
                      "email": emailcontroller.text,
                      "password": passwordcontroller.text,
                      "name": namecontroller.text,
                      "phone": PnoController.text,
                      "address": addresscontroller.text,
                      "city": city,
                      "state": state,
                      "image": ""
                    }).then((value) async {
                      print(
                          "...........................................................");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    })
                  : collectionreference.set({
                      "email": emailcontroller.text,
                      "password": passwordcontroller.text,
                      "name": namecontroller.text,
                      "phone": PnoController.text,
                      "address": addresscontroller.text,
                      "city": city,
                      "state": state,
                      "image": ""
                    }).then((value) async {
                      print(
                          "...........................................................");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    width: width * 1,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              icon: const Icon(
                                  Icons.arrow_back_ios_new_outlined)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: const AssetImage("images/register.gif"),
                            fit: BoxFit.cover,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.grey.shade500,
                                      Colors.white
                                    ]),
                                    border: const Border(
                                        left: BorderSide(
                                            color: Colors.amber, width: 5))),
                                child: const Text(
                                  '  REGISTER',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(
                            top: 50,
                          )),
                          ref.read(userTypeProvider) == "Customer"
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: TextField(
                                        controller: emailcontroller,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            labelText: "EMAIL ADDRESS",
                                            labelStyle: const TextStyle(
                                                color: Colors.black),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                            fillColor: Colors.grey.shade200,
                                            filled: true),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: TextField(
                                        controller: passwordcontroller,
                                        decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.lock,
                                              color: Colors.black,
                                            ),
                                            labelText: "PASSWORD",
                                            labelStyle: const TextStyle(
                                                color: Colors.black),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                            fillColor: Colors.grey.shade200,
                                            filled: true),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: TextField(
                                        controller: namecontroller,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.black,
                                            ),
                                            labelText: "NAME",
                                            labelStyle: const TextStyle(
                                                color: Colors.black),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white)),
                                            fillColor: Colors.grey.shade200,
                                            filled: true),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                )
                              : ref.read(userTypeProvider) ==
                                          "Private_Seller" ||
                                      ref.read(userTypeProvider) ==
                                          "Self_Service"
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: emailcontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.email,
                                                  color: Colors.black,
                                                ),
                                                labelText: "EMAIL ADDRESS",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: passwordcontroller,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Colors.black,
                                                ),
                                                labelText: "PASSWORD",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: namecontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                ),
                                                labelText: "NAME",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: phonecontroller,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.phone,
                                                  color: Colors.black,
                                                ),
                                                labelText: "PHONE NUMBER",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: addresscontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.phone_android_outlined,
                                                  color: Colors.black,
                                                ),
                                                labelText: "ADDRESS",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
                                          child: Container(
                                            width: width * 0.87,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                boxShadow: List.filled(
                                                    2,
                                                    const BoxShadow(
                                                        color: Colors.black)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Text(
                                                      "Location",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CSCPicker(
                                                  layout: Layout.vertical,
                                                  defaultCountry:
                                                      CscCountry.India,
                                                  disableCountry: true,
                                                  onCountryChanged:
                                                      (Country) {},
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
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: emailcontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.email,
                                                  color: Colors.black,
                                                ),
                                                labelText: "EMAIL ADDRESS",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: passwordcontroller,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  color: Colors.black,
                                                ),
                                                labelText: "PASSWORD",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: namecontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                ),
                                                labelText: "NAME",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: phonecontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.phone,
                                                  color: Colors.black,
                                                ),
                                                labelText: "PHONE NUMBER",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: namecontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.black,
                                                ),
                                                labelText: "SHOP NAME",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: width * 0.7,
                                                child: TextFormField(
                                                  controller: gstcontroller,
                                                  decoration: InputDecoration(
                                                      prefixIcon: const Icon(
                                                        Icons
                                                            .content_paste_sharp,
                                                        color: Colors.black,
                                                      ),
                                                      hintText: "GST Number",
                                                      labelText: "GST Number",
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      fillColor:
                                                          Colors.grey.shade200,
                                                      filled: true,
                                                      border:
                                                          const OutlineInputBorder()),
                                                  keyboardType:
                                                      TextInputType.name,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'This field is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.015),
                                                child: TextButton(
                                                  onPressed: () {
                                                    count++;
                                                    print(count);
                                                    getRequest();
                                                  },
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.black)),
                                                  child: const Text("Verify",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0),
                                          child: TextField(
                                            controller: phonecontroller,
                                            decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.black,
                                                ),
                                                labelText: "ADDRESS",
                                                labelStyle: const TextStyle(
                                                    color: Colors.black),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                fillColor: Colors.grey.shade200,
                                                filled: true),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
                                          child: Container(
                                            width: width * 0.87,
                                            decoration: BoxDecoration(
                                                boxShadow: List.filled(
                                                    2,
                                                    const BoxShadow(
                                                        color: Colors.black)),
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0, top: 5),
                                                    child: Text(
                                                      "Location",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CSCPicker(
                                                  layout: Layout.vertical,
                                                  defaultCountry:
                                                      CscCountry.India,
                                                  disableCountry: true,
                                                  onCountryChanged:
                                                      (Country) {},
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
                                      ],
                                    ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextButton(
                              onPressed: () {
                                Register();
                              },
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(360, 50),
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  backgroundColor: Colors.black),
                              child: const Text(
                                "Register",
                                style:
                                    TextStyle(letterSpacing: 0.5, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
