import 'package:flutter/material.dart';
import 'package:m_commerce/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  height: height * .28,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                          top: 30,
                        )),
                        Row(
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 10)),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(left: 10, top: 35)),
                            Text(
                              "Sign up or Login to see what we have for you",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Container(
                    height: height * .72,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
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
                                    Colors.grey.shade700,
                                    Colors.grey.shade100
                                  ]),
                                  border: Border(
                                      left: BorderSide(
                                          color: Colors.grey.shade900,
                                          width: 5))),
                              child: const Text(
                                '  LOGIN',
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey.shade700,
                                ),
                                labelText: "EMAIL ADDRESS",
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade700),
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
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey.shade700,
                                ),
                                labelText: "PASSWORD",
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade700),
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
                            padding: const EdgeInsets.only(top: 10, right: 17),
                            child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      //no splash for textbutton
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
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
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
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Divider(
                            thickness: 0.6,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Not a Member?"),
                            TextButton(
                                onPressed: () {}, child: const Text("Sign Up")),
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
