// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  late double height, width;
  senddata() async {

    final CollectionReference = FirebaseFirestore.instance
        .collection("User_data")
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

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
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
                                      builder: (context) => const LoginPage()));
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage("images/registerimage.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    height: height * 0.77,
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
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                          top: 50,
                        )),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                labelText: "NAME",
                                labelStyle: const TextStyle(color: Colors.black),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                fillColor: Colors.grey.shade200,
                                filled: true),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: phonecontroller,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_android_outlined,
                                  color: Colors.black,
                                ),
                                labelText: "PHONE NUMBER",
                                labelStyle: const TextStyle(color: Colors.black),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                fillColor: Colors.grey.shade200,
                                filled: true),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                labelText: "EMAIL ADDRESS",
                                labelStyle: const TextStyle(color: Colors.black),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                fillColor: Colors.grey.shade200,
                                filled: true),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                labelText: "PASSWORD",
                                labelStyle: const TextStyle(color: Colors.black),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                fillColor: Colors.grey.shade200,
                                filled: true),
                          ),
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
                          padding: const EdgeInsets.only(top: 30),
                          child: TextButton(
                            onPressed: () {
                              if (emailcontroller.text.isNotEmpty &&
                                  namecontroller.text.isNotEmpty &&
                                  phonecontroller.text.isNotEmpty &&
                                  passwordcontroller.text.isNotEmpty) {
                                senddata();
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text)
                                    .then((value) async {
                                  final user =   
                                      FirebaseAuth.instance.currentUser;
                                  await user
                                      ?.updateDisplayName(namecontroller.text);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()));
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please fill all the fields")));
                              }
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
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 30),
                        //   child: Divider(
                        //     thickness: 0.6,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text("Not a Member?"),
                        //     TextButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => Homepage()));
                        //         },
                        //         child: const Text("Sign Up")),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
