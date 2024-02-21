// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';
import 'package:m_commerce/pages/login/userType.dart';

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
  String? state;
  String? city;
  TextEditingController shopname = TextEditingController();

  late double height, width;
  DateTime now = DateTime.now();
  var r = Random();
  String unique = "";

  bool success = true;
  int count = 0;
  var jsondata;

  senddata() async {
    final CollectionReference = FirebaseFirestore.instance
        .collection("No. of Users")
        .doc(emailcontroller.text);
    return CollectionReference.set({
      "Name": namecontroller.text,
      "email": emailcontroller.text,
      "phone number": phonecontroller.text
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
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
    if (ref.read(uniqueId) == "") {
      unique = now.hour.toString() +
          now.minute.toString() +
          now.second.toString() +
          String.fromCharCodes(
              List.generate(5, (index) => r.nextInt(33) + 89)) +
          r.nextInt(1000).toString();
      var collectionreference = FirebaseFirestore.instance
          .collection("No. of Users")
          .doc(unique)
          .collection(ref.read(userTypeProvider).toString())
          .doc(FirebaseAuth.instance.currentUser!.email);

      return ref.read(userTypeProvider) == "Customer"
          ? collectionreference
              .set({"email": emailcontroller, "password": passwordcontroller})
          : ref.read(userTypeProvider) == "Shop_Owner"
              ? collectionreference.set({
                  "email": emailcontroller,
                  "password": passwordcontroller,
                  "seller_name": namecontroller,
                  "shop_name": shopname,
                  "gst": gstcontroller,
                  "address": addresscontroller,
                  "city": city,
                  "state": state
                })
              : ref.read(userTypeProvider) == "Self_Service"
                  ? collectionreference.set({
                      "email": emailcontroller,
                      "password": passwordcontroller,
                      "name": namecontroller,
                      "address": addresscontroller,
                      "city": city,
                      "state": state
                    })
                  : collectionreference.set({
                      "email": emailcontroller,
                      "password": passwordcontroller,
                      "seller_name": namecontroller,
                      "address": addresscontroller,
                      "city": city,
                      "state": state
                    }).then((value) => FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                      )
                          .then((value) async {
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.updateDisplayName(namecontroller.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the fields")));
    }
  }

  // Future<void> signInWithEmailPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     // Check if user exists in Firestore
  //     DocumentSnapshot<Map<String, dynamic>> userData = await _firestore
  //         .collection('users')
  //         .doc(userCredential.user!.uid)
  //         .get();

  //     if (userData.exists) {
  //       // User data exists in Firestore, do something (e.g., navigate to home screen)
  //       print('User data exists in Firestore: ${userData.data()}');
  //     } else {
  //       // User data does not exist in Firestore
  //       print('User data does not exist in Firestore');
  //     }
  //   } catch (e) {
  //     print('Error signing in: $e');
  //     // Handle sign-in errors (e.g., show error message to user)
  //   }
  // }

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

                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 10, right: 17),
                          //     child: TextButton(
                          //         style: ButtonStyle(
                          //           overlayColor: MaterialStateColor.resolveWith(
                          //               //no splash for textbutton
                          //               (states) => Colors.transparent),
                          //         ),
                          //         onPressed: () {},
                          //         child: const Text(
                          //           "Forget Password?",
                          //           style: TextStyle(color: Colors.black),
                          //         )),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: TextButton(
                              onPressed: () {
                                // if (emailcontroller.text.isNotEmpty &&
                                //     namecontroller.text.isNotEmpty &&
                                //     phonecontroller.text.isNotEmpty &&
                                //     passwordcontroller.text.isNotEmpty)
                                //  {
                                // senddata();
                                // FirebaseAuth.instance
                                //     .createUserWithEmailAndPassword(
                                //         email: emailcontroller.text,
                                //         password: passwordcontroller.text)
                                //     .then((value) async {
                                //   final user =
                                //       FirebaseAuth.instance.currentUser;
                                //   await user
                                //       ?.updateDisplayName(namecontroller.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                                // }

                                // else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //           content: Text(
                                //               "Please fill all the fields")));
                                // }
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
