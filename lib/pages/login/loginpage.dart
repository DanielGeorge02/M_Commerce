// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:m_commerce/pages/login/registerpage.dart';
import 'package:m_commerce/pages/login/userType.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late double height, width;

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
                Container(
                  height: height * .43,
                  decoration: const BoxDecoration(),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                          top: height * 0.01,
                        )),
                        const Image(
                          image: AssetImage("images/loginGif.gif"),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    height: height * 0.65,
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
                            padding: EdgeInsets.only(
                                top: width * 0.1, left: width * 0.05),
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
                                '  LOGIN',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          top: height * 0.07,
                        )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.06),
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.06),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.01, right: width * 0.04),
                            child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Forget Password?",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserType(
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text,
                                          )));
                            },
                            style: TextButton.styleFrom(
                                fixedSize: const Size(360, 50),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                backgroundColor: Colors.black),
                            child: const Text(
                              "Login to account",
                              style:
                                  TextStyle(letterSpacing: 0.5, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.03),
                          child: const Divider(
                            thickness: 0.6,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not a Member?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserType(
                                                register: true,
                                              )));
                                },
                                child: const Text("Sign Up")),
                          ],
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
    );
  }
}
