import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../login/loginpage.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('User_data');

  ImagePicker? image = ImagePicker();
  File? _image;

  Future getImage(ImageSource gallery) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  List icon = [
    Icons.person,
    Icons.email_rounded,
    Icons.location_on,
    Icons.phone_android_rounded,
    Icons.headset_mic
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
        child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.email).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List name = [
                  data['email'],
                  "Address",
                  data['phone number'],
                  "Help Center"
                ];

                return Column(children: [
                  Container(
                    height: height * 0.32,
                    width: width,
                    color: Colors.amber,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                        child: Text(
                          data['Name'].toString().toUpperCase(),
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: height * 0.20,
                            width: width * 0.38,
                            child: Stack(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        maxRadius: 100,
                                        minRadius: 10,
                                        backgroundImage:
                                            FileImage(File(_image!.path)),
                                      )
                                    : CircleAvatar(
                                        maxRadius: 80,
                                        minRadius: 70,
                                        backgroundColor: Colors.grey.shade300,
                                        // child: Icon(
                                        //   Icons.camera_alt,
                                        //   color: Colors.black,
                                        //   size: 35,
                                        // ),
                                        child: Text(
                                          data['Name']
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 50,
                                              color: Colors.black),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.255, top: height * 0.128),
                                  child: CircleAvatar(
                                    maxRadius: 24,
                                    minRadius: 10,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () =>
                                          getImage(ImageSource.gallery),
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 28,
                                        color: Colors.black,
                                      ),
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: name.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Align(
                                child: ListTile(
                                  leading: Icon(
                                    icon[index],
                                    color: Colors.amber,
                                    size: 30,
                                  ),
                                  title: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(name[index],
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center),
                                  ),
                                  minVerticalPadding: 5,
                                ),
                              ),
                            );
                          })),
                  SizedBox(
                    height: height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: ElevatedButton.icon(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          icon: const Icon(Icons.logout_sharp),
                          label: const Text("Logout")),
                    ),
                  ),
                ]);
              }

              return const Text("loading");
            }));
  }
}
