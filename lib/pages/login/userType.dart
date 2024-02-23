// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use, file_names, avoid_print, use_build_context_synchronously

import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/pages/home/home.dart';
import 'package:m_commerce/pages/login/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userTypeProvider = StateProvider<String>((ref) => "");
final uniqueId = StateProvider<String>((ref) => "");

class UserType extends ConsumerStatefulWidget {
  var email;
  var password;
  var register;

  UserType({super.key, this.email, this.password, this.register});

  @override
  ConsumerState<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends ConsumerState<UserType>
    with TickerProviderStateMixin {
  int index = 0;

  DateTime now = DateTime.now();
  var r = Random();

  String userType = "";
  bool register = false;
  @override
  void initState() {
    super.initState();
    register = widget.register;
    userType = ref.read(userTypeProvider);
  }

  Future signIn(String userType) async {
    print(userType);
    print("..................................................");
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection("No. of Users")
        .doc(widget.email + userType)
        .get();

    if (!userData.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not exists!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
              backgroundColor: Colors.amber.shade200,
            ));
          });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }

    //   ref.read(uniqueId) == ""
    //       ? await FirebaseAuth.instance
    //           .signInWithEmailAndPassword(
    //               email: widget.email.trim(), password: widget.password)
    //           .then((value) async {
    //           var collectionreference = FirebaseFirestore.instance
    //               .collection("No. of Users")
    //               .doc(unique)
    //               .collection(ref.read(userTypeProvider).toString())
    //               .doc(FirebaseAuth.instance.currentUser!.email);

    //           return collectionreference
    //               .set({"email": widget.email, "password": widget.password});
    //         }).then((value) {
    //           Navigator.of(context).pop();
    //           Navigator.push(
    //               context, MaterialPageRoute(builder: (context) => const Home()));
    //         })
    //       : await FirebaseAuth.instance
    //           .signInWithEmailAndPassword(
    //               email: widget.email.trim(), password: widget.password)
    //           .then((value) async {
    //           var collectionreference = FirebaseFirestore.instance
    //               .collection("No. of Users")
    //               .doc(ref.read(uniqueId))
    //               .collection(ref.read(userTypeProvider).toString())
    //               .doc(FirebaseAuth.instance.currentUser!.email);

    //           return collectionreference
    //               .set({"email": widget.email, "password": widget.password});
    //         }).then((value) {
    //           Navigator.of(context).pop();
    //           Navigator.push(
    //               context, MaterialPageRoute(builder: (context) => const Home()));
    //         });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      color: Colors.white,
      child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
            spawnMaxRadius: 20,
            spawnMinSpeed: 50,
            particleCount: 50,
            spawnMaxSpeed: 80,
            minOpacity: 0.7,
            maxOpacity: 0.9,
            baseColor: Colors.black,
          )),
          vsync: this,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                register == false
                    ? Text("LOGIN AS",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w800))
                    : Text("REGISTER AS",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w800)),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 0.01),
                                  child: Text("Shop Owner",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    ref.watch(userTypeProvider.notifier).state =
                                        "Shop_Owner";
                                    if (index != 1) {
                                      index = 1;
                                    } else {
                                      index = 0;
                                    }
                                    setState(() {});
                                    print(index);
                                  },
                                  child: index == 1
                                      ? Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              height: height * 0.2,
                                              width: height * 0.2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          height * 0.2),
                                                  color: const Color.fromARGB(
                                                      255, 123, 117, 117)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.09,
                                                    right: width * 0.09,
                                                    top: width * 0.07),
                                                child: SvgPicture.asset(
                                                  "images/shopowner.svg",
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.1,
                                              height: width * 0.1,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    width * 0.1,
                                                  )),
                                              child: const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: height * 0.2,
                                          width: height * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.2),
                                              color: Colors.amber),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.09,
                                                right: width * 0.09,
                                                top: width * 0.07),
                                            child: SvgPicture.asset(
                                              "images/shopowner.svg",
                                            ),
                                          ),
                                        )),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                    "Sell or Rent your products\n from your shop",
                                    style: GoogleFonts.poppins(fontSize: 11),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(bottom: height * 0.01),
                                  child: Text("Self Service",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ref.watch(userTypeProvider.notifier).state =
                                      "Self_Service";
                                  if (index != 2) {
                                    index = 2;
                                  } else {
                                    index = 0;
                                  }
                                  setState(() {});
                                  print(index);
                                },
                                child: index == 2
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            height: height * 0.2,
                                            width: height * 0.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        height * 0.2),
                                                color: const Color.fromARGB(
                                                    255, 123, 117, 117)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.09,
                                                  right: width * 0.09,
                                                  top: width * 0.07),
                                              child: SvgPicture.asset(
                                                "images/selfservice.svg",
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.1,
                                            height: width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  width * 0.1,
                                                )),
                                            child: const Icon(Icons.check,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        height: height * 0.2,
                                        width: height * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                height * 0.2),
                                            color: Colors.amber),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.1,
                                                right: width * 0.1,
                                                top: width * 0.035),
                                            child: SvgPicture.asset(
                                                "images/selfservice.svg")),
                                      ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.01),
                                  child: Text(
                                      "Self profession from your\n home",
                                      style: GoogleFonts.poppins(fontSize: 11),
                                      textAlign: TextAlign.center),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.01),
                                child: Text("Customer",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref.watch(userTypeProvider.notifier).state =
                                    "Customer";
                                if (index != 3) {
                                  index = 3;
                                } else {
                                  index = 0;
                                }
                                setState(() {});
                                print(index);
                              },
                              child: index == 3
                                  ? Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          height: height * 0.2,
                                          width: height * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.2),
                                              color: const Color.fromARGB(
                                                  255, 123, 117, 117)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.09,
                                                right: width * 0.09,
                                                top: width * 0.07),
                                            child: SvgPicture.asset(
                                              "images/user.svg",
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.1,
                                          height: width * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                width * 0.1,
                                              )),
                                          child: const Icon(Icons.check,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height: height * 0.2,
                                      width: height * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              height * 0.2),
                                          color: Colors.amber),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.08,
                                            right: width * 0.08,
                                            top: width * 0.045),
                                        child:
                                            SvgPicture.asset("images/user.svg"),
                                      ),
                                    ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.01),
                                child: Text("Buy Products\n       ",
                                    style: GoogleFonts.poppins(fontSize: 11),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.01),
                                child: Text("Personal Products",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            InkWell(
                              onTap: (() {
                                ref.watch(userTypeProvider.notifier).state =
                                    "Private_Seller";
                                if (index != 4) {
                                  index = 4;
                                } else {
                                  index = 0;
                                }
                                setState(() {});
                                print(index);
                              }),
                              child: index == 4
                                  ? Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          height: height * 0.2,
                                          width: height * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      height * 0.2),
                                              color: const Color.fromARGB(
                                                  255, 123, 117, 117)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.09,
                                                right: width * 0.09,
                                                top: width * 0.07),
                                            child: SvgPicture.asset(
                                              "images/sell.svg",
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.1,
                                          height: width * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                width * 0.1,
                                              )),
                                          child: const Icon(Icons.check,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height: height * 0.2,
                                      width: height * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              height * 0.2),
                                          color: Colors.amber),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.08,
                                            right: width * 0.08,
                                            top: width * 0.04),
                                        child:
                                            SvgPicture.asset("images/sell.svg"),
                                      ),
                                    ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.01),
                                child: Text(
                                    "Sell or Rent your products\n from your Home",
                                    style: GoogleFonts.poppins(fontSize: 11),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                index != 0 && register == false
                    ? SizedBox(
                        width: width * 0.2,
                        child: TextButton(
                          onPressed: () {
                            signIn(ref.read(userTypeProvider).toString());
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.white))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.amber)),
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      )
                    : index != 0 && register == true
                        ? SizedBox(
                            width: width * 0.2,
                            child: TextButton(
                              onPressed: () {
                                // signIn(ref.read(userTypeProvider).toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register(
                                              type: ref.read(userTypeProvider),
                                            )));
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color: Colors.white))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.amber)),
                              child: Text(
                                "Register",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          )
                        : Container()
              ])),
    ));
  }
}
