// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/loginpage.dart';

class VendorRegister extends StatefulWidget {
  const VendorRegister({super.key});

  @override
  State<VendorRegister> createState() => _VendorRegisterState();
}

class _VendorRegisterState extends State<VendorRegister> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late double height, width;

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.amber,
            backgroundColor: Colors.amber.shade200,
          ));
        });

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text)
        .then((value) async {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('email', emailcontroller.text.trim());
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
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
                        padding: const EdgeInsets.only(top: 50.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
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
                            controller: emailcontroller,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                labelText: "NAME",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                                  Icons.phone_android_outlined,
                                  color: Colors.black,
                                ),
                                labelText: "PHONE NUMBER",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              signIn();
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
