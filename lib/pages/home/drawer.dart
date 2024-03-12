// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_commerce/pages/login/userType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../login/loginpage.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('No. of Users');

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

  @override
  void initState() {
    super.initState();
  }

  List icon = [
    Icons.email_rounded,
    Icons.location_on,
    Icons.phone_android_rounded,
    Icons.headset_mic,
    Icons.headset_mic,
    Icons.headset_mic,
  ];
  Map<String, String> data = {};

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
        child: FutureBuilder<DocumentSnapshot>(
            future: users
                .doc(ref.read(emailProvider).toString())
                .collection(ref.read(userTypeProvider).toString())
                .doc(ref.read(emailProvider).toString() +
                    ref.read(userTypeProvider).toString())
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator(
                    color: Colors.amber,
                  );
                }
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                ref.read(userTypeProvider).toString() == "Customer"
                    ? data = {
                        'email': data['email'],
                        'name': data['seller_name'],
                        'help': 'Help Center'
                      }
                    : ref.read(userTypeProvider).toString() == "Private_Seller"
                        ? data = {
                            'email': data['email'],
                            'name': data['name'],
                            'address': data['address'],
                            'city': data['city'],
                            'state': data['state'],
                            'help': 'Help Center'
                          }
                        : data = {
                            'email': data['email'],
                            'name': data['name'],
                            'address': data['address'],
                            'city': data['city'],
                            'state': data['state'],
                            'help': 'Help Center'
                          };

                return Column(children: [
                  Container(
                      height: height * 0.33,
                      width: width,
                      color: Colors.amber,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.04, bottom: height * 0.02),
                          child: Text(
                            data['seller_name'].toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
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
                                      child: Text(
                                        data['seller_name']
                                            .toString()
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 50, color: Colors.black),
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
                      ])),
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Iterable<dynamic> values = data.values;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Align(
                                child: data.length > 3 &&
                                        index == data.length - 4
                                    ? Column(
                                        children: [
                                          const Row(
                                            children: [Text("LOCATION")],
                                          ),
                                          Text(values.elementAt(index)),
                                          Text(values.elementAt(index + 1)),
                                          Text(values.elementAt(index + 2)),
                                        ],
                                      )
                                    : data.length > 3 &&
                                                index == data.length - 3 ||
                                            data.length > 3 &&
                                                index == data.length - 2
                                        ? null
                                        : ListTile(
                                            leading: Icon(icon[index]),
                                            title: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  values.elementAt(index),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                print(index);
                                              },
                                              icon: const Icon(Icons.edit),
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
                          onPressed: () async {
                            FirebaseAuth.instance.signOut();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('isLoggedIn');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          icon: const Icon(
                            Icons.logout_sharp,
                            color: Colors.white,
                          ),
                          label: const Text("Logout",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ]);
              }
              return const Text("loading");
            }));
  }
}
