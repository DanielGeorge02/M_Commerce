// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shoppage extends StatefulWidget {
  Shoppage({super.key, this.shop, this.addr});
  var shop;
  var addr;
  @override
  State<Shoppage> createState() => _ShoppageState();
}

class _ShoppageState extends State<Shoppage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(widget.shop!),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                height: 220,
                width: width,
                color: Colors.blueAccent,
              ),
              Container(
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    widget.addr!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Seller_req")
                        .doc("A3YtV51DsJGf7ruoFV6x")
                        .collection("item")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Text("Loading");
                      }
                      return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.73),
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            if (widget.shop ==
                                documentSnapshot['SnameController']) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(13)),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 160,
                                        color: Colors.white,
                                        child: CachedNetworkImage(
                                          imageUrl: documentSnapshot["image"],
                                        )),
                                    Text(documentSnapshot["PnameController"]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(documentSnapshot["MrpController"]),
                                        Text(documentSnapshot[
                                            "PpriceController"])
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                            return null;
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
